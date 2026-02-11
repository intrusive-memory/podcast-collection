#!/bin/bash
# Generate OPML file from podcast collection JSON

set -euo pipefail

COLLECTION_FILE="${1:-collection.json}"

if [ ! -f "$COLLECTION_FILE" ]; then
    echo "Error: Collection file not found: $COLLECTION_FILE" >&2
    exit 1
fi

# Extract collection name and podcasts using jq
COLLECTION_NAME=$(jq -r '.name' "$COLLECTION_FILE")
GENERATED_AT=$(date -u +"%a, %d %b %Y %H:%M:%S GMT")

cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<opml version="2.0">
  <head>
    <title>$COLLECTION_NAME</title>
    <dateCreated>$GENERATED_AT</dateCreated>
  </head>
  <body>
EOF

# Extract each podcast and convert to OPML outline
jq -r '.podcasts[] | @json' "$COLLECTION_FILE" | while IFS= read -r podcast; do
    NAME=$(echo "$podcast" | jq -r '.name')
    FEED_URL=$(echo "$podcast" | jq -r '.feedURL')
    WEBSITE_URL=$(echo "$podcast" | jq -r '.websiteURL // ""')
    SUMMARY=$(echo "$podcast" | jq -r '.summary // ""')

    echo "    <outline"
    echo "      text=\"$NAME\""
    echo "      type=\"rss\""
    echo "      xmlUrl=\"$FEED_URL\""
    [ -n "$WEBSITE_URL" ] && echo "      htmlUrl=\"$WEBSITE_URL\""
    [ -n "$SUMMARY" ] && echo "      description=\"$SUMMARY\""
    echo "    />"
done

cat <<EOF
  </body>
</opml>
EOF
