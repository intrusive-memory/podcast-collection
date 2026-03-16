#!/bin/bash
# Validate an FCPXML file against the v1.11 DTD
# Usage: validate_fcpxml.sh <path-to-fcpxml-file>
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DTD_PATH="$SCRIPT_DIR/../references/fcpxml_1.11.dtd"
INPUT_FILE="${1:?Usage: validate_fcpxml.sh <fcpxml-file>}"

if [ ! -f "$INPUT_FILE" ]; then
    echo "ERROR: File not found: $INPUT_FILE" >&2
    exit 1
fi

if [ ! -f "$DTD_PATH" ]; then
    echo "ERROR: DTD not found at $DTD_PATH" >&2
    echo "Looking for alternate DTD locations..." >&2
    for alt in \
        "$HOME/Projects/pipeline-neo/Sources/PipelineNeo/FCPXML DTDs/Final_Cut_Pro_XML_DTD_version_1.11.dtd" \
        "/tmp/fcpxml_1.11.dtd"; do
        if [ -f "$alt" ]; then
            DTD_PATH="$alt"
            echo "Found DTD at: $DTD_PATH" >&2
            break
        fi
    done
    if [ ! -f "$DTD_PATH" ]; then
        echo "ERROR: No DTD found. Cannot validate." >&2
        exit 1
    fi
fi

# Create temp file with SYSTEM DTD reference
TEMP_FILE=$(mktemp /tmp/fcpxml_validate_XXXXXX.fcpxml)
trap 'rm -f "$TEMP_FILE"' EXIT

sed "s|<!DOCTYPE fcpxml>|<!DOCTYPE fcpxml SYSTEM \"$DTD_PATH\">|" "$INPUT_FILE" > "$TEMP_FILE"

echo "Validating $INPUT_FILE against FCPXML v1.11 DTD..."
if xmllint --valid --noout "$TEMP_FILE" 2>&1; then
    echo "PASS: $INPUT_FILE is valid FCPXML v1.11"
    exit 0
else
    echo ""
    echo "FAIL: $INPUT_FILE has DTD validation errors"
    exit 1
fi
