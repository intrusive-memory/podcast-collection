---
name: podcast-audio-plan
description: Plan voice casting and publish podcast episodes to intrusive-memory.productions. Use this skill when the user asks to "cast voices", "assign voices", "create a cast list", "set up PROJECT.md", "publish episodes", "deploy podcast", "update the RSS feed", "push to production", or any variation of planning a podcast's voice assignments or publishing generated audio to the website. This skill handles everything BEFORE and AFTER audio generation — casting and publishing. For the actual audio generation step (running Produciesta, intro/outro wrapping, playback), use the generate-episode-audio skill instead.
---

# Podcast Voice Casting & Publishing

Plan voice casting for podcast projects and publish generated audio to intrusive-memory.productions.

**Scope**: This skill covers two phases — **casting** (before audio generation) and **publishing** (after). The actual audio generation and wrapping is handled by the `generate-episode-audio` skill.

## Voice Casting Workflow

Produciesta's `--autocast` feature is currently not working. Use Claude to create the cast list manually.

### Step 1: Discover Episodes and Extract Characters

```bash
ls episodes/*.fountain
```

Read Fountain files to identify all CHARACTER names. Character name variations map to the same character:
- `BOB`, `BOB (V.O.)`, `BOB (O.S.)`, `BOB (CONT'D)` → all = `BOB`

Analyze dialogue to understand character traits:
- **Age range** (child, young adult, middle-aged, elderly)
- **Gender** (male, female, neutral)
- **Personality** (authoritative, friendly, serious, playful)
- **Role** (narrator, protagonist, antagonist, supporting)
- **Accent/dialect** (if specified or implied)
- **Dialogue volume** — primary characters (lots of dialogue) get premium voices

### Step 2: Query Available Voices

**For Apple TTS:**
```bash
say -v '?'
```

**For VoxAlta** (custom cloned voices):
Check the `voices/` directory for `.vox` files. These are created with `echada` (SwiftEchada).

**For ElevenLabs:**
Requires `ELEVENLABS_API_KEY` environment variable.

### Step 3: Match Characters to Voices

Consider character traits from dialogue analysis. Match each character to the most appropriate voice. Provide reasoning for each assignment.

**Narrator voices** — clear articulation, moderate pace, easy to listen to for extended periods.
**Conversational characters** — natural, warm, expressive, distinct from other characters.

### Step 4: Create or Update PROJECT.md

```yaml
---
type: project
title: My Podcast Series
author: Author Name
description: Description of the podcast
episodesDir: episodes
audioDir: audio
filePattern: "*.fountain"
exportFormat: m4a
cast:
  - character: NARRATOR
    voices:
      - apple://com.apple.voice.premium.en-US.Aaron
  - character: ALICE
    voices:
      - apple://com.apple.voice.premium.en-US.Ava
---

## Production Notes

### Voice Casting
- NARRATOR: Aaron (mature, authoritative voice)
- ALICE: Ava (young female, clear diction)
```

**Required fields**: `type`, `title`, `episodesDir`, `audioDir`, `filePattern`, `exportFormat`, `cast`
**Optional fields**: `author`, `description`

**For VoxAlta voices**, use nested format:
```yaml
cast:
  - character: NARRATOR
    voicePrompt: "Deep authoritative British baritone."
    voices:
      voxalta: voices/NARRATOR.vox
```

### Step 5: Generate Audio

Use the **generate-episode-audio** skill for this step. It handles:
- Highland → Fountain extraction (if needed)
- Pronunciation checks for Spanish/foreign terms
- Running Produciesta CLI
- Intro/outro wrapping via post-generation hook
- Opening the result in QuickTime Player

## Publishing Workflow

After audio is generated, publish to intrusive-memory.productions.

### Project Structure

```
Source repo (podcast-*):          Website repo (intrusive-memory.github.com):
├── PROJECT.md                    podcasts/<slug>/
├── episodes/*.fountain           ├── index.html
├── audio/*.m4a (Git LFS)        ├── feed.xml
└── voices/*.vox                  ├── podcast-artwork.jpg
                                  ├── episodes/*.fountain (transcripts)
                                  └── audio/ (placeholder — CDN serves audio)
```

**CDN**: `https://pub-8e049ed02be340cbb18f921765fd24f3.r2.dev/<slug>/`

### Phase 1: Git LFS Commit (Source Repo)

```bash
# Configure LFS if needed
cat .gitattributes | grep m4a
# If missing:
git lfs track "*.m4a"

# Commit audio
git add audio/*.m4a .gitattributes
git commit -m "Add audio for episodes N-M"
git push origin main

# Verify LFS upload
git lfs ls-files
```

