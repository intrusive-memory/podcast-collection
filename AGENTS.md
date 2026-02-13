# AGENTS.md - Podcast Collection

This file provides comprehensive documentation for AI agents working with the Intrusive Memory Podcast Collection.

## Overview

This repository serves as the **authoritative registry** for all Intrusive Memory podcasts. Individual podcast projects are located in sibling directories (`../podcast-*`), and this collection provides centralized metadata, publishing status, and cross-podcast coordination.

## Podcast Projects

All podcast projects follow the **SwiftProyecto PROJECT.md format**. See [SwiftProyecto/AGENTS.md](../SwiftProyecto/AGENTS.md) for the authoritative specification of PROJECT.md frontmatter, cast lists, and voice configuration.

### Active Podcasts

The complete list of podcasts is maintained in two authoritative files:

1. **`collection.json`** - Machine-readable podcast metadata (JSON Schema validated)
2. **`collection.opml`** - OPML feed list for podcast clients

**Current Podcasts** (7 total):

1. **Daily Dao - Tao De Jing Podcast**
   - Directory: `../podcast-tao-de-jing/`
   - Feed: https://intrusive-memory.productions/daily-dao/feed.xml
   - Website: https://intrusive-memory.productions/daily-dao/
   - Status: Active (81 episodes)
   - Genre: Philosophy

2. **Meditations**
   - Directory: `../podcast-meditations/`
   - Feed: https://intrusive-memory.productions/meditations/feed.xml
   - Website: https://intrusive-memory.productions/meditations/
   - Status: Active (365 episodes)
   - Genre: Philosophy

3. **The Life of Lazarillo de Tormes**
   - Directory: `../podcast-lazarillo/`
   - Feed: https://intrusive-memory.productions/lazarillo/feed.xml
   - Website: https://intrusive-memory.productions/lazarillo/
   - Status: Active (8 episodes)
   - Genre: Literature/Fiction

4. **You're Nobody til Somebody Wants You Dead**
   - Directory: `../podcast-yntswyd/`
   - Feed: https://intrusive-memory.productions/yntswyd/feed.xml
   - Website: https://intrusive-memory.productions/yntswyd/
   - Status: Active (9 episodes)
   - Genre: Fiction

5. **Therapist GPT**
   - Directory: `../podcast-therapist-gpt/`
   - Feed: https://intrusive-memory.productions/therapist-gpt/feed.xml
   - Website: https://intrusive-memory.productions/therapist-gpt/
   - Status: Active (2 episodes)
   - Genre: Education

6. **Podcast Mr Mr Charles**
   - Directory: `../podcast-mr-mr-charles/`
   - Feed: https://intrusive-memory.productions/mr-mr-charles/feed.xml
   - Website: https://intrusive-memory.productions/mr-mr-charles/
   - Status: Active (9 episodes)
   - Genre: Comedy

7. **Casting Software Spells**
   - Directory: `../podcast-casting-software-spells/`
   - Feed: https://intrusive-memory.productions/casting-software-spells/feed.xml
   - Website: https://intrusive-memory.productions/casting-software-spells/
   - Status: Active (12 episodes)
   - Genre: Technology/Education

## PROJECT.md Format

All podcasts MUST follow the SwiftProyecto PROJECT.md format. See [../SwiftProyecto/AGENTS.md](../SwiftProyecto/AGENTS.md) for complete specification.

### Cast List Voice Format

**CRITICAL**: Voice providers use key-value pairs, NOT URI strings.

**Correct Format:**
```yaml
cast:
  - character: NARRATOR
    actor: Tom Stovall
    voiceDescription: "Deep, warm baritone with measured pacing and gravitas"
    voices:
      apple: com.apple.voice.compact.en-US.Samantha
      elevenlabs: 21m00Tcm4TlvDq8ikWAM
      voxalta: narrative-1
```

**Incorrect Formats:**
```yaml
# ❌ WRONG: Array of URI strings
voices:
  - "apple://com.apple.voice.compact.en-US.Samantha"
  - "voxalta://narrative-1?lang=en"

# ❌ WRONG: Separate voiceProviders section
voiceProviders:
  - provider: voxalta
    castings:
      - character: NARRATOR
        voice: "voxalta://ryan?lang=en"
```

### Voice Provider Keys

| Provider | Key | Voice ID Format | Example |
|----------|-----|-----------------|---------|
| Apple TTS | `apple` | `com.apple.voice.{quality}.{locale}.{VoiceName}` | `com.apple.voice.compact.en-US.Samantha` |
| ElevenLabs | `elevenlabs` | Alphanumeric voice ID | `21m00Tcm4TlvDq8ikWAM` |
| VoxAlta | `voxalta` | Voice name or ID | `narrative-1` |

## Authoritative References

- **SwiftProyecto Format**: [../SwiftProyecto/AGENTS.md](../SwiftProyecto/AGENTS.md)
- **Collection Registry**: `collection.json` (this repository)
- **OPML Feed List**: `collection.opml` (this repository)
- **Podcast Directories**: `../podcast-*/` (sibling directories)

## Workflow

When working with podcasts:

1. **Check collection.json** for authoritative metadata
2. **Navigate to podcast directory** (`../podcast-*/`)
3. **Read PROJECT.md** for project-specific configuration
4. **Follow SwiftProyecto format** for all PROJECT.md modifications
5. **Update collection.json** if podcast metadata changes

## Related Projects

- **SwiftProyecto**: PROJECT.md parsing and project metadata
- **SwiftHablare**: TTS and voice provider integration
- **Produciesta**: Audio generation CLI for podcast episodes
