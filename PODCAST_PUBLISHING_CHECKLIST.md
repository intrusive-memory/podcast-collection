# Podcast Publishing Checklist

A comprehensive validation checklist for publishing podcasts to the Intrusive Memory collection. This will be automated as a skill.

## 1. Artwork & Branding Assets ✅

### Required Assets (per podcast)
- [ ] `podcast-artwork.jpg` (3000×3000 or 2048×2048, RGB, < 500KB)
- [ ] `apple-touch-icon.png` (180×180)
- [ ] `favicon.ico` (16×16, 32×32 multi-resolution)

### Validation Steps
- [ ] All assets exist in local `assets/` directory
- [ ] All assets uploaded to CDN at `{cdn_base}/{podcast_slug}/`
- [ ] Asset URLs written to `PROJECT.md` in podcast repo
- [ ] Asset URLs in `_data/podcasts.yml` point to CDN
- [ ] Artwork displays correctly in feed readers (test)
- [ ] Artwork meets platform requirements:
  - Minimum 1400×1400, recommended 3000×3000
  - Square (1:1 aspect ratio)
  - RGB color space (not CMYK)
  - JPG or PNG format

## 2. Audio Files on CDN ✅

### Generation & Upload
- [ ] All episode `.fountain` scripts exist
- [ ] All episodes generated to `.m4a` format
- [ ] Audio files uploaded to CDN at `{cdn_base}/{podcast_slug}/`
- [ ] Audio files publicly accessible (200 OK response)
- [ ] Correct MIME type: `audio/x-m4a`

### Audio Quality Checks
- [ ] Sample playback test (first episode, random middle episode, last episode)
- [ ] No audio glitches, pops, or dropouts
- [ ] Consistent volume levels across episodes
- [ ] Proper voice casting (characters match expected voices)
- [ ] File sizes reasonable (not truncated or corrupted)

### Naming Conventions
- [ ] Consistent naming pattern per podcast
- [ ] URL-safe filenames (no spaces unless intentional)
- [ ] Files match expected pattern in feed

## 3. PROJECT.md Metadata ✅

### Required Fields
- [ ] `type: project`
- [ ] `title` (podcast name)
- [ ] `author`
- [ ] `description` (full description)
- [ ] `episodes` (count matches actual audio files)
- [ ] `genre`
- [ ] `tags` / `keywords`
- [ ] `language` (ISO 639-1 code, e.g., en-US)
- [ ] `explicit` flag (true/false)
- [ ] `cast` (voice mapping for characters)

### Asset URLs in PROJECT.md
- [ ] `artworkURL` points to CDN
- [ ] `feedURL` points to published RSS feed
- [ ] `websiteURL` points to podcast page
- [ ] `audioBaseURL` or individual episode URLs listed

### Optional But Recommended
- [ ] `created` date
- [ ] `season` info (if applicable)
- [ ] `status` (active, completed, in_progress)
- [ ] Episode summaries/descriptions
- [ ] Production notes

## 4. Website Integration (_data/podcasts.yml) ✅

### Required Fields
- [ ] `slug` matches directory name
- [ ] `name` matches PROJECT.md title
- [ ] `author`
- [ ] `description` and `tagline`
- [ ] `episodes` count
- [ ] `genre`
- [ ] `keywords` array
- [ ] `language`
- [ ] `explicit` flag
- [ ] `status` (in_progress, complete)
- [ ] `published` flag (false until ready)

### URL Fields
- [ ] `artwork`: `/podcasts/{slug}/podcast-artwork.jpg`
- [ ] `feed_url`: `https://intrusive-memory.productions/podcasts/{slug}/feed.xml`
- [ ] `website_url`: `https://intrusive-memory.productions/podcasts/{slug}/`
- [ ] `audio_path`: `{slug}` (CDN path, no /podcasts/ prefix)

### Validation
- [ ] Entry exists in podcasts.yml
- [ ] All URLs use correct prefixes
- [ ] `audio_path` does NOT include `/podcasts/` (common mistake)
- [ ] Data matches PROJECT.md (no conflicts)

## 5. RSS Feed Generation & Validation ✅

### Feed File
- [ ] `feed.xml` exists in podcast directory
- [ ] Valid XML syntax (no parsing errors)
- [ ] RSS 2.0 format with iTunes namespace
- [ ] Feed uploaded to `/podcasts/{slug}/feed.xml`

### Feed Metadata
- [ ] `<title>` matches podcast name
- [ ] `<description>` present
- [ ] `<language>` set correctly
- [ ] `<itunes:author>` present
- [ ] `<itunes:explicit>` set correctly
- [ ] `<itunes:image href="...">` points to CDN artwork
- [ ] `<link>` points to website

