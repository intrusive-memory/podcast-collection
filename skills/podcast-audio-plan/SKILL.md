---
name: podcast-audio-plan
description: Generate audio for podcast episodes from Fountain screenplays using Produciesta CLI. When asked to "generate podcast audio", "create audio plan", "cast voices", or working with podcast projects that have episodes/*.fountain files, this skill analyzes characters, assigns appropriate voices, writes PROJECT.md cast list, and generates audio.
---

# Podcast Audio Generation with Produciesta

Generate professional podcast audio from Fountain screenplay files using Claude-assisted voice casting and Produciesta CLI generation.

## When to Use This Skill

Use this skill when:

- User asks to generate audio for a podcast project
- Project has episode scripts in Fountain format (`episodes/*.fountain`)
- User wants to create or update a cast list in PROJECT.md
- User asks to "cast voices", "assign voices", "plan audio generation"
- User wants to generate audio from screenplays

## What This Skill Does

This skill provides a **Claude-assisted workflow** for podcast audio generation:

1. **Analyze Fountain files** to extract character list
2. **Query available voices** from Apple TTS or ElevenLabs
3. **Match characters to voices** based on character traits and voice characteristics
4. **Write PROJECT.md** with proper YAML front matter and cast list
5. **Generate audio** using Produciesta CLI
6. **Create execution plans** for batch processing

## Prerequisites

### Required Tools

- **Produciesta CLI** at `~/Projects/Produciesta/produciesta-cli/`
- **Swift 6.2+** (for building Produciesta if needed)
- **Xcode 16+** (macOS only)
- **Apple TTS** (built-in macOS) or **ElevenLabs API key**

### Project Structure

```
podcast-project/
├── PROJECT.md              # Project configuration (Claude creates this)
├── episodes/               # Fountain screenplay files
│   ├── chapter-01.fountain
│   ├── chapter-02.fountain
│   └── ...
└── audio/                  # Generated audio files (created by Produciesta)
```

## Voice Casting Workflow (Claude-Assisted)

**IMPORTANT**: Produciesta's `--autocast` feature is currently not working. Instead, use Claude to create the cast list manually.

### Step 1: Discover Episodes and Extract Characters

```bash
# List all Fountain files
ls episodes/*.fountain

# Read a sample episode to understand characters
cat episodes/chapter-01.fountain
```

**Claude will:**
1. Read Fountain files to identify all CHARACTER names
2. Analyze dialogue to understand character traits (age, gender, personality)
3. Build a comprehensive character list

### Step 2: Query Available Voices

**For Apple TTS:**
```bash
say -v '?'
```

**For ElevenLabs:**
```bash
# List available voices (if using ElevenLabs MCP)
# Or use: https://elevenlabs.io/docs/voices/voice-library
```

**Claude will:**
1. Parse available voices and their characteristics
2. Note voice IDs, names, languages, and qualities

### Step 3: Match Characters to Voices

**Claude will:**
1. Consider character traits from dialogue analysis
2. Match each character to the most appropriate voice
3. Provide primary and fallback voice options
4. Explain the reasoning for each assignment

### Step 4: Create or Update PROJECT.md

**Claude will:**
1. Create PROJECT.md with proper YAML front matter
2. Write the cast list with voice URIs
3. Include episode count and configuration
4. Add production notes for documentation

**Example PROJECT.md:**
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
  - character: BOB
    voices:
      - apple://com.apple.voice.premium.en-US.Daniel
---

## Production Notes

### Voice Casting
- NARRATOR: Aaron (mature, authoritative voice)
- ALICE: Ava (young female, clear diction)
- BOB: Daniel (British accent, professional tone)

### Project Structure
- 10 episodes in Fountain format
- Generated audio saved to `audio/` directory
- Format: M4A (Apple AAC)
```

### Step 5: Generate Audio with Produciesta

```bash
# Generate audio using the cast list
produciesta /path/to/project --format m4a --verbose
```

**What happens:**
- ✅ Produciesta reads PROJECT.md cast list
- ✅ Parses Fountain files and resolves character voices
- ✅ Generates audio for all episodes
- ✅ Saves M4A files to `audio/` directory

## Voice Providers

### Apple Neural TTS (Free)

**Advantages:**
- No API key required
- Premium voices included with macOS
- Fast, local processing
- No per-character costs

**Best for:** English podcasts, quick testing, budget projects

**Query voices:**
```bash
say -v '?'
```

**Voice URI format:**
```
apple://com.apple.voice.premium.en-US.Aaron
```

**Popular voices:**
- **Aaron** - Mature male, US accent
- **Ava** - Young female, US accent, clear
- **Daniel** - Male, British accent
- **Samantha** - Female, US accent, warm
- **Fred** - Male, novelty voice
- **Zoe** - Female, US accent, professional

### ElevenLabs (Paid)

**Advantages:**
- Extremely natural-sounding voices
- Multilingual support
- Professional quality
- Emotion control

**Best for:** Professional production, non-English podcasts, high-quality output

**Setup:**
```bash
export ELEVENLABS_API_KEY="your-key-here"
```

**Voice URI format:**
```
elevenlabs://21m00Tcm4TlvDq8ikWAM
```

**Popular voices:**
- `21m00Tcm4TlvDq8ikWAM` - Rachel (US female)
- `EXAVITQu4vr4xnSDxMaL` - Bella (US female)
- `pNInz6obpgDQGcFmaJgB` - Adam (US male)
- `ErXwobaYiN019PkySvjV` - Antoni (male, well-rounded)
- `MF3mGyEYCl7XYWbV9V6O` - Elli (young female)

## Complete Workflow Example

### Scenario: New Podcast with 5 Episodes

**Step 1: Analyze Project**
```bash
cd ~/podcast-tao-de-jing
ls episodes/*.fountain
# Output: chapter-01.fountain, chapter-02.fountain, ... chapter-05.fountain
```

**Step 2: Read Sample Episode**
Claude reads `episodes/chapter-01.fountain` and identifies:
- NARRATOR (reads quotes and commentary)

**Step 3: Query Apple Voices**
```bash
say -v '?'
```

Claude reviews available voices and selects:
- NARRATOR → Aaron (mature, authoritative)

**Step 4: Create PROJECT.md**
Claude writes:
```yaml
---
type: project
title: Daily Dao - Tao De Jing Podcast
author: Tom Stovall
description: Daily readings from the Tao Te Ching with commentary
episodesDir: episodes
audioDir: audio
filePattern: "*.fountain"
exportFormat: m4a
cast:
  - character: NARRATOR
    voices:
      - apple://com.apple.voice.premium.en-US.Aaron
---

## Production Notes

### Voice Casting
- NARRATOR: Aaron - Selected for mature, contemplative tone appropriate for philosophical content

### Project Details
- 5 episodes covering Chapters 1-5 of the Tao Te Ching
- Each episode: ~5-7 minutes
- Target audience: Philosophy enthusiasts
```

**Step 5: Generate Audio**
```bash
produciesta ~/podcast-tao-de-jing --format m4a --verbose
```

**Output:**
```
✓ Project directory: /Users/stovak/podcast-tao-de-jing
✓ Found 5 episodes
✓ Cast list loaded: 1 character
✓ Starting generation...

Episode 1/5: chapter-01.fountain
  Parsing... ✓ 12 elements
  Generating... ✓ 100%
  Exporting... ✓ chapter-01.m4a (3.2 MB, 4m 32s)

Episode 2/5: chapter-02.fountain
  ...

✓ Generation complete!
  Processed: 5 episodes
  Duration: 23m 15s total
  Output: ~/podcast-tao-de-jing/audio/
```

## Character Analysis Guidelines

When analyzing Fountain files to extract characters, Claude should:

### 1. Identify All Characters

Parse Fountain dialogue blocks:
```fountain
NARRATOR
This is the narrator speaking.

ALICE
Hello, I'm Alice!

BOB (V.O.)
And I'm Bob, off screen.
```

Extract: `NARRATOR`, `ALICE`, `BOB`

**Note:** Character name variations map to same character:
- `BOB`, `BOB (V.O.)`, `BOB (O.S.)`, `BOB (CONT'D)` → all = `BOB`

### 2. Analyze Character Traits

From dialogue and context, determine:
- **Age range** (child, young adult, middle-aged, elderly)
- **Gender** (male, female, neutral)
- **Personality** (authoritative, friendly, serious, playful)
- **Role** (narrator, protagonist, antagonist, supporting)
- **Accent/dialect** (if specified or implied)

### 3. Consider Dialogue Volume

Note how much each character speaks:
- **Primary characters** (lots of dialogue) → assign premium voices
- **Supporting characters** (moderate dialogue) → standard voices
- **Minor characters** (few lines) → can share voices or use default

### 4. Document Casting Rationale

In PROJECT.md production notes, explain:
- Why each voice was selected
- Character traits that influenced the choice
- Any special considerations

## Voice Matching Guidelines

When matching characters to voices:

### For Narrators

**Ideal characteristics:**
- Clear articulation
- Moderate pace
- Authoritative but not harsh
- Easy to listen to for extended periods

**Recommended Apple voices:**
- Aaron (US male, mature)
- Ava (US female, clear)
- Daniel (UK male, professional)

### For Conversational Characters

**Ideal characteristics:**
- Natural, warm tone
- Expressive (can convey emotion)
- Distinct from other characters

**Recommended Apple voices:**
- Samantha (US female, friendly)
- Fred (US male, character voice)
- Zoe (US female, professional)

### For ElevenLabs

**Advantages:**
- More emotional range
- Better for character voices
- Multilingual support

**When to use:**
- Professional productions
- Non-English content
- Need multiple distinct character voices
- Budget allows for API costs

## PROJECT.md Structure

### Minimal Configuration

```yaml
---
type: project
title: Podcast Title
episodesDir: episodes
audioDir: audio
filePattern: "*.fountain"
exportFormat: m4a
cast:
  - character: CHARACTER_NAME
    voices:
      - apple://voice.id
---
```

### Complete Configuration

```yaml
---
type: project
title: Full Podcast Title
author: Author Name
description: Detailed podcast description
episodesDir: episodes
audioDir: audio
filePattern: "*.fountain"
exportFormat: m4a
cast:
  - character: NARRATOR
    voices:
      - apple://com.apple.voice.premium.en-US.Aaron   # Primary
      - apple://com.apple.voice.premium.en-GB.Daniel  # Fallback
  - character: CHARACTER_TWO
    voices:
      - elevenlabs://21m00Tcm4TlvDq8ikWAM
---

## Production Notes

[Optional markdown content documenting the project]
```

### Required Fields

- `type: project` - Always required
- `title` - Podcast title
- `episodesDir` - Relative path to episodes (default: `episodes`)
- `audioDir` - Relative path for output (default: `audio`)
- `filePattern` - Glob pattern for episode files (default: `"*.fountain"`)
- `exportFormat` - Audio format: `m4a`, `aiff`, `wav`, `caf`, `mp3`
- `cast` - Array of character-to-voice mappings

### Optional Fields

- `author` - Creator name
- `description` - Podcast description

## Produciesta Generation Commands

### Basic Generation

```bash
# Generate all episodes
produciesta /path/to/project

# Generate with specific format
produciesta /path/to/project --format m4a

# Verbose output
produciesta /path/to/project --verbose
```

### Single Episode

```bash
# By name (relative to episodesDir)
produciesta /path/to/project --episode chapter-01.fountain

# By direct path
produciesta /path/to/project/episodes/chapter-01.fountain
```

### Batch Processing

```bash
# Skip existing audio files
produciesta /path/to/project --skip-existing

# Resume from episode N
produciesta /path/to/project --resume-from 50

# Force regenerate all
produciesta /path/to/project --regenerate
```

### Preview Mode

```bash
# Dry run (show plan without generating)
produciesta /path/to/project --dry-run
```

### Error Handling

```bash
# Stop on first error
produciesta /path/to/project --fail-fast

# Continue on voice resolution errors (use default voice)
produciesta /path/to/project --ignore-generation-errors
```

## Troubleshooting

### Error: "Character not found in cast list"

**Cause:** Fountain file contains a character not in PROJECT.md cast section.

**Solution 1:** Add character to PROJECT.md
```yaml
cast:
  - character: MISSING_CHARACTER
    voices:
      - apple://com.apple.voice.premium.en-US.Aaron
```

**Solution 2:** Use default voice
```bash
produciesta /path/to/project \
  --default-voice "apple://com.apple.voice.premium.en-US.Aaron"
```

**Solution 3:** Re-analyze with Claude
Ask Claude to re-read Fountain files and update PROJECT.md cast list.

### Error: "Voice provider unavailable"

**For ElevenLabs:**
```bash
# Check API key is set
echo $ELEVENLABS_API_KEY

# Set if missing
export ELEVENLABS_API_KEY="your-key-here"
```

**For Apple TTS:**
- Premium voices require download: System Settings → Accessibility → Spoken Content
- Voice ID must be exact (case-sensitive)

### Error: "No episodes found"

**Check file pattern:**
```bash
# List files
ls episodes/*.fountain

# Update filePattern in PROJECT.md if needed
filePattern: "*.fountain"  # or "chapter-*.fountain", etc.
```

### Audio Quality Issues

**Voice too fast/slow:**
- Apple TTS: No direct speed control
- ElevenLabs: Has stability/similarity controls

**Wrong voice:**
- Update voice URI in PROJECT.md
- Regenerate: `produciesta /path/to/project --regenerate`

## Advanced: Hooks for Automation (macOS Only)

Produciesta supports pre/post-generation hooks for automation:

### Create Hooks

```bash
mkdir -p /path/to/project/.produciesta-hooks

# Pre-generation hook
cat > /path/to/project/.produciesta-hooks/pre-generation.sh << 'EOF'
#!/bin/bash
echo "🎙️  Starting audio generation at $(date)"
# Validation, setup, notifications
EOF

# Post-generation hook
cat > /path/to/project/.produciesta-hooks/post-generation.sh << 'EOF'
#!/bin/bash
echo "✅ Completed audio generation at $(date)"
# Upload to R2, update RSS feed, deploy to website
EOF

chmod +x /path/to/project/.produciesta-hooks/*.sh
```

### Disable Hooks

```bash
produciesta /path/to/project --skip-hooks
```

## Creating Execution Plans

When the user asks to "create an audio plan", generate a planning document:

### Plan Template

```markdown
# Audio Generation Plan: [Project Title]

## Project Overview
- **Location**: /path/to/project
- **Episodes**: [N] .fountain files
- **Characters**: [N] unique characters
- **Format**: M4A
- **Provider**: Apple TTS / ElevenLabs

## Step 1: Character Analysis

[Claude analyzes Fountain files]

Characters identified:
- NARRATOR: 150 lines, authoritative narrator voice
- ALICE: 45 lines, young female protagonist
- BOB: 32 lines, supporting male character

## Step 2: Voice Assignment

[Claude matches voices]

Recommended casting:
- NARRATOR → Aaron (mature, clear, authoritative)
- ALICE → Ava (young female, expressive)
- BOB → Daniel (British accent, professional)

## Step 3: PROJECT.md Creation

[Claude creates/updates PROJECT.md with cast list]

## Step 4: Audio Generation

```bash
cd /path/to/project
produciesta . --format m4a --verbose
```

## Step 5: Quality Check

- [ ] Listen to first episode
- [ ] Verify voice assignments appropriate
- [ ] Check audio quality
- [ ] Validate file sizes

## Timeline Estimate

- Character analysis: 5 minutes
- Voice matching: 5 minutes
- PROJECT.md creation: 2 minutes
- Audio generation: ~2 minutes per episode
- Quality check: 10 minutes
- **Total**: [Estimated based on episode count]
```

## Best Practices

1. **Always analyze all episodes** before assigning voices (characters may appear later)
2. **Document casting rationale** in PROJECT.md production notes
3. **Test with one episode first** before batch processing
4. **Use premium voices for primary characters** (more dialogue = more important)
5. **Consider voice distinctiveness** to avoid confusion between characters
6. **Commit PROJECT.md to git** for version control and team collaboration
7. **Use dry-run mode** to validate configuration before generating

## Related Tools and Resources

- **Produciesta CLI**: `~/Projects/Produciesta/produciesta-cli/`
- **ProduciestaCore**: Audio generation engine
- **Apple TTS**: Built-in macOS voices
- **ElevenLabs**: Premium voice synthesis API
- **Fountain Format**: https://fountain.io/
- **ElevenLabs Voice Library**: https://elevenlabs.io/voice-library

## Notes

- **Do NOT use `--autocast` flag** - it's currently not working
- Claude-assisted casting provides better control and understanding
- Always verify voice URIs are correct format before generation
- Produciesta handles all audio generation - Claude only creates cast list
- Error logs saved to `GENERATION_ERRORS.md` in project root
