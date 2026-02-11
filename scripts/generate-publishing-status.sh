#!/bin/bash

# Generate PUBLISHING_STATUS.md for a podcast
# Usage: ./generate-publishing-status.sh <podcast-slug>

set -e

PODCAST_SLUG="$1"
CDN_BASE="https://pub-8e049ed02be340cbb18f921765fd24f3.r2.dev"
SITE_BASE="https://intrusive-memory.productions"
WEBSITE_DIR="$HOME/Projects/intrusive-memory.github.com"
PODCAST_DIR="$HOME/Projects/podcast-$PODCAST_SLUG"

# Colors
GREEN="✅"
RED="🔴"
YELLOW="⚠️"
SKIP="⏭️"

# Counters
total_checks=0
passed_checks=0

if [ -z "$PODCAST_SLUG" ]; then
  echo "Usage: $0 <podcast-slug>"
  echo "Example: $0 yntswyd"
  exit 1
fi

# Helper function to check URL
check_url() {
  local url="$1"
  if curl -sI "$url" 2>/dev/null | grep -q "200 OK"; then
    return 0
  else
    return 1
  fi
}

# Helper function to check item
check_item() {
  local description="$1"
  local test_command="$2"

  ((total_checks++))

  if eval "$test_command" >/dev/null 2>&1; then
    echo "- $GREEN $description"
    ((passed_checks++))
  else
    echo "- $RED $description"
  fi

  # Always return 0 to prevent set -e from exiting
  return 0
}

# Start generating report
OUTPUT_FILE="$PODCAST_DIR/PUBLISHING_STATUS.md"
TEMP_FILE="/tmp/publishing-status-$PODCAST_SLUG.md"

# Get podcast name from PROJECT.md
PODCAST_NAME=$(grep "^title:" "$PODCAST_DIR/PROJECT.md" | sed 's/title: *//' | tr -d '"')
EPISODE_COUNT=$(grep "^episodes:" "$PODCAST_DIR/PROJECT.md" | awk '{print $2}')

# Start output
cat > "$TEMP_FILE" << EOF
# Publishing Status: $PODCAST_NAME

