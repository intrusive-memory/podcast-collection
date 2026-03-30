#!/bin/bash
# Extract the screenplay content (text.md) from a .highland file
# Usage: extract_screenplay.sh <highland-file> [output-file]

set -e

HIGHLAND_FILE="$1"
OUTPUT_FILE="${2:-screenplay.fountain}"

if [[ ! -f "$HIGHLAND_FILE" ]]; then
    echo "Error: File not found: $HIGHLAND_FILE" >&2
    exit 1
fi

if [[ ! "$HIGHLAND_FILE" =~ \.highland$ ]]; then
    echo "Error: File must have .highland extension" >&2
    exit 1
fi

# Find the text.md file inside the archive (it's in a .textbundle directory)
# List files and extract the .textbundle path
TEXTBUNDLE_PATH=$(unzip -Z1 "$HIGHLAND_FILE" | grep '\.textbundle/text\.md$' | head -1)

if [[ -z "$TEXTBUNDLE_PATH" ]]; then
    echo "Error: No text.md file found in .textbundle directory" >&2
    exit 1
fi

# Extract text.md to the output file
unzip -p "$HIGHLAND_FILE" "$TEXTBUNDLE_PATH" > "$OUTPUT_FILE"

echo "Extracted screenplay to: $OUTPUT_FILE" >&2
