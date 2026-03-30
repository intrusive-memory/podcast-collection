---
name: highland-git-setup
description: Configure a git repository to produce meaningful text diffs for Highland 2 screenplay files (.highland). Use when asked to "set up git for Highland files", "configure Highland diffs", "track Highland screenplays in git", "version control screenplays", or when initializing a repo that contains .highland files. Highland files are zip archives containing Fountain-formatted screenplays; without this setup, git treats them as opaque binaries.
---

# Highland Git Setup

Configure git to show meaningful text diffs for `.highland` screenplay files instead of treating them as binary blobs.

## Background

Highland 2 (by John August) saves screenplays as `.highland` files, which are zip archives containing Fountain-formatted text plus metadata and embedded assets. By default, git sees these as binary and cannot diff them. The fix: register a `zip` diff driver that runs `unzip -c -a` to extract text before diffing.

## Setup

Run the bundled script from the repository root:

```bash
bash /Users/stovak/.claude/skills/highland-git-setup/scripts/setup-highland-git.sh
```

This performs two idempotent operations:

1. **Global gitconfig** — adds `diff.zip.textconv = "unzip -c -a"` so any repo can use the `zip` diff driver
2. **Local .gitattributes** — adds `*.highland diff=zip merge=binary` so `.highland` files use the zip diff driver and binary merge strategy

## Manual Setup

If preferred, apply manually:

```bash
# Global: register zip diff driver (once per machine)
git config --global diff.zip.textconv "unzip -c -a"

# Local: associate .highland files (once per repo)
echo '*.highland diff=zip merge=binary' >> .gitattributes
```

## Verification

After setup, test with:

```bash
git diff HEAD -- path/to/screenplay.highland
```

The diff output will show the Fountain-formatted screenplay text rather than "Binary files differ".

## Notes

- The `merge=binary` strategy prevents git from attempting three-way text merge on zip files, which would corrupt them. Highland file merges must be resolved manually.
- The `unzip -c -a` command extracts all archive contents to stdout with ASCII text conversion, making the full Fountain text (and metadata XML) visible in diffs.
- Commit the `.gitattributes` file so all collaborators benefit from the diff configuration. The global gitconfig change must be applied on each developer's machine.
