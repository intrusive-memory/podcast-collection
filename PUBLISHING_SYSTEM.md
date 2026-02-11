# Podcast Publishing System

A comprehensive system for validating and publishing podcasts to the Intrusive Memory collection.

## Overview

Each podcast goes through a checklist of validation items before being published. The system ensures:

1. **Assets** (artwork, icons) are generated and on CDN
2. **Audio files** are generated and accessible on CDN
3. **Metadata** is complete and consistent across all files
4. **Website pages** are complete with working audio players
5. **RSS feeds** are valid and point to CDN resources
6. **Landing page** shows correct "COMING SOON" status

## Files

- `PODCAST_PUBLISHING_CHECKLIST.md` - Master checklist (reference)
- `PUBLISHING_SYSTEM.md` - This file (documentation)
- `scripts/generate-publishing-status.sh` - Validation script
- `{podcast-repo}/PUBLISHING_STATUS.md` - Per-podcast status report

## Publishing Workflow

### 1. Generate Publishing Status

Run the validation script for your podcast:

```bash
cd ~/Projects/podcast-collection
./scripts/generate-publishing-status.sh yntswyd
```

This creates `PUBLISHING_STATUS.md` in the podcast repository showing:
- ✅ Green: Item complete and verified
- 🔴 Red: Item incomplete or failed
- ⚠️ Yellow: Warning or needs review
- Overall completion percentage

### 2. Fix Issues

Review `PUBLISHING_STATUS.md` and address all 🔴 red items:

**Common fixes:**
- Upload missing artwork to CDN
- Generate missing audio files
- Update metadata fields in PROJECT.md
- Fix URL paths in website pages
- Update podcasts.yml entry

### 3. Validate Website Pages

Ensure the individual podcast page has:
- ✅ All episodes listed
- ✅ Audio players for each episode
- ✅ Players load from CDN (not local paths)
- ✅ Artwork from CDN
- ✅ Icons from CDN

Location: `../intrusive-memory.github.com/podcasts/{slug}/index.html`

### 4. Check Landing Page Status

In `../intrusive-memory.github.com/_data/podcasts.yml`:

**If `published: false`**:
- Landing page shows "COMING SOON" overlay
- Links to podcast page are inactive
- Podcast is hidden from public view

**If `published: true`**:
- Full podcast card displayed
- Links are active
- Available for listeners

### 5. Achieve 100% Green

Re-run validation until all items are ✅:

```bash
./scripts/generate-publishing-status.sh yntswyd
```

When status shows **🟢 READY TO PUBLISH**, proceed to publication.

### 6. Publish

Once 100% complete:

1. Set `published: true` in `_data/podcasts.yml`
2. Commit changes to intrusive-memory.github.com
3. Push and deploy website
4. Verify landing page shows live (no "COMING SOON")
5. Test feed in podcast apps
6. Submit to directories (Apple Podcasts, Spotify, etc.)

## Checklist Categories

### 1. Artwork & Branding
- Local assets exist
- Assets uploaded to CDN
- URLs point to CDN in all files

### 2. Audio Files
- All episodes generated
- Files on CDN
- Publicly accessible

### 3. PROJECT.md Metadata
- All required fields present
- Episode count correct
- Voice casting defined

### 4. Website Integration
- Entry in `_data/podcasts.yml`
- Artwork paths correct (`/podcasts/` prefix)
- Audio paths correct (no `/podcasts/` prefix)

### 5. Individual Podcast Page
- Page exists and loads
- All episodes listed
- Audio players work
- CDN URLs (not local)

### 6. RSS Feed
- feed.xml exists
- Valid XML
- All episodes listed
- CDN URLs for audio and artwork

### 7. Landing Page
- Listed in index
- "COMING SOON" status correct
- Card displays properly

### 8. Collection Files
- collection.json entry
- collection.opml entry
- README.md listing

## Quick Reference

### Upload Assets to CDN

```bash
cd ~/Projects/podcast-{name}/assets
wrangler r2 object put "intrusive-memory-audio/{slug}/podcast-artwork.jpg" \
  --file podcast-artwork.jpg --content-type "image/jpeg" --remote
wrangler r2 object put "intrusive-memory-audio/{slug}/apple-touch-icon.png" \
  --file apple-touch-icon.png --content-type "image/png" --remote
wrangler r2 object put "intrusive-memory-audio/{slug}/favicon.ico" \
  --file favicon.ico --content-type "image/x-icon" --remote
```

### Upload Audio to CDN

```bash
cd ~/Projects/podcast-{name}/audio
for file in *.m4a; do
  wrangler r2 object put "intrusive-memory-audio/{slug}/$file" \
    --file "$file" --content-type "audio/x-m4a" --remote
done
```

### Validate Feed

```bash
curl -s "https://intrusive-memory.productions/podcasts/{slug}/feed.xml" | xmllint --noout -
```

### Check CDN URLs

```bash
# Artwork
curl -I "https://pub-8e049ed02be340cbb18f921765fd24f3.r2.dev/{slug}/podcast-artwork.jpg"

# Sample audio
curl -I "https://pub-8e049ed02be340cbb18f921765fd24f3.r2.dev/{slug}/chapter-01.m4a"
```

## Future: Automated Skill

This system will be converted to a `/publish-podcast` skill that:

1. Runs all validations automatically
2. Uploads missing files
3. Updates metadata
4. Generates status report
5. Optionally publishes (sets `published: true`)

**Example Usage:**
```
/publish-podcast yntswyd
/publish-podcast lazarillo --upload-assets
/publish-podcast daily-dao --publish
```

## Troubleshooting

### Artwork not displaying
- Check URL in podcasts.yml uses `/podcasts/` prefix
- Verify CDN URL is accessible (200 OK)
- Check HTML `<img src>` points to CDN

### Audio players not working
- Verify CDN URLs in HTML (not local paths like `/audio/`)
- Check MIME type is `audio/x-m4a`
- Test file accessibility with curl

### "COMING SOON" not showing
- Check `published: false` in podcasts.yml
- Verify landing page template uses conditional rendering
- Check Jekyll build completed successfully

### Episode count mismatch
- Count files: `ls audio/*.m4a | wc -l`
- Check PROJECT.md `episodes:` field
- Verify all episodes listed in feed.xml