### Episode Items
- [ ] All episodes included as `<item>` entries
- [ ] Each item has:
  - [ ] `<title>` (episode title)
  - [ ] `<description>` (episode summary)
  - [ ] `<enclosure url="..." type="audio/x-m4a" length="...">` (CDN audio URL)
  - [ ] `<guid>` (unique identifier, usually audio URL)
  - [ ] `<pubDate>` (RFC 2822 format)
  - [ ] `<itunes:duration>` (HH:MM:SS or seconds)
  - [ ] `<itunes:episode>` (episode number)

### Feed Validation
- [ ] Feed validates at https://www.castfeedvalidator.com/
- [ ] Feed validates at https://podba.se/validate/
- [ ] No errors in Apple Podcasts validator
- [ ] Test in podcast app (Apple Podcasts, Overcast, Pocket Casts)

## 6. Podcast Website Page ✅

### Individual Podcast Page (`/podcasts/{slug}/index.html`)
- [ ] Page exists and loads without errors
- [ ] Artwork displayed from CDN (not local path)
- [ ] Artwork `<img src>` points to `{cdn_base}/{slug}/podcast-artwork.jpg`
- [ ] `<link rel="icon">` points to CDN favicon
- [ ] `<link rel="apple-touch-icon">` points to CDN icon
- [ ] Metadata displays correctly:
  - [ ] Podcast title
  - [ ] Author/creator
  - [ ] Description/tagline
  - [ ] Genre and keywords
- [ ] RSS feed link present and functional
- [ ] "Subscribe" buttons/links work

### Episode List & Audio Player
- [ ] **All episodes listed on page** (count matches actual episodes)
- [ ] Each episode has:
  - [ ] Episode title
  - [ ] Episode number/identifier
  - [ ] Description (optional but recommended)
  - [ ] Duration display
  - [ ] Audio player embedded
- [ ] **Audio players load from CDN** (`{cdn_base}/{slug}/episode.m4a`)
- [ ] Players are functional (play/pause/seek)
- [ ] Players don't use local file paths
- [ ] Episode ordering correct (chronological or intended order)
- [ ] No 404 errors on audio files

### Landing Page Integration (`/podcasts/index.html`)
- [ ] Podcast listed in grid/card layout
- [ ] Card displays:
  - [ ] Artwork from CDN
  - [ ] Podcast title
  - [ ] Episode count
  - [ ] Tagline/description
  - [ ] Genre
- [ ] **If `published: false`**: "COMING SOON" banner/overlay visible
- [ ] **If `published: false`**: Links to podcast page disabled/inactive
- [ ] **If `published: true`**: Links active and clickable
- [ ] **If `published: true`**: No "COMING SOON" overlay
- [ ] RSS feed icon/link present
- [ ] Click-through to individual page works

## 7. Collection Files (podcast-collection repo) ✅

### collection.json
- [ ] Podcast entry exists
- [ ] All required fields present:
  - [ ] `name`, `feedURL`, `websiteURL`
  - [ ] `summary`, `description`
  - [ ] `author`, `genre`, `language`
  - [ ] `keywords` array
  - [ ] `episodeCount` matches actual count
  - [ ] `status`, `explicit`
- [ ] Entry validates against `schema.json`
- [ ] URLs are correct and accessible

### collection.opml
- [ ] Podcast entry exists
- [ ] RSS feed URL correct
- [ ] Title and description present
- [ ] OPML imports correctly to podcast apps

### README.md
- [ ] Podcast listed in table
- [ ] Episode count correct
- [ ] Genre correct
- [ ] Description matches collection.json

## 8. Technical Validation ✅

### URL Accessibility (200 OK checks)
- [ ] Podcast artwork URL
- [ ] RSS feed URL
- [ ] Podcast website URL
- [ ] All episode audio URLs
- [ ] Favicon and apple-touch-icon URLs

### File Integrity
- [ ] Audio files not corrupted (spot check)
- [ ] File sizes match expected ranges
- [ ] MIME types correct
- [ ] No 404 errors on any resources

### Performance
- [ ] CDN delivers files with correct cache headers
- [ ] Audio files stream correctly (not download-only)
- [ ] Artwork loads quickly (optimized file sizes)

## 9. Content Quality Assurance ✅

### Metadata Accuracy
- [ ] Episode titles descriptive and consistent
- [ ] Episode numbers sequential and correct
- [ ] Descriptions free of typos
- [ ] Author/creator attribution correct
- [ ] Genre and keywords relevant

### Audio Quality
- [ ] No mispronunciations (spot check)
- [ ] Scene transitions clear
- [ ] Pacing natural (not too fast/slow)
- [ ] No long silences or gaps
- [ ] Character voices consistent

### Transcripts (Optional)
- [ ] Transcripts generated (if applicable)
- [ ] Transcript format (VTT, SRT, or TXT)
- [ ] Timestamps accurate
- [ ] Transcript accessible/linked

## 10. Legal & Attribution ✅

