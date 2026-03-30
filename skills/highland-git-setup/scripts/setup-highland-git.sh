#!/usr/bin/env bash
# Configure git to produce meaningful diffs for .highland screenplay files.
# Highland files are zip archives containing Fountain-formatted text.
# This script sets up both global gitconfig and local .gitattributes.

set -euo pipefail

# --- Global gitconfig: register the "zip" diff driver ---
if git config --global diff.zip.textconv >/dev/null 2>&1; then
    echo "✓ diff.zip.textconv already configured in global gitconfig"
else
    git config --global diff.zip.textconv "unzip -c -a"
    echo "✓ Added diff.zip.textconv = 'unzip -c -a' to global gitconfig"
fi

# --- Local .gitattributes: associate .highland with zip diff driver ---
GITATTR=".gitattributes"

if [ -f "$GITATTR" ] && grep -q '^\*\.highland' "$GITATTR" 2>/dev/null; then
    echo "✓ .gitattributes already has .highland rule"
else
    echo '*.highland diff=zip' >> "$GITATTR"
    echo "✓ Added '*.highland diff=zip' to $GITATTR"
fi

# --- Optional: .gitattributes for binary merge strategy ---
if [ -f "$GITATTR" ] && grep -q '^\*\.highland.*merge=binary' "$GITATTR" 2>/dev/null; then
    echo "✓ .gitattributes already has .highland binary merge rule"
else
    # Don't duplicate if we just added the diff line — update it instead
    if grep -q '^\*\.highland diff=zip$' "$GITATTR" 2>/dev/null; then
        sed -i '' 's/^\*\.highland diff=zip$/\*\.highland diff=zip merge=binary/' "$GITATTR"
        echo "✓ Updated .highland rule with merge=binary strategy"
    fi
fi

echo ""
echo "Done. Git will now show text diffs for .highland files."
echo "Test with: git diff <commit> -- path/to/file.highland"
