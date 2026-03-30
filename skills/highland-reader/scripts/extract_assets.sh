#!/bin/bash
# Extract all assets from a .highland file to a directory
# Usage: extract_assets.sh <highland-file> [output-directory]

set -e

HIGHLAND_FILE="$1"
OUTPUT_DIR="${2:-./highland-assets}"

if [[ ! -f "$HIGHLAND_FILE" ]]; then
    echo "Error: File not found: $HIGHLAND_FILE" >&2
    exit 1
fi

if [[ ! "$HIGHLAND_FILE" =~ \.highland$ ]]; then
    echo "Error: File must have .highland extension" >&2
    exit 1
fi

# Find the .textbundle directory name
TEXTBUNDLE_DIR=$(unzip -Z1 "$HIGHLAND_FILE" | grep '\.textbundle/' | head -1 | cut -d'/' -f1)

if [[ -z "$TEXTBUNDLE_DIR" ]]; then
    echo "Error: No .textbundle directory found in archive" >&2
    exit 1
fi
TEXTBUNDLE_DIR="${TEXTBUNDLE_DIR}/"

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Extract the entire .textbundle to output directory
unzip -q "$HIGHLAND_FILE" -d "$OUTPUT_DIR"

echo "Extracted all contents to: $OUTPUT_DIR/$TEXTBUNDLE_DIR" >&2
echo "Assets directory: $OUTPUT_DIR/${TEXTBUNDLE_DIR}assets/" >&2
