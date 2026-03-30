# Highland File Structure Reference

## Archive Format

.highland files are **Zip archives** that can be extracted with standard `unzip` commands.

## Internal Directory Structure

Every .highland file contains a single `.textbundle` directory with this structure:

```
<name>.textbundle/
├── text.md                          # Main screenplay content (Fountain format)
├── info.json                        # Document metadata
├── scratchpad.txt                   # Scratch notes
├── navigatorFilters.json            # Legacy filters (deprecated)
├── assets/                          # Embedded media files
│   ├── images/
│   ├── research-docs/
│   └── ... (any bundled resources)
├── resources/                       # Highland 2 settings and state
│   ├── settings.json               # Document and UI settings
│   ├── outline.json                # Document outline structure
│   ├── header.json                 # Page header configuration
│   ├── footer.json                 # Page footer configuration
│   ├── navigator-filters.json      # Scene/element filters
│   ├── sideboards.json             # Sidebar content
│   └── shelf.json                  # Shelf content
├── revisions/                       # Version history
│   └── current.json                # Current revision data
└── bin/                            # Binary resources (rarely used)
```

## Key Files

### text.md
The main screenplay content in Fountain format. This is the primary file to extract when reading .highland files.

### info.json
Metadata about the document:

```json
{
  "com.quoteunquoteapps.highland2": {
    "currentTabIndex": -1,
    "printParagraphNumbers": false,
    "showSynopses": false,
    "sidebarWidth": 0,
    "templateName": "Screenplay",
    "version": 3
  },
  "transient": false,
  "type": "com.quoteunquoteapps.fountain",
  "version": 2
}
```

**Important fields:**
- `type`: Always `"com.quoteunquoteapps.fountain"` for Highland 2 documents
- `templateName`: Document template (e.g., "Screenplay", "Novel", "Stage Play")

### resources/settings.json
Contains document settings, cursor position, print options, and UI state:

```json
{
  "documentId": "UUID",
  "editorSettings": {
    "revisionColorIndex": 0,
    "revisionMode": false
  },
  "uiSettings": {
    "cursorPosition": 572,
    "scrollPosition": -24,
    "sidebarWidth": 1143
  },
  "printSettings": { ... }
}
```

### assets/
Directory for embedded media files referenced in the screenplay. Can include:
- Images (for production notes, storyboards)
- Research documents
- Audio/video references
- Any other supporting materials

## Extraction Methods

### Extract screenplay only
```bash
unzip -p file.highland "*.textbundle/text.md" > screenplay.fountain
```

### List all contents
```bash
unzip -l file.highland
```

### Extract everything
```bash
unzip file.highland -d output-directory/
```

### Extract specific file
```bash
unzip -p file.highland "path/to/file.json"
```

## Notes

- The `.textbundle` directory name matches the .highland filename (without extension)
- All paths inside the archive are relative to the .textbundle directory
- Highland 2 uses "stored" compression (no compression), making files quick to access
- The format is platform-independent and works on macOS, iOS, Windows, and Linux
