---
name: fcpxml-writer
description: >
  Generate FCPXML timelines for podcast episodes using the `secuencia` CLI (SwiftSecuencia).
  Use when asked to create, generate, or build .fcpxml files, FCP timelines, Final Cut Pro XML,
  or when assembling podcast audio clips into an FCPXML document for Final Cut Pro import.
  Handles audio-only timelines, chapter markers, sequential clip assembly, and DTD validation.
---

# FCPXML Writer — Podcast Episode Timelines

Generate DTD-valid FCPXML v1.11 files for Final Cut Pro import using the `secuencia` CLI from [SwiftSecuencia](https://github.com/intrusive-memory/SwiftSecuencia).

## Prerequisites — Install secuencia

Before generating FCPXML, ensure `secuencia` is installed:

```bash
# Check if installed
which secuencia

# Install via Homebrew (recommended)
brew tap intrusive-memory/tap
brew install secuencia

# Verify
secuencia --version
```

If Homebrew is not available, build from source:

```bash
cd ~/Projects/SwiftSecuencia
make release
sudo make install  # Installs to /usr/local/bin/secuencia
```

## Workflow — Generate FCPXML for a Podcast Episode

### Step 1: Gather Audio Files

Identify all audio clips for the episode. Get exact durations:

```bash
afinfo audio/chapter-01.m4a | grep "estimated duration"
```

### Step 2: Create a JSON Timeline Definition

`secuencia` takes a JSON file describing the timeline. For a typical podcast episode with sequential audio chapters:

```json
{
  "timeline": {
    "name": "Episode 01 - Title",
    "format": {
      "width": 1920,
      "height": 1080,
      "frameRate": "24",
      "colorSpace": "rec709"
    },
    "audio": {
      "layout": "mono",
      "rate": "24000"
    }
  },
  "clips": [
    {
      "name": "Chapter 01",
      "file": "audio/chapter-01.m4a",
      "offset": "0s",
      "lane": 0,
      "type": "audio"
    },
    {
      "name": "Chapter 02",
      "file": "audio/chapter-02.m4a",
      "offset": "17.408s",
      "lane": 0,
      "type": "audio"
    }
  ]
}
```

**Key points:**
- `file` paths are relative to the JSON file's location
- `duration` can be omitted — `secuencia` probes the audio file automatically
- `offset` for each clip = sum of all previous clip durations
- `type` must be `"audio"` for podcast audio files
- `lane` 0 = primary storyline

### Step 3: Validate the JSON

```bash
secuencia validate timeline.json
```

This checks:
- JSON syntax and schema compliance
- All referenced files exist
- Media durations are probed
- Warnings for gaps, very short clips, etc.

### Step 4: Generate FCPXML

```bash
# Standalone .fcpxml file
secuencia build timeline.json

# Custom output path
secuencia build --output episode-01.fcpxml timeline.json

# .fcpxmld bundle with embedded media (copies audio into bundle)
secuencia build --bundle timeline.json

# Strict DTD validation (fail on any warning)
secuencia build --strict timeline.json
```

**Expected output:**
```
✅ Export successful!
Output: /path/to/timeline.fcpxml
Timeline: Episode 01 - Title
Format: 1920x1080 @ 24 fps
Clips: 13
Unique assets: 13
Total duration: 285.00s
Lanes: 0...0
```

### Step 5: Import into Final Cut Pro

Open the `.fcpxml` or `.fcpxmld` file in Final Cut Pro. All clips, timing, and audio roles are preserved.

## JSON Schema Reference

Get the full JSON schema for programmatic validation:

```bash
secuencia schema > timeline-schema.json
```

### Timeline Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `timeline.name` | string | Yes | Timeline/project name in FCP |
| `timeline.format.width` | integer | Yes | Video width (e.g., 1920) |
| `timeline.format.height` | integer | Yes | Video height (e.g., 1080) |
| `timeline.format.frameRate` | string | Yes | `"23.98"`, `"24"`, `"25"`, `"29.97"`, `"30"` |
| `timeline.format.colorSpace` | string | No | `"rec709"`, `"rec2020"`, `"dciP3"` |
| `timeline.audio.layout` | string | Yes | `"mono"`, `"stereo"`, `"surround"` |
| `timeline.audio.rate` | string | Yes | `"24000"`, `"44100"`, `"48000"`, or kHz form `"48kHz"` |

### Clip Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `clips[].name` | string | Yes | Clip name |
| `clips[].file` | string | Yes* | Path to media file (*not needed for markers) |
| `clips[].offset` | string | Yes | Start time on timeline (e.g., `"0s"`, `"17.408s"`, `"417792/24000s"`) |
| `clips[].duration` | string | No | Clip duration (probed from file if omitted) |
| `clips[].lane` | integer | No | Timeline lane (default: 0) |
| `clips[].type` | string | Yes | `"audio"`, `"video"`, `"image"`, `"marker"` |
| `clips[].markerType` | string | No | `"standard"`, `"chapter"`, `"todo"` (when type is `"marker"`) |

### Time String Formats

| Format | Example | Description |
|--------|---------|-------------|
| Integer seconds | `"3s"` | Whole seconds |
| Decimal seconds | `"17.408s"` | Fractional seconds |
| Rational | `"417792/24000s"` | Frame-precise timing |

## Typical Podcast JSON Pattern

For a podcast with N sequential audio chapters, the JSON follows this pattern:

1. All clips are `"type": "audio"` on `"lane": 0`
2. Each clip's `offset` = sum of all prior durations
3. `duration` is omitted (auto-probed from the audio file)
4. `audio.rate` matches the actual sample rate of the audio files (check with `afinfo`)
5. `audio.layout` is `"mono"` for single-narrator podcasts, `"stereo"` for multi-voice

## Manual Validation (Fallback)

If you need to validate FCPXML against the DTD without `secuencia`:

```bash
# Use the bundled validation script
./scripts/validate_fcpxml.sh output.fcpxml
```

This injects a SYSTEM DTD reference and runs `xmllint --valid`.

## DTD Element Ordering

For manual FCPXML editing or debugging validation errors, see `references/element-ordering.md` for the complete child element ordering rules. The most common error is placing markers before captions inside `asset-clip`.

## Reference

- [SwiftSecuencia README](https://github.com/intrusive-memory/SwiftSecuencia)
- `references/element-ordering.md` — DTD child element ordering
- `references/fcpxml_1.11.dtd` — FCPXML v1.11 DTD for manual validation