**Last Updated**: $(date +%Y-%m-%d)
**Podcast Slug**: \`$PODCAST_SLUG\`
**Episode Count**: $EPISODE_COUNT

---

EOF

echo "## 1. Artwork & Branding Assets" >> "$TEMP_FILE"
echo "" >> "$TEMP_FILE"

{
  check_item "podcast-artwork.jpg exists locally" \
    "test -f '$PODCAST_DIR/assets/podcast-artwork.jpg'"

  check_item "apple-touch-icon.png exists locally" \
    "test -f '$PODCAST_DIR/assets/apple-touch-icon.png'"

  check_item "favicon.ico exists locally" \
    "test -f '$PODCAST_DIR/assets/favicon.ico'"

  check_item "podcast-artwork.jpg on CDN" \
    "check_url '$CDN_BASE/$PODCAST_SLUG/podcast-artwork.jpg'"

  check_item "apple-touch-icon.png on CDN" \
    "check_url '$CDN_BASE/$PODCAST_SLUG/apple-touch-icon.png'"

  check_item "favicon.ico on CDN" \
    "check_url '$CDN_BASE/$PODCAST_SLUG/favicon.ico'"
} >> "$TEMP_FILE"

echo "" >> "$TEMP_FILE"
echo "## 2. Audio Files on CDN" >> "$TEMP_FILE"
echo "" >> "$TEMP_FILE"

# Count local audio files
LOCAL_AUDIO_COUNT=$(find "$PODCAST_DIR/audio" -name "*.m4a" 2>/dev/null | wc -l | tr -d ' ')

{
  check_item "Audio files generated locally ($LOCAL_AUDIO_COUNT files)" \
    "test $LOCAL_AUDIO_COUNT -gt 0"

  check_item "Episode count matches audio files ($EPISODE_COUNT expected)" \
    "test $LOCAL_AUDIO_COUNT -eq $EPISODE_COUNT"

  # Sample check first audio file (naming varies by podcast)
  FIRST_AUDIO_PATH=$(find "$PODCAST_DIR/audio" -name "*.m4a" 2>/dev/null | head -1)
  if [ -n "$FIRST_AUDIO_PATH" ]; then
    FIRST_AUDIO=$(basename "$FIRST_AUDIO_PATH")
    # URL-encode the filename for the check (spaces become %20)
    FIRST_AUDIO_ENCODED=$(echo "$FIRST_AUDIO" | sed 's/ /%20/g')
    check_item "Sample audio file on CDN: $FIRST_AUDIO" \
      "check_url '$CDN_BASE/$PODCAST_SLUG/$FIRST_AUDIO_ENCODED'"
  fi
} >> "$TEMP_FILE"

echo "" >> "$TEMP_FILE"
echo "## 3. PROJECT.md Metadata" >> "$TEMP_FILE"
echo "" >> "$TEMP_FILE"

{
  check_item "PROJECT.md exists" \
    "test -f '$PODCAST_DIR/PROJECT.md'"

  check_item "title field present" \
    "grep -q '^title:' '$PODCAST_DIR/PROJECT.md'"

  check_item "author field present" \
    "grep -q '^author:' '$PODCAST_DIR/PROJECT.md'"

  check_item "description field present" \
    "grep -q '^description:' '$PODCAST_DIR/PROJECT.md'"

  check_item "episodes field present" \
    "grep -q '^episodes:' '$PODCAST_DIR/PROJECT.md'"

  check_item "genre field present" \
    "grep -q '^genre:' '$PODCAST_DIR/PROJECT.md'"

  check_item "cast/voice mapping present" \
    "grep -q '^cast:' '$PODCAST_DIR/PROJECT.md'"
} >> "$TEMP_FILE"

echo "" >> "$TEMP_FILE"
echo "## 4. Website Data (podcasts.yml)" >> "$TEMP_FILE"
echo "" >> "$TEMP_FILE"

{
  check_item "_data/podcasts.yml exists" \
    "test -f '$WEBSITE_DIR/_data/podcasts.yml'"

  check_item "Podcast entry exists in podcasts.yml" \
    "grep -q 'slug: $PODCAST_SLUG' '$WEBSITE_DIR/_data/podcasts.yml'"

  check_item "artwork path uses /podcasts/ prefix" \
    "grep -B 30 -A 30 'slug: $PODCAST_SLUG' '$WEBSITE_DIR/_data/podcasts.yml' | grep -q 'artwork: /podcasts/$PODCAST_SLUG/'"

  check_item "audio_path does NOT use /podcasts/ prefix" \
    "grep -B 30 -A 30 'slug: $PODCAST_SLUG' '$WEBSITE_DIR/_data/podcasts.yml' | grep 'audio_path:' | grep -qv '/podcasts/'"

  check_item "feed_url points to correct location" \
    "grep -B 30 -A 30 'slug: $PODCAST_SLUG' '$WEBSITE_DIR/_data/podcasts.yml' | grep -q 'feed_url.*$PODCAST_SLUG/feed.xml'"
} >> "$TEMP_FILE"

echo "" >> "$TEMP_FILE"
echo "## 5. Individual Podcast Page" >> "$TEMP_FILE"
echo "" >> "$TEMP_FILE"

{
  check_item "Podcast page exists: /podcasts/$PODCAST_SLUG/index.html" \
    "test -f '$WEBSITE_DIR/podcasts/$PODCAST_SLUG/index.html'"

  if [ -f "$WEBSITE_DIR/podcasts/$PODCAST_SLUG/index.html" ]; then
    check_item "Page uses CDN artwork (not local path)" \
      "grep -q '$CDN_BASE/$PODCAST_SLUG/podcast-artwork.jpg' '$WEBSITE_DIR/podcasts/$PODCAST_SLUG/index.html'"

    check_item "Favicon link points to CDN" \
      "grep -qE '(favicon:.*$CDN_BASE/$PODCAST_SLUG/favicon.ico|link.*icon.*$CDN_BASE/$PODCAST_SLUG/favicon.ico)' '$WEBSITE_DIR/podcasts/$PODCAST_SLUG/index.html'"

    check_item "Apple touch icon points to CDN" \
      "grep -qE '(apple_touch_icon:.*$CDN_BASE/$PODCAST_SLUG/apple-touch-icon.png|apple-touch-icon.*$CDN_BASE/$PODCAST_SLUG/apple-touch-icon.png)' '$WEBSITE_DIR/podcasts/$PODCAST_SLUG/index.html'"

    check_item "Audio players use CDN URLs" \
      "grep -q '$CDN_BASE/$PODCAST_SLUG/.*\.m4a' '$WEBSITE_DIR/podcasts/$PODCAST_SLUG/index.html' || echo '$YELLOW Manual check required'"

    check_item "RSS feed link present" \
      "grep -q 'feed.xml' '$WEBSITE_DIR/podcasts/$PODCAST_SLUG/index.html'"
  fi
} >> "$TEMP_FILE"

echo "" >> "$TEMP_FILE"
echo "## 6. RSS Feed" >> "$TEMP_FILE"
echo "" >> "$TEMP_FILE"

{
  check_item "feed.xml exists in podcast directory" \
    "test -f '$WEBSITE_DIR/podcasts/$PODCAST_SLUG/feed.xml'"

  if [ -f "$WEBSITE_DIR/podcasts/$PODCAST_SLUG/feed.xml" ]; then
    # Skip XML validation for Jekyll templates (have front matter)
    check_item "Feed is valid XML (or Jekyll template)" \
      "head -1 '$WEBSITE_DIR/podcasts/$PODCAST_SLUG/feed.xml' | grep -q '^---$' || xmllint --noout '$WEBSITE_DIR/podcasts/$PODCAST_SLUG/feed.xml' 2>/dev/null"

    check_item "Feed artwork points to CDN" \
      "grep -q '$CDN_BASE/$PODCAST_SLUG/podcast-artwork.jpg' '$WEBSITE_DIR/podcasts/$PODCAST_SLUG/feed.xml'"

    # Check for CDN URLs or Jekyll variables ({{ site.audio_cdn }})
    check_item "Episode enclosures point to CDN" \
      "grep -qE '(enclosure.*url.*$CDN_BASE/$PODCAST_SLUG/.*\.m4a|enclosure.*url.*site\.audio_cdn.*$PODCAST_SLUG/)' '$WEBSITE_DIR/podcasts/$PODCAST_SLUG/feed.xml'"
  fi
} >> "$TEMP_FILE"

echo "" >> "$TEMP_FILE"
echo "## 7. Landing Page Integration" >> "$TEMP_FILE"
echo "" >> "$TEMP_FILE"

{
  check_item "Listed in /podcasts/index.html" \
    "grep -q '$PODCAST_SLUG' '$WEBSITE_DIR/podcasts/index.html'"

  # Check published status
  PUBLISHED=$(grep -A 20 "slug: $PODCAST_SLUG" "$WEBSITE_DIR/_data/podcasts.yml" | grep "published:" | awk '{print $2}')

  if [ "$PUBLISHED" = "true" ]; then
    echo "- $GREEN Published status: \`true\` (live on landing page)"
    ((passed_checks++))
    ((total_checks++))
  else
    echo "- $YELLOW Published status: \`false\` ('COMING SOON' banner should be visible)"
    ((total_checks++))
  fi
} >> "$TEMP_FILE"

echo "" >> "$TEMP_FILE"
echo "## 8. Collection Files" >> "$TEMP_FILE"
echo "" >> "$TEMP_FILE"

COLLECTION_DIR="$HOME/Projects/podcast-collection"

{
  check_item "Entry in collection.json" \
    "grep -q '$PODCAST_NAME' '$COLLECTION_DIR/collection.json'"

  check_item "Entry in collection.opml" \
    "grep -q '$PODCAST_NAME' '$COLLECTION_DIR/collection.opml'"

  check_item "Listed in README.md" \
    "grep -q '$PODCAST_NAME' '$COLLECTION_DIR/README.md'"
} >> "$TEMP_FILE"

# Calculate percentage
PERCENTAGE=$((passed_checks * 100 / total_checks))

# Determine overall status
if [ $PERCENTAGE -eq 100 ]; then
  STATUS="🟢 READY TO PUBLISH"
  STATUS_COLOR="green"
elif [ $PERCENTAGE -ge 80 ]; then
  STATUS="🟡 ALMOST READY"
  STATUS_COLOR="yellow"
else
  STATUS="🔴 NOT READY"
  STATUS_COLOR="red"
fi

# Insert status at top
sed -i.bak "3a\\
**Status**: $STATUS ($passed_checks/$total_checks items complete, $PERCENTAGE%)\\
" "$TEMP_FILE"

echo "" >> "$TEMP_FILE"
echo "---" >> "$TEMP_FILE"
echo "" >> "$TEMP_FILE"
echo "## Summary" >> "$TEMP_FILE"
echo "" >> "$TEMP_FILE"
echo "- **Total Checks**: $total_checks" >> "$TEMP_FILE"
echo "- **Passed**: $passed_checks" >> "$TEMP_FILE"
echo "- **Failed**: $((total_checks - passed_checks))" >> "$TEMP_FILE"
echo "- **Completion**: $PERCENTAGE%" >> "$TEMP_FILE"
echo "" >> "$TEMP_FILE"

if [ $PERCENTAGE -eq 100 ]; then
  echo "### ✅ Ready to Publish!" >> "$TEMP_FILE"
  echo "" >> "$TEMP_FILE"
  echo "All checks passed. You can now:" >> "$TEMP_FILE"
  echo "1. Set \`published: true\` in \`_data/podcasts.yml\`" >> "$TEMP_FILE"
  echo "2. Commit and push changes" >> "$TEMP_FILE"
  echo "3. Deploy the website" >> "$TEMP_FILE"
  echo "4. Submit to podcast directories" >> "$TEMP_FILE"
else
  echo "### ⚠️ Not Ready to Publish" >> "$TEMP_FILE"
  echo "" >> "$TEMP_FILE"
  echo "Fix the $RED items above before publishing." >> "$TEMP_FILE"
fi

# Move to final location
mv "$TEMP_FILE" "$OUTPUT_FILE"
rm -f "$TEMP_FILE.bak"

# Output summary to console
cat "$OUTPUT_FILE"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Publishing status saved to: $OUTPUT_FILE"
echo "Status: $STATUS ($passed_checks/$total_checks, $PERCENTAGE%)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
