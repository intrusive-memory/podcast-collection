#!/bin/bash
# List all files in a .highland archive
# Usage: list_contents.sh <highland-file>

set -e

HIGHLAND_FILE="$1"

if [[ ! -f "$HIGHLAND_FILE" ]]; then
    echo "Error: File not found: $HIGHLAND_FILE" >&2
    exit 1
fi

if [[ ! "$HIGHLAND_FILE" =~ \.highland$ ]]; then
    echo "Error: File must have .highland extension" >&2
    exit 1
fi

echo "Contents of: $HIGHLAND_FILE"
echo "---"
unzip -l "$HIGHLAND_FILE"
