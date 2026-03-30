---
name: drop-episode
description: >
  Drop the next podcast episode for intrusive-memory.github.com by merging the next
  banked episode branch through development and into main. Use this skill whenever
  the user says "drop an episode", "release the next episode", "publish the next episode",
  "merge the next episode", or any variation of advancing the podcast release schedule.
  Also trigger when the user mentions episode branches, episode drops, or scheduling
  podcast releases for intrusive-memory.productions. Works across all in-progress
  podcasts (confessions, mr-mr-charles, casting-software-spells, etc.).
---

# Drop Episode

Automates the release of the next banked podcast episode by progressing it through
the git branching workflow: episode branch → development → main.

## Context

The intrusive-memory.github.com repository hosts multiple podcasts. Episodes are
banked as remote branches and released one at a time by merging through `development`
into `main`. The `main` branch is the source of truth for what's published — the
site deploys from `main`.

### Branch naming convention

Episode branches follow the pattern:

```
<podcast-slug>/episode-<number>-<title-slug>
```

Examples:
- `confessions/episode-24-first-principal`
- `confessions/episode-25-empathy-engine-pt2`
- `mr-mr-charles/episode-03-the-audition`
- `casting-software-spells/episode-01-hello-world`

The `<podcast-slug>` matches the podcast's `slug` field in `_data/podcasts.yml`.

### Legacy branches

Some older branches may use the flat format `episode-<number>-<title-slug>` without
a podcast prefix. These are confessions episodes. Treat them equivalently — if the
user asks to drop a confessions episode and both prefixed and unprefixed branches
exist, prefer the prefixed form. If only unprefixed branches exist, use those.

## Workflow

### Step 1: Determine which podcast

If the user specifies a podcast (e.g., "drop the next confessions episode"), use that.

If the user just says "drop the next episode" without specifying, check which
in-progress podcasts have banked episode branches:

```bash
git branch -r | grep -E 'origin/(confessions|mr-mr-charles|casting-software-spells)/'
```

Also check for legacy unprefixed branches:

```bash
git branch -r | grep 'origin/episode-'
```

- If only one podcast has banked branches, use that one.
- If multiple podcasts have banked branches, ask the user which podcast to drop for.
- If none have banked branches, inform the user.

### Step 2: Sync local branches

Ensure local `main` and `development` are up to date:

```bash
git fetch origin
git checkout main && git pull origin main
git checkout development && git pull origin development
```

### Step 3: Identify the next episode

1. Find the **highest episode number for this podcast already on `main`** by
   inspecting merge commits and PR history. Look at `git log main --oneline` for
   patterns referencing the podcast's episode branches or episode numbers.
   Also check `gh pr list --state merged --base main` for merged episode PRs.

2. List remote episode branches for this podcast:
   ```bash
   git branch -r | grep 'origin/<podcast-slug>/episode-'
   ```
   Also check for legacy branches if the podcast is `confessions`:
   ```bash
   git branch -r | grep 'origin/episode-'
   ```

3. The next episode is the one with the **lowest number greater than** the highest
   on main. For example, if episode 23 is the latest on main and branches exist for
   24, 25, and 26, the next episode is 24.

4. If no unmerged episode branches remain, inform the user that all banked episodes
   for this podcast have been released.

### Step 4: Merge episode branch into development

Check whether the episode branch is already merged into `development`:

```bash
git branch -r --merged development | grep '<episode-branch>'
```

If **not merged**, merge it:

```bash
git checkout development
git merge origin/<episode-branch> --no-edit
git push origin development
```

If there are merge conflicts, stop and inform the user — do not force-resolve.

If **already merged**, skip this step and note it for the user.

### Step 5: Create or find the PR to main

Check if a PR from `development` to `main` already exists:

```bash
gh pr list --head development --base main --state open
```

If an open PR exists, reuse it. Update the title if it doesn't reflect the episode
being dropped.

If no PR exists, create one:

```bash
gh pr create \
  --base main \
  --head development \
  --title "<Podcast Name> Episode <N>: <Episode Title>" \
  --body "$(cat <<'EOF'
## Summary
- Release <Podcast Name> Episode <N>: <Episode Title>
- Merged from branch `<podcast-slug>/episode-<N>-<slug>` through `development`

## Checklist
- [ ] Jekyll build CI passes
- [ ] Deploy workflow succeeds
EOF
)"
```

Derive the episode title from the branch slug by converting hyphens to spaces and
title-casing (e.g., `first-principal` → "First Principal").

Look up the podcast's full name from `_data/podcasts.yml` using the slug.

### Step 6: Wait for CI and merge

1. Check CI status on the PR:
   ```bash
   gh pr checks <PR-NUMBER>
   ```

2. If CI is still running, enable auto-merge so GitHub merges it once CI passes:
   ```bash
   gh pr merge <PR-NUMBER> --auto --merge
   ```

3. If CI has already passed, merge immediately:
   ```bash
   gh pr merge <PR-NUMBER> --merge
   ```

4. If CI has failed, inform the user and do not merge. Share the failing check details.

### Step 7: Confirm

Report to the user:
- Which podcast and episode was released (number, title, branch name)
- The PR URL
- Whether the merge is complete or pending (auto-merge)
- Which banked episode branches remain for this podcast

## Error handling

- **Merge conflicts**: Stop and ask the user how to proceed. Never force-resolve.
- **CI failures**: Report the failure details. Do not merge.
- **No episode branches**: Inform the user all banked episodes have been released.
- **Branch already on main**: If the next episode branch is already merged to main,
  skip it and look for the one after, or inform the user if none remain.
- **Ambiguous podcast**: If multiple podcasts have banked branches and the user
  didn't specify which one, ask before proceeding.
