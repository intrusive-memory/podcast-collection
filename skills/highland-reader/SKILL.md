---
name: highland-reader
description: Read and extract content from .highland screenplay files (Highland 2 format). Use when working with .highland files to extract screenplays, list bundle contents, access embedded resources, or understand the file structure. Highland files are zip archives containing Fountain-formatted screenplays with bundled assets and metadata.
---

# Highland Reader

## Overview

Highland 2 uses a proprietary .highland file format that bundles Fountain screenplays with assets, notes, and metadata into a single compressed archive. This skill enables reading .highland files by extracting screenplays, listing contents, and accessing bundled resources.

## Quick Start

Highland files are zip archives. To understand any .highland file:

1. **Extract the screenplay** (most common use case):
   ```bash
   scripts/extract_screenplay.sh file.highland output.fountain
   ```

2. **List all contents**:
   ```bash
   scripts/list_contents.sh file.highland
   ```

3. **Extract all resources** (including assets):
   ```bash
   scripts/extract_assets.sh file.highland ./output-dir
   ```

## Working with Highland Files

### Extract Screenplay Content

The main screenplay content is stored in `text.md` inside a `.textbundle` directory. To extract it:

```bash
scripts/extract_screenplay.sh path/to/file.highland screenplay.fountain
```

This extracts the Fountain-formatted screenplay to a .fountain file that can be read directly or processed with other tools.

**Manual extraction** (without script):
```bash
unzip -p file.highland "*.textbundle/text.md" > screenplay.fountain
```

### List Bundle Contents

To see what's inside a .highland file without extracting:

```bash
scripts/list_contents.sh file.highland
```

This shows all files in the bundle including:
- `text.md` - Main screenplay (Fountain format)
- `assets/` - Embedded media files
- `resources/` - Settings and metadata (JSON)
- `revisions/` - Version history
- `info.json` - Document metadata

### Extract Bundled Resources

To extract all contents including assets and metadata:

```bash
scripts/extract_assets.sh file.highland ./output-directory
```

This extracts the entire `.textbundle` directory, preserving the structure. Useful when you need:
- Embedded images or research documents (`assets/`)
- Document settings or outline (`resources/`)
- Revision history (`revisions/`)

### Read Metadata

To check document metadata (type, template, version):

```bash
unzip -p file.highland "*.textbundle/info.json" | jq .
```

Key metadata fields:
- `type`: Document type (always `com.quoteunquoteapps.fountain`)
- `templateName`: Template used (e.g., "Screenplay", "Stage Play", "Novel")
- `version`: Highland format version

### Access Specific Files

Extract specific files from the bundle:

```bash
# Extract settings
unzip -p file.highland "*.textbundle/resources/settings.json"

# Extract scratchpad notes
unzip -p file.highland "*.textbundle/scratchpad.txt"

# Extract outline
unzip -p file.highland "*.textbundle/resources/outline.json"
```

## Understanding the Format

Highland files are standard zip archives containing a `.textbundle` directory. For complete format details, see:

- **[highland-structure.md](references/highland-structure.md)** - Complete file structure reference
- **[fountain-format.md](references/fountain-format.md)** - Fountain screenplay syntax guide

### Common Use Cases

**Reading a screenplay**:
```bash
scripts/extract_screenplay.sh episode-01.highland episode-01.fountain
cat episode-01.fountain
```

**Checking for embedded assets**:
```bash
scripts/list_contents.sh screenplay.highland | grep "assets/"
```

**Extracting images from a screenplay**:
```bash
scripts/extract_assets.sh screenplay.highland ./extracted
ls ./extracted/*.textbundle/assets/
```

**Converting Highland to plain text**:
```bash
scripts/extract_screenplay.sh screenplay.highland screenplay.fountain
# Process screenplay.fountain as needed
```

## Integration with Other Workflows

### Podcast Production
When working with podcast episodes stored as .highland files:

1. Extract the screenplay:
   ```bash
   scripts/extract_screenplay.sh episode.highland episode.fountain
   ```

2. Process with podcast-audio-plan skill or other tools that expect .fountain format

### Screenplay Analysis
.highland files contain Fountain-formatted screenplays. After extraction, use standard Fountain tools or read the screenplay directly. The Fountain format is human-readable markdown-based syntax.

## Troubleshooting

**"No .textbundle directory found"**
- The file may be corrupted or not a valid .highland file
- Check file type: `file file.highland` (should show "Zip archive")

**"File not found"**
- Verify the path is correct and the file has .highland extension

**Empty screenplay extraction**
- The .highland file may contain a blank document
- Check contents: `scripts/list_contents.sh file.highland`

**Missing assets**
- Not all .highland files contain assets
- Check for assets directory: `unzip -l file.highland | grep assets/`

## Resources

### scripts/
- `extract_screenplay.sh` - Extract main screenplay content
- `list_contents.sh` - List all files in the bundle
- `extract_assets.sh` - Extract all resources and assets

### references/
- `highland-structure.md` - Complete .highland file format reference
- `fountain-format.md` - Fountain screenplay syntax guide