### Phase 2: Verify CDN

```bash
curl -I https://pub-8e049ed02be340cbb18f921765fd24f3.r2.dev/<slug>/episode_01.m4a
# Should return: HTTP/2 200
```

If 404, wait a few minutes for LFS sync to CDN.

### Phase 3: Website Integration

**Copy transcripts:**
```bash
cp ~/podcast-<name>/episodes/*.fountain \
   ~/Projects/intrusive-memory.github.com/podcasts/<slug>/episodes/
```

**Update RSS feed** (`podcasts/<slug>/feed.xml`):
```xml
<item>
    <title>Episode Title</title>
    <description>Episode description</description>
    <pubDate>Wed, 12 Feb 2025 00:00:00 -0500</pubDate>
    <enclosure url="https://pub-8e049ed02be340cbb18f921765fd24f3.r2.dev/<slug>/episode_01.m4a"
               length="3980000"
               type="audio/mp4"/>
    <guid>https://intrusive-memory.productions/podcasts/<slug>/episode-01</guid>
    <itunes:duration>285</itunes:duration>
    <itunes:episodeType>full</itunes:episodeType>
</item>
```

**Get file size and duration for RSS:**
```bash
stat -f%z audio/episode_01.m4a          # File size (bytes)
afinfo audio/episode_01.m4a | grep "estimated duration"  # Duration (seconds)
```

**Update podcast metadata** (`_data/podcasts.yml`):
```yaml
- slug: <slug>
  episodes: 5  # Update count
  published: true
```

### Phase 4: Transcript Setup

The same .fountain files serve as transcripts. The web player JavaScript:
1. Fetches the .fountain file from `episodes/`
2. Strips YAML frontmatter, section markers, and SSML tags
3. Displays clean text

Transcript filenames must match what `loadTranscript()` constructs in `index.html`.

### Phase 5: Validation

```bash
cd ~/Projects/intrusive-memory.github.com
bundle exec jekyll serve
# Visit: http://localhost:4000/podcasts/<slug>/
```

**Checklist:**
- [ ] Page loads, audio plays from CDN
- [ ] Transcripts load and display correctly
- [ ] Episode switching works
- [ ] Subscribe links correct
- [ ] RSS feed validates (https://validator.w3.org/feed/)
- [ ] `<enclosure>` URLs point to CDN with correct file sizes
- [ ] Pub dates are valid RFC-822 format

### Phase 6: Deploy

```bash
cd ~/Projects/intrusive-memory.github.com
git add podcasts/<slug>/episodes/*.fountain podcasts/<slug>/feed.xml _data/podcasts.yml
git commit -m "Publish <podcast> episodes N-M"
git push origin master

# Verify GitHub Pages build
gh run list --limit 1
```

**Final production check:**
- [ ] `https://intrusive-memory.productions/podcasts/<slug>/` loads
- [ ] Audio plays, transcripts display
- [ ] RSS feed accessible
- [ ] Test subscribe in podcast app

## Troubleshooting

### CDN returns 404
1. Wait 5-10 minutes for LFS sync
2. Verify LFS upload: `git lfs ls-files | grep filename`
3. Verify CDN URL path matches podcast slug

### Transcripts show "Transcript not available"
1. Verify .fountain files copied to website `episodes/`
2. Check filename matches JavaScript `loadTranscript()` call
3. Check browser console for 404 errors

### Transcripts show SSML tags or YAML frontmatter
Update `parseFountain()` in `index.html` to strip all tags. Pattern: `/^---[\s\S]*?---\s*/m`

### RSS feed validation fails
- **Invalid date**: Use RFC-822 format: `Wed, 12 Feb 2025 00:00:00 -0500`
- **Invalid enclosure URL**: Must be full CDN URL with `https://`
- **Missing duration**: `<itunes:duration>285</itunes:duration>` (in seconds)
- **Wrong file size**: Get actual with `stat -f%z audio/file.m4a`

### Character not found in cast list
```bash
grep "^[A-Z][A-Z ]*$" episodes/*.fountain | sort -u
```
Add missing characters to PROJECT.md cast section.

## Notes

- Do NOT use `--autocast` flag — currently not working
- Audio files belong in Git LFS, not regular git blobs
- CDN serves audio — website only references CDN URLs
- Transcripts are .fountain files copied from source repo to website
- RSS feeds must be manually updated — no auto-generation yet