### Copyright & Licensing
- [ ] Source material licensed correctly (if adapted)
- [ ] Voice actors credited (if applicable)
- [ ] Music/sound effects licensed (if used)
- [ ] License documented in PROJECT.md or README

### Content Warnings
- [ ] Explicit flag set correctly
- [ ] Content warnings in episode descriptions (if needed)
- [ ] Age rating appropriate

### Attribution
- [ ] "Generated with Produciesta" credit (optional)
- [ ] Original author attribution (for adaptations)
- [ ] Co-author credits (e.g., "Co-Authored-By: Claude")

## 11. Pre-Publication Checklist ✅

### Final Review
- [ ] All above sections completed
- [ ] Sample test in 3+ podcast apps
- [ ] Feed URL added to collection.opml
- [ ] `published: false` → `published: true` in podcasts.yml
- [ ] Git committed and pushed
- [ ] Website deployed (Jekyll build successful)

### Soft Launch
- [ ] Test subscription via RSS URL
- [ ] Download and play first episode
- [ ] Verify artwork displays
- [ ] Check episode ordering
- [ ] Test on mobile and desktop

### Ready for Distribution
- [ ] Submitted to Apple Podcasts Connect
- [ ] Submitted to Spotify for Podcasters
- [ ] Submitted to Google Podcasts Manager
- [ ] Added to Overcast, Pocket Casts (if manual submission)
- [ ] Social media announcement prepared (optional)

## 12. Post-Publication Monitoring ✅

### First 24 Hours
- [ ] Monitor download stats
- [ ] Check for error reports
- [ ] Verify feed updates in directories
- [ ] Test discovery in podcast apps

### Ongoing
- [ ] Regular feed validation
- [ ] CDN uptime monitoring
- [ ] Broken link checks
- [ ] Analytics review (if enabled)

---

## Quick Validation Commands

### Check CDN Accessibility
```bash
curl -I "https://pub-8e049ed02be340cbb18f921765fd24f3.r2.dev/{podcast_slug}/podcast-artwork.jpg"
curl -I "https://pub-8e049ed02be340cbb18f921765fd24f3.r2.dev/{podcast_slug}/chapter-01.m4a"
```

### Validate Feed
```bash
curl -s "https://intrusive-memory.productions/podcasts/{slug}/feed.xml" | xmllint --noout -
```

### Check File Count Match
```bash
# Local audio files
ls ~/Projects/podcast-{name}/audio/*.m4a | wc -l

# PROJECT.md episodes count
grep "^episodes:" ~/Projects/podcast-{name}/PROJECT.md
```

---

## Per-Podcast Publishing Status

Each podcast repository should have a `PUBLISHING_STATUS.md` file that shows the current status of all checklist items:

```markdown
# Publishing Status: {Podcast Name}

**Last Updated**: 2026-02-11
**Status**: 🔴 NOT READY (15/42 items complete)

## 1. Artwork & Branding Assets
- ✅ podcast-artwork.jpg exists (3000×3000)
- ✅ apple-touch-icon.png exists (180×180)
- ✅ favicon.ico exists
- ✅ Assets uploaded to CDN
- 🔴 PROJECT.md artworkURL points to CDN
- ✅ podcasts.yml artwork path correct

## 2. Audio Files
- ✅ All 8 episodes generated
- ✅ All episodes on CDN
- ✅ Files publicly accessible
...
```

**Color Coding**:
- ✅ Green: Complete and verified
- 🔴 Red: Incomplete or failed validation
- ⚠️ Yellow: Warning or needs review
- ⏭️ Gray: Skipped/Not applicable

## Automation Plan (Future Skill)

This checklist will be converted to a `/publish-podcast` skill that:

1. Takes podcast slug as parameter
2. Runs all validation checks automatically
3. **Generates/updates PUBLISHING_STATUS.md in podcast repo**
4. Reports issues with specific line items
5. Uploads missing assets to CDN
6. Updates metadata files
7. **Validates website pages and CDN links**
8. **Checks landing page "COMING SOON" status**
9. Optionally sets `published: true` and commits

**Skill Usage**:
```bash
/publish-podcast daily-dao                    # Full validation + status report
/publish-podcast yntswyd --dry-run            # Validate without changes
/publish-podcast lazarillo --upload-assets    # Upload missing files
/publish-podcast yntswyd --publish            # Set published: true
```

**Output**:
```
🎙️ Publishing Status: You're Nobody til Somebody Wants You Dead
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ Artwork & Branding: 6/6 complete
✅ Audio Files: 9/9 on CDN
✅ PROJECT.md Metadata: All fields valid
✅ Website Integration: 12/12 complete
✅ RSS Feed: Valid, all episodes listed
🔴 Landing Page: Still shows "COMING SOON" (published: false)

Overall: 41/42 items complete (98%)
Ready to publish? Run: /publish-podcast yntswyd --publish
```
