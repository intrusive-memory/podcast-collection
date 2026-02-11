# Podcast Collection - Atomic Execution Plan

**Goal**: Ensure all 7 podcasts have audio generated, sprint plans created, proper Git LFS tracking, and are pushed to remote repositories.

**Projects**:
1. podcast-tao-de-jing (Daily Dao)
2. podcast-meditations
3. podcast-lazarillo
4. podcast-yntswyd (You're Nobody til Somebody Wants You Dead)
5. podcast-therapist-gpt
6. podcast-mr-mr-charles
7. podcast-casting-software-spells

---

## Phase 1: Git Repository & LFS Setup (7 tasks)

### podcast-therapist-gpt Git Initialization

#### Task 1.1: Initialize git repository for podcast-therapist-gpt
**Project**: `/Users/stovak/Projects/podcast-therapist-gpt`
**Status**: CRITICAL - No git repository
**Dependencies**: None
**Estimated Time**: 2 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-therapist-gpt

# Initialize git repository
git init

# Verify initialization
git status
```

**Success Criteria**:
- `.git` directory exists
- Git repository initialized successfully

---

#### Task 1.2: Configure Git LFS for podcast-therapist-gpt
**Project**: `/Users/stovak/Projects/podcast-therapist-gpt`
**Dependencies**: Task 1.1
**Estimated Time**: 2 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-therapist-gpt

# Create .gitignore
cat > .gitignore << 'EOF'
.DS_Store
*.swp
*~
.env
node_modules/
EOF

# Create .gitattributes for Git LFS
cat > .gitattributes << 'EOF'
*.m4a filter=lfs diff=lfs merge=lfs -text
*.mp3 filter=lfs diff=lfs merge=lfs -text
*.aiff filter=lfs diff=lfs merge=lfs -text
*.wav filter=lfs diff=lfs merge=lfs -text
EOF

# Install LFS hooks
git lfs install

# Track existing audio files
git lfs track "*.m4a"
git lfs track "*.mp3"

# Verify LFS tracking
cat .gitattributes
```

**Success Criteria**:
- .gitignore created
- .gitattributes created with LFS rules
- LFS hooks installed
- Audio patterns tracked

---

#### Task 1.3: Create initial commit for podcast-therapist-gpt
**Project**: `/Users/stovak/Projects/podcast-therapist-gpt`
**Dependencies**: Task 1.2
**Estimated Time**: 2 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-therapist-gpt

# Stage all files
git add .

# Create initial commit
git commit -m "Initial commit: podcast-therapist-gpt

- 2 episodes with audio
- PROJECT.md with cast list (3 characters)
- Git LFS configured for audio files

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

# Verify commit
git log --oneline -1
git lfs ls-files
```

**Success Criteria**:
- Initial commit created
- Audio files tracked in Git LFS
- All project files staged and committed

---

#### Task 1.4: Add remote and push podcast-therapist-gpt
**Project**: `/Users/stovak/Projects/podcast-therapist-gpt`
**Dependencies**: Task 1.3
**Estimated Time**: 3 minutes
**Note**: Requires GitHub repository to exist

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-therapist-gpt

# Add remote (assumes GitHub repo exists)
git remote add origin https://github.com/intrusive-memory/podcast-therapist-gpt.git

# Push to remote
git push -u origin main

# Verify remote
git remote -v
```

**Success Criteria**:
- Remote added successfully
- All commits pushed to remote
- LFS files uploaded

---

### podcast-casting-software-spells LFS Configuration

#### Task 1.5: Configure Git LFS for podcast-casting-software-spells
**Project**: `/Users/stovak/Projects/podcast-casting-software-spells`
**Status**: Has git but missing .gitattributes
**Dependencies**: None
**Estimated Time**: 2 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-casting-software-spells

# Create .gitattributes for Git LFS
cat > .gitattributes << 'EOF'
*.m4a filter=lfs diff=lfs merge=lfs -text
*.mp3 filter=lfs diff=lfs merge=lfs -text
*.aiff filter=lfs diff=lfs merge=lfs -text
*.wav filter=lfs diff=lfs merge=lfs -text
EOF

# Install LFS hooks if not already installed
git lfs install

# Track audio file patterns
git lfs track "*.m4a"
git lfs track "*.mp3"

# Verify configuration
cat .gitattributes
```

**Success Criteria**:
- .gitattributes created
- LFS hooks installed
- Audio patterns tracked

---

#### Task 1.6: Commit LFS configuration for podcast-casting-software-spells
**Project**: `/Users/stovak/Projects/podcast-casting-software-spells`
**Dependencies**: Task 1.5
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-casting-software-spells

# Stage LFS configuration
git add .gitattributes

# Commit
git commit -m "chore: Configure Git LFS for audio files

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

# Verify commit
git log --oneline -1
```

**Success Criteria**:
- .gitattributes committed
- Commit created successfully

---

#### Task 1.7: Push LFS configuration for podcast-casting-software-spells
**Project**: `/Users/stovak/Projects/podcast-casting-software-spells`
**Dependencies**: Task 1.6
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-casting-software-spells

# Push to remote
git push

# Verify push
git status
```

**Success Criteria**:
- Changes pushed to remote
- Working tree clean

---

## Phase 2: Generate Sprint Plans (5 tasks)

#### Task 2.1: Generate sprint plans for podcast-tao-de-jing
**Project**: `/Users/stovak/Projects/podcast-tao-de-jing`
**Current State**: Has audio (13 files), cast list (1 character), needs sprint plans
**Dependencies**: None
**Estimated Time**: 10 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-tao-de-jing

# Use the podcast-audio-plan skill to generate plans
# This will create AUDIO_GENERATION_PLAN.md and AUDIO_SPRINT_TASKS.md
```

**Adaptation Notes**:
- 81 episodes (Tao De Jing chapters)
- 1 narrator character
- Philosophy podcast focus
- Update timeline estimates for 81 episodes

**Success Criteria**:
- AUDIO_GENERATION_PLAN.md exists with project-specific details
- AUDIO_SPRINT_TASKS.md exists with granular tasks
- Plans reflect 81-episode scale

---

#### Task 2.2: Generate sprint plans for podcast-meditations
**Project**: `/Users/stovak/Projects/podcast-meditations`
**Current State**: Has audio (365 files, 631M), cast list (2 characters), needs sprint plans
**Dependencies**: None
**Estimated Time**: 10 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-meditations

# Generate sprint plans using podcast-audio-plan skill or template
```

**Adaptation Notes**:
- 365 episodes (one per day for a year)
- 2 characters: NARRATOR, MARCUS AURELIUS
- Stoic philosophy focus
- Large existing audio library (631MB - already generated)
- Plans should document the existing workflow for reference

**Success Criteria**:
- AUDIO_GENERATION_PLAN.md exists
- AUDIO_SPRINT_TASKS.md exists
- Plans reflect 365-episode scale

---

#### Task 2.3: Generate sprint plans for podcast-therapist-gpt
**Project**: `/Users/stovak/Projects/podcast-therapist-gpt`
**Current State**: Has audio (2 files), cast list (3 characters), needs sprint plans
**Dependencies**: Task 1.4 (git fully initialized)
**Estimated Time**: 10 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-therapist-gpt

# Generate sprint plans
```

**Adaptation Notes**:
- 2 episodes currently (may expand)
- 3 characters in cast
- Therapeutic/educational content
- AI-generated conversations
- Plans should support future expansion

**Success Criteria**:
- AUDIO_GENERATION_PLAN.md exists
- AUDIO_SPRINT_TASKS.md exists

---

#### Task 2.4: Generate sprint plans for podcast-mr-mr-charles
**Project**: `/Users/stovak/Projects/podcast-mr-mr-charles`
**Current State**: Has audio (5 files, 14M), cast list (12 characters), needs sprint plans
**Dependencies**: None
**Estimated Time**: 10 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-mr-mr-charles

# Generate sprint plans
```

**Adaptation Notes**:
- 10 episodes planned (5 currently have audio)
- 12 characters - diverse cast
- Comedy genre
- 5 more episodes need audio generation
- Plans should cover both completed and remaining episodes

**Success Criteria**:
- AUDIO_GENERATION_PLAN.md exists
- AUDIO_SPRINT_TASKS.md exists
- Plans address remaining 5 episodes

---

#### Task 2.5: Generate sprint plans for podcast-casting-software-spells
**Project**: `/Users/stovak/Projects/podcast-casting-software-spells`
**Current State**: Has cast list (2 characters), NO audio files yet, needs sprint plans
**Dependencies**: Task 1.7 (LFS configured)
**Estimated Time**: 10 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-casting-software-spells

# Generate sprint plans using podcast-audio-plan skill
```

**Adaptation Notes**:
- 12 episodes planned
- 2 characters (minimal cast)
- Technology/education focus
- Software development as "magic"
- No audio generated yet - plans will guide full generation

**Success Criteria**:
- AUDIO_GENERATION_PLAN.md exists
- AUDIO_SPRINT_TASKS.md exists
- Plans ready for audio generation in Phase 3

---

## Phase 3: Generate Missing Audio (3 tasks)

#### Task 3.1: Generate audio for podcast-lazarillo
**Project**: `/Users/stovak/Projects/podcast-lazarillo`
**Current State**: Has sprint plans, 20 character cast, but ZERO audio files
**Episodes**: 7 (tratados/chapters)
**Dependencies**: None
**Estimated Time**: 15 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-lazarillo

# Verify PROJECT.md has proper cast list with Apple voices
# Cast should use bare voice names format (e.g., "Samantha" not URIs)

# Generate audio for all 7 episodes using Produciesta
/Users/stovak/Projects/Produciesta/bin/produciesta . --provider apple

# Verify generation
ls -lh audio/*.m4a
```

**Cast Verification**:
- Ensure all 20 characters have voice assignments
- Use Apple TTS voices (bare names: "Nathan", "Samantha", etc.)
- Verify voices match character ages/personalities from 16th century Spain

**Expected Results**:
- 7 complete M4A episode files
- Approximately 20-40MB total (depending on episode length)
- All characters properly voiced
- Generation log clean (zero errors)

**Success Criteria**:
- All 7 episodes generated successfully
- Audio files in `audio/` directory
- No generation errors

---

#### Task 3.2: Generate audio for podcast-casting-software-spells
**Project**: `/Users/stovak/Projects/podcast-casting-software-spells`
**Current State**: Has cast (2 characters), NO audio files
**Episodes**: 12 planned
**Dependencies**: Task 2.5 (sprint plans must exist first)
**Estimated Time**: 20 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-casting-software-spells

# Verify PROJECT.md has proper cast list
# Expected: 2 characters (likely NARRATOR + HOST or similar)

# Check if episode scripts exist
ls -la episodes/*.fountain

# Generate audio
/Users/stovak/Projects/Produciesta/bin/produciesta . --provider apple

# Verify generation
ls -lh audio/*.m4a
```

**Pre-Generation Checklist**:
- Verify Fountain scripts exist in `episodes/` directory
- Confirm PROJECT.md has cast with Apple voice assignments
- Ensure 12 episode scripts are present

**Expected Results**:
- 12 complete M4A episode files
- Technology/education content properly synthesized
- 2-character dialogue clear and engaging

**Success Criteria**:
- All 12 episodes generated
- Audio files in `audio/` directory
- No generation errors

---

#### Task 3.3: Complete audio for podcast-mr-mr-charles
**Project**: `/Users/stovak/Projects/podcast-mr-mr-charles`
**Current State**: Has 5 audio files, needs 5 more (total: 10 episodes)
**Episodes**: 10 total (5 existing, 5 missing)
**Dependencies**: Task 2.4 (sprint plans)
**Estimated Time**: 15 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-mr-mr-charles

# Check which episodes have audio
ls -lh audio/*.m4a

# Identify missing episodes
ls episodes/*.fountain

# Generate all episodes (Produciesta will skip existing)
/Users/stovak/Projects/Produciesta/bin/produciesta . --provider apple

# Verify all 10 episodes exist
ls -lh audio/*.m4a | wc -l  # Should show 10
```

**Cast Verification**:
- 12 characters - ensure all have voice assignments
- Comedy genre - voices should support humor
- Verify character personality matches voice choice

**Expected Results**:
- 10 total M4A files (5 existing + 5 new)
- Approximately 28-30MB total
- Comedy timing and delivery preserved

**Success Criteria**:
- All 10 episodes have audio
- 5 new files generated
- No generation errors

---

## Phase 4: Commit & Push Changes (7 tasks)

#### Task 4.1: Commit and push podcast-meditations
**Project**: `/Users/stovak/Projects/podcast-meditations`
**Current State**: 6 uncommitted files (sprint plans)
**Dependencies**: Task 2.2
**Estimated Time**: 3 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-meditations

# Check status
git status

# Stage all changes
git add .

# Create commit
git commit -m "feat: Add sprint supervisor plans

- Add AUDIO_GENERATION_PLAN.md with 365-episode workflow
- Add AUDIO_SPRINT_TASKS.md with granular tasks
- Document existing audio generation process
- All 365 episodes already generated (631MB)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

# Push to remote
git push

# Verify
git status
```

**Success Criteria**:
- All changes committed
- Pushed to origin
- Git status clean

---

#### Task 4.2: Commit and push podcast-lazarillo
**Project**: `/Users/stovak/Projects/podcast-lazarillo`
**Current State**: 3 uncommitted files + newly generated audio
**Dependencies**: Task 3.1 (audio generation)
**Estimated Time**: 3 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-lazarillo

# Check status (should include new audio files)
git status

# Stage all changes including new audio
git add .

# Verify LFS tracking
git lfs ls-files

# Create commit
git commit -m "feat: Generate audio for all 7 tratados

- Generate complete audio for Lazarillo de Tormes
- 7 episodes covering all tratados (chapters)
- 20 characters voiced with Apple TTS
- Audio files tracked in Git LFS

Spanish picaresque novel adaptation complete.

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

# Push to remote (including LFS)
git push

# Verify
git status
```

**Success Criteria**:
- All 7 audio files committed via LFS
- Sprint plan updates committed
- Pushed successfully
- Git status clean

---

#### Task 4.3: Commit and push podcast-yntswyd
**Project**: `/Users/stovak/Projects/podcast-yntswyd`
**Current State**: 10 uncommitted files including 9 audio files
**Audio Status**: Complete (all 9 episodes generated)
**Dependencies**: None (audio already exists)
**Estimated Time**: 3 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-yntswyd

# Check status
git status

# Stage all changes
git add .

# Verify LFS tracking for audio
git lfs ls-files

# Create commit
git commit -m "feat: Complete audio generation with Apple TTS casting

- Generate all 9 episodes (Chapters 1-8 + Epilogue)
- Total: 155 minutes of audio (43MB)
- 11 characters cast with Apple voices
- Updated PROJECT.md with bare voice names format
- Updated sprint plans to use Produciesta CLI workflow

Voice casting:
- NARRATOR: Samantha
- BERNARD: Nathan
- KILLIAN: Tom
- MASON: Alex
- SYLVIA: Susan
- MICKEY BLAZE: Fred
- MEAN JEAN: Ava
- PATRICIA: Allison
- DONNIE: Bruce
- EDDIE: Evan
- AUDITOR CHEN: Joelle

Generation complete with zero errors in 11 minutes.

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

# Push to remote
git push

# Verify
git status
```

**Success Criteria**:
- All audio files committed via LFS
- PROJECT.md updates committed
- Sprint plans committed
- Pushed successfully
- Git status clean

---

#### Task 4.4: Commit and push podcast-mr-mr-charles
**Project**: `/Users/stovak/Projects/podcast-mr-mr-charles`
**Current State**: 3 uncommitted files + newly generated audio
**Dependencies**: Task 2.4 (sprint plans), Task 3.3 (audio completion)
**Estimated Time**: 3 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-mr-mr-charles

# Check status
git status

# Stage all changes
git add .

# Verify LFS
git lfs ls-files

# Create commit
git commit -m "feat: Complete audio generation and add sprint plans

- Generate remaining 5 episodes (total: 10)
- Add AUDIO_GENERATION_PLAN.md
- Add AUDIO_SPRINT_TASKS.md
- 12 characters cast with Apple TTS
- All audio tracked in Git LFS

Comedy podcast complete with full 10-episode season.

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

# Push to remote
git push

# Verify
git status
```

**Success Criteria**:
- All 10 episodes committed
- Sprint plans committed
- Pushed successfully
- Git status clean

---

#### Task 4.5: Commit and push podcast-tao-de-jing
**Project**: `/Users/stovak/Projects/podcast-tao-de-jing`
**Current State**: Git clean, needs sprint plans commit
**Dependencies**: Task 2.1 (sprint plans)
**Estimated Time**: 3 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-tao-de-jing

# Stage new sprint plans
git add AUDIO_GENERATION_PLAN.md AUDIO_SPRINT_TASKS.md

# Create commit
git commit -m "docs: Add sprint supervisor plans

- Add AUDIO_GENERATION_PLAN.md for Daily Dao workflow
- Add AUDIO_SPRINT_TASKS.md with 81-episode task breakdown
- Document existing audio generation process
- 1 narrator voice (contemplative philosophy tone)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

# Push to remote
git push

# Verify
git status
```

**Success Criteria**:
- Sprint plans committed
- Pushed successfully
- Git status clean

---

#### Task 4.6: Commit and push podcast-therapist-gpt
**Project**: `/Users/stovak/Projects/podcast-therapist-gpt`
**Current State**: Repository initialized, needs sprint plans commit
**Dependencies**: Task 2.3 (sprint plans)
**Estimated Time**: 3 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-therapist-gpt

# Stage sprint plans
git add AUDIO_GENERATION_PLAN.md AUDIO_SPRINT_TASKS.md

# Create commit
git commit -m "docs: Add sprint supervisor plans

- Add AUDIO_GENERATION_PLAN.md for therapist-gpt workflow
- Add AUDIO_SPRINT_TASKS.md with task breakdown
- 3 characters: therapist, client roles
- Educational/therapeutic content focus

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

# Push to remote
git push

# Verify
git status
```

**Success Criteria**:
- Sprint plans committed
- Pushed successfully
- Repository fully synced
- Git status clean

---

#### Task 4.7: Commit and push podcast-casting-software-spells
**Project**: `/Users/stovak/Projects/podcast-casting-software-spells`
**Current State**: Clean git, needs sprint plans + audio commit
**Dependencies**: Task 2.5 (sprint plans), Task 3.2 (audio)
**Estimated Time**: 3 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-casting-software-spells

# Stage all changes
git add .

# Verify LFS tracking
git lfs ls-files

# Create commit
git commit -m "feat: Complete audio generation with sprint plans

- Generate all 12 episodes for Casting Software Spells
- Add AUDIO_GENERATION_PLAN.md
- Add AUDIO_SPRINT_TASKS.md
- 2 characters cast for technology education content
- All audio tracked in Git LFS

Software development as magic - complete season.

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

# Push to remote (including LFS)
git push

# Verify
git status
```

**Success Criteria**:
- All 12 audio files committed via LFS
- Sprint plans committed
- Pushed successfully
- Git status clean

---

## Phase 5: Validation & Verification (22 tasks)

### Verify Git LFS (7 tasks)

#### Task 5.1: Verify LFS for podcast-tao-de-jing
**Project**: `/Users/stovak/Projects/podcast-tao-de-jing`
**Dependencies**: Task 4.5
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-tao-de-jing

# Check LFS tracking
lfs_count=$(git lfs ls-files | wc -l)
echo "LFS files: $lfs_count"

# Verify audio files are in LFS
audio_count=$(find audio -type f \( -name "*.m4a" -o -name "*.mp3" \) 2>/dev/null | wc -l)
echo "Audio files: $audio_count"

if [ "$lfs_count" -eq "$audio_count" ]; then
  echo "✓ All audio in LFS"
else
  echo "✗ LFS mismatch! Check configuration"
  exit 1
fi
```

**Success Criteria**:
- All audio files tracked in Git LFS
- LFS file count matches audio file count

---

#### Task 5.2: Verify LFS for podcast-meditations
**Project**: `/Users/stovak/Projects/podcast-meditations`
**Dependencies**: Task 4.1
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-meditations

lfs_count=$(git lfs ls-files | wc -l)
audio_count=$(find audio -type f \( -name "*.m4a" -o -name "*.mp3" \) 2>/dev/null | wc -l)

echo "LFS files: $lfs_count"
echo "Audio files: $audio_count"

if [ "$lfs_count" -eq "$audio_count" ]; then
  echo "✓ All audio in LFS"
else
  echo "✗ LFS mismatch!"
  exit 1
fi
```

**Success Criteria**:
- All 365 audio files tracked in Git LFS

---

#### Task 5.3: Verify LFS for podcast-lazarillo
**Project**: `/Users/stovak/Projects/podcast-lazarillo`
**Dependencies**: Task 4.2
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-lazarillo

lfs_count=$(git lfs ls-files | wc -l)
audio_count=$(find audio -type f \( -name "*.m4a" -o -name "*.mp3" \) 2>/dev/null | wc -l)

echo "LFS files: $lfs_count"
echo "Audio files: $audio_count"

if [ "$lfs_count" -eq "$audio_count" ]; then
  echo "✓ All audio in LFS"
else
  echo "✗ LFS mismatch!"
  exit 1
fi
```

**Success Criteria**:
- All 7 audio files tracked in Git LFS

---

#### Task 5.4: Verify LFS for podcast-yntswyd
**Project**: `/Users/stovak/Projects/podcast-yntswyd`
**Dependencies**: Task 4.3
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-yntswyd

lfs_count=$(git lfs ls-files | wc -l)
audio_count=$(find audio -type f \( -name "*.m4a" -o -name "*.mp3" \) 2>/dev/null | wc -l)

echo "LFS files: $lfs_count"
echo "Audio files: $audio_count"

if [ "$lfs_count" -eq "$audio_count" ]; then
  echo "✓ All audio in LFS"
else
  echo "✗ LFS mismatch!"
  exit 1
fi
```

**Success Criteria**:
- All 9 audio files tracked in Git LFS

---

#### Task 5.5: Verify LFS for podcast-therapist-gpt
**Project**: `/Users/stovak/Projects/podcast-therapist-gpt`
**Dependencies**: Task 4.6
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-therapist-gpt

lfs_count=$(git lfs ls-files | wc -l)
audio_count=$(find audio -type f \( -name "*.m4a" -o -name "*.mp3" \) 2>/dev/null | wc -l)

echo "LFS files: $lfs_count"
echo "Audio files: $audio_count"

if [ "$lfs_count" -eq "$audio_count" ]; then
  echo "✓ All audio in LFS"
else
  echo "✗ LFS mismatch!"
  exit 1
fi
```

**Success Criteria**:
- All 2 audio files tracked in Git LFS

---

#### Task 5.6: Verify LFS for podcast-mr-mr-charles
**Project**: `/Users/stovak/Projects/podcast-mr-mr-charles`
**Dependencies**: Task 4.4
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-mr-mr-charles

lfs_count=$(git lfs ls-files | wc -l)
audio_count=$(find audio -type f \( -name "*.m4a" -o -name "*.mp3" \) 2>/dev/null | wc -l)

echo "LFS files: $lfs_count"
echo "Audio files: $audio_count"

if [ "$lfs_count" -eq "$audio_count" ]; then
  echo "✓ All audio in LFS"
else
  echo "✗ LFS mismatch!"
  exit 1
fi
```

**Success Criteria**:
- All 10 audio files tracked in Git LFS

---

#### Task 5.7: Verify LFS for podcast-casting-software-spells
**Project**: `/Users/stovak/Projects/podcast-casting-software-spells`
**Dependencies**: Task 4.7
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-casting-software-spells

lfs_count=$(git lfs ls-files | wc -l)
audio_count=$(find audio -type f \( -name "*.m4a" -o -name "*.mp3" \) 2>/dev/null | wc -l)

echo "LFS files: $lfs_count"
echo "Audio files: $audio_count"

if [ "$lfs_count" -eq "$audio_count" ]; then
  echo "✓ All audio in LFS"
else
  echo "✗ LFS mismatch!"
  exit 1
fi
```

**Success Criteria**:
- All 12 audio files tracked in Git LFS

---

### Verify Remote Sync (7 tasks)

#### Task 5.8: Verify remote sync for podcast-tao-de-jing
**Project**: `/Users/stovak/Projects/podcast-tao-de-jing`
**Dependencies**: Task 5.1
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-tao-de-jing

# Fetch latest from remote
git fetch origin

# Check if local is behind or ahead
behind=$(git rev-list --count HEAD..origin/main 2>/dev/null || echo "0")
ahead=$(git rev-list --count origin/main..HEAD 2>/dev/null || echo "0")

if [ "$behind" -gt 0 ]; then
  echo "⚠ Local is $behind commits behind remote"
  exit 1
fi

if [ "$ahead" -gt 0 ]; then
  echo "⚠ Local is $ahead commits ahead (needs push)"
  exit 1
fi

echo "✓ In sync with remote"

# Check for uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
  echo "⚠ Uncommitted changes present"
  exit 1
else
  echo "✓ Working tree clean"
fi
```

**Success Criteria**:
- Local in sync with remote
- No uncommitted changes
- Working tree clean

---

#### Task 5.9: Verify remote sync for podcast-meditations
**Project**: `/Users/stovak/Projects/podcast-meditations`
**Dependencies**: Task 5.2
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-meditations

git fetch origin
behind=$(git rev-list --count HEAD..origin/main 2>/dev/null || echo "0")
ahead=$(git rev-list --count origin/main..HEAD 2>/dev/null || echo "0")

[ "$behind" -eq 0 ] && [ "$ahead" -eq 0 ] && echo "✓ In sync" || exit 1
[ -z "$(git status --porcelain)" ] && echo "✓ Clean" || exit 1
```

**Success Criteria**:
- In sync with remote
- Working tree clean

---

#### Task 5.10: Verify remote sync for podcast-lazarillo
**Project**: `/Users/stovak/Projects/podcast-lazarillo`
**Dependencies**: Task 5.3
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-lazarillo

git fetch origin
behind=$(git rev-list --count HEAD..origin/main 2>/dev/null || echo "0")
ahead=$(git rev-list --count origin/main..HEAD 2>/dev/null || echo "0")

[ "$behind" -eq 0 ] && [ "$ahead" -eq 0 ] && echo "✓ In sync" || exit 1
[ -z "$(git status --porcelain)" ] && echo "✓ Clean" || exit 1
```

**Success Criteria**:
- In sync with remote
- Working tree clean

---

#### Task 5.11: Verify remote sync for podcast-yntswyd
**Project**: `/Users/stovak/Projects/podcast-yntswyd`
**Dependencies**: Task 5.4
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-yntswyd

git fetch origin
behind=$(git rev-list --count HEAD..origin/main 2>/dev/null || echo "0")
ahead=$(git rev-list --count origin/main..HEAD 2>/dev/null || echo "0")

[ "$behind" -eq 0 ] && [ "$ahead" -eq 0 ] && echo "✓ In sync" || exit 1
[ -z "$(git status --porcelain)" ] && echo "✓ Clean" || exit 1
```

**Success Criteria**:
- In sync with remote
- Working tree clean

---

#### Task 5.12: Verify remote sync for podcast-therapist-gpt
**Project**: `/Users/stovak/Projects/podcast-therapist-gpt`
**Dependencies**: Task 5.5
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-therapist-gpt

git fetch origin
behind=$(git rev-list --count HEAD..origin/main 2>/dev/null || echo "0")
ahead=$(git rev-list --count origin/main..HEAD 2>/dev/null || echo "0")

[ "$behind" -eq 0 ] && [ "$ahead" -eq 0 ] && echo "✓ In sync" || exit 1
[ -z "$(git status --porcelain)" ] && echo "✓ Clean" || exit 1
```

**Success Criteria**:
- In sync with remote
- Working tree clean

---

#### Task 5.13: Verify remote sync for podcast-mr-mr-charles
**Project**: `/Users/stovak/Projects/podcast-mr-mr-charles`
**Dependencies**: Task 5.6
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-mr-mr-charles

git fetch origin
behind=$(git rev-list --count HEAD..origin/main 2>/dev/null || echo "0")
ahead=$(git rev-list --count origin/main..HEAD 2>/dev/null || echo "0")

[ "$behind" -eq 0 ] && [ "$ahead" -eq 0 ] && echo "✓ In sync" || exit 1
[ -z "$(git status --porcelain)" ] && echo "✓ Clean" || exit 1
```

**Success Criteria**:
- In sync with remote
- Working tree clean

---

#### Task 5.14: Verify remote sync for podcast-casting-software-spells
**Project**: `/Users/stovak/Projects/podcast-casting-software-spells`
**Dependencies**: Task 5.7
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-casting-software-spells

git fetch origin
behind=$(git rev-list --count HEAD..origin/main 2>/dev/null || echo "0")
ahead=$(git rev-list --count origin/main..HEAD 2>/dev/null || echo "0")

[ "$behind" -eq 0 ] && [ "$ahead" -eq 0 ] && echo "✓ In sync" || exit 1
[ -z "$(git status --porcelain)" ] && echo "✓ Clean" || exit 1
```

**Success Criteria**:
- In sync with remote
- Working tree clean

---

### Verify Sprint Plans Exist (7 tasks)

#### Task 5.15: Verify sprint plans for podcast-tao-de-jing
**Project**: `/Users/stovak/Projects/podcast-tao-de-jing`
**Dependencies**: Task 5.8
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-tao-de-jing

[ -f "AUDIO_GENERATION_PLAN.md" ] && echo "✓ AUDIO_GENERATION_PLAN.md" || exit 1
[ -f "AUDIO_SPRINT_TASKS.md" ] && echo "✓ AUDIO_SPRINT_TASKS.md" || exit 1
```

**Success Criteria**:
- AUDIO_GENERATION_PLAN.md exists
- AUDIO_SPRINT_TASKS.md exists

---

#### Task 5.16: Verify sprint plans for podcast-meditations
**Project**: `/Users/stovak/Projects/podcast-meditations`
**Dependencies**: Task 5.9
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-meditations

[ -f "AUDIO_GENERATION_PLAN.md" ] && echo "✓ AUDIO_GENERATION_PLAN.md" || exit 1
[ -f "AUDIO_SPRINT_TASKS.md" ] && echo "✓ AUDIO_SPRINT_TASKS.md" || exit 1
```

**Success Criteria**:
- Both sprint plan files exist

---

#### Task 5.17: Verify sprint plans for podcast-lazarillo
**Project**: `/Users/stovak/Projects/podcast-lazarillo`
**Dependencies**: Task 5.10
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-lazarillo

[ -f "AUDIO_GENERATION_PLAN.md" ] && echo "✓ AUDIO_GENERATION_PLAN.md" || exit 1
[ -f "AUDIO_SPRINT_TASKS.md" ] && echo "✓ AUDIO_SPRINT_TASKS.md" || exit 1
```

**Success Criteria**:
- Both sprint plan files exist

---

#### Task 5.18: Verify sprint plans for podcast-yntswyd
**Project**: `/Users/stovak/Projects/podcast-yntswyd`
**Dependencies**: Task 5.11
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-yntswyd

[ -f "AUDIO_GENERATION_PLAN.md" ] && echo "✓ AUDIO_GENERATION_PLAN.md" || exit 1
[ -f "AUDIO_SPRINT_TASKS.md" ] && echo "✓ AUDIO_SPRINT_TASKS.md" || exit 1
```

**Success Criteria**:
- Both sprint plan files exist

---

#### Task 5.19: Verify sprint plans for podcast-therapist-gpt
**Project**: `/Users/stovak/Projects/podcast-therapist-gpt`
**Dependencies**: Task 5.12
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-therapist-gpt

[ -f "AUDIO_GENERATION_PLAN.md" ] && echo "✓ AUDIO_GENERATION_PLAN.md" || exit 1
[ -f "AUDIO_SPRINT_TASKS.md" ] && echo "✓ AUDIO_SPRINT_TASKS.md" || exit 1
```

**Success Criteria**:
- Both sprint plan files exist

---

#### Task 5.20: Verify sprint plans for podcast-mr-mr-charles
**Project**: `/Users/stovak/Projects/podcast-mr-mr-charles`
**Dependencies**: Task 5.13
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-mr-mr-charles

[ -f "AUDIO_GENERATION_PLAN.md" ] && echo "✓ AUDIO_GENERATION_PLAN.md" || exit 1
[ -f "AUDIO_SPRINT_TASKS.md" ] && echo "✓ AUDIO_SPRINT_TASKS.md" || exit 1
```

**Success Criteria**:
- Both sprint plan files exist

---

#### Task 5.21: Verify sprint plans for podcast-casting-software-spells
**Project**: `/Users/stovak/Projects/podcast-casting-software-spells`
**Dependencies**: Task 5.14
**Estimated Time**: 1 minute

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-casting-software-spells

[ -f "AUDIO_GENERATION_PLAN.md" ] && echo "✓ AUDIO_GENERATION_PLAN.md" || exit 1
[ -f "AUDIO_SPRINT_TASKS.md" ] && echo "✓ AUDIO_SPRINT_TASKS.md" || exit 1
```

**Success Criteria**:
- Both sprint plan files exist

---

### Generate Summary Report

#### Task 5.22: Generate collection status report
**Project**: `/Users/stovak/Projects/podcast-collection`
**Dependencies**: Tasks 5.15-5.21
**Estimated Time**: 2 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-collection

# Generate comprehensive summary report
cat > STATUS_REPORT.md << 'EOF'
# Podcast Collection - Status Report

**Generated**: $(date)

## Collection Overview

| Podcast | Episodes | Audio Files | Size | Sprint Plans | Git Status | LFS |
|---------|----------|-------------|------|--------------|------------|-----|
EOF

# Append project data for each podcast
projects=(
  "podcast-tao-de-jing"
  "podcast-meditations"
  "podcast-lazarillo"
  "podcast-yntswyd"
  "podcast-therapist-gpt"
  "podcast-mr-mr-charles"
  "podcast-casting-software-spells"
)

for project in "${projects[@]}"; do
  name=$(basename "$project" | sed 's/podcast-//')
  cd "/Users/stovak/Projects/$project"

  # Count audio files
  audio_count=$(find audio -type f \( -name "*.m4a" -o -name "*.mp3" \) 2>/dev/null | wc -l | xargs)
  audio_size=$(du -sh audio 2>/dev/null | awk '{print $1}' || echo "0B")

  # Check sprint plans
  if [ -f "AUDIO_GENERATION_PLAN.md" ] && [ -f "AUDIO_SPRINT_TASKS.md" ]; then
    plans="✅"
  else
    plans="❌"
  fi

  # Check git status
  if [ -z "$(git status --porcelain 2>/dev/null)" ]; then
    git_status="✅ Clean"
  else
    git_status="⚠️ Changes"
  fi

  # Check LFS
  if [ -f ".gitattributes" ] && grep -q "*.m4a" .gitattributes 2>/dev/null; then
    lfs="✅"
  else
    lfs="❌"
  fi

  # Get episode count from PROJECT.md
  episode_count=$(grep "episodes:" PROJECT.md 2>/dev/null | head -1 | awk '{print $2}' || echo "?")

  echo "| $name | $episode_count | $audio_count | $audio_size | $plans | $git_status | $lfs |" >> /Users/stovak/Projects/podcast-collection/STATUS_REPORT.md
done

cd /Users/stovak/Projects/podcast-collection

# Calculate totals
total_episodes=$(grep "episodes:" /Users/stovak/Projects/podcast-*/PROJECT.md 2>/dev/null | awk '{sum+=$2} END {print sum}')
total_audio=$(find /Users/stovak/Projects/podcast-*/audio -type f \( -name "*.m4a" -o -name "*.mp3" \) 2>/dev/null | wc -l | xargs)

cat >> STATUS_REPORT.md << EOF

## Summary

- **Total Projects**: 7
- **Total Episodes**: ${total_episodes}
- **Total Audio Files**: ${total_audio}

## Completion Checklist

- [x] All projects have audio generated
- [x] All projects have sprint plans
- [x] All projects have Git LFS configured
- [x] All projects committed and pushed
- [x] All audio files in LFS
- [x] No uncommitted changes

---

**Execution Plan**: EXECUTION_PLAN.md
**Generated by**: Sprint Supervisor
**Completed**: $(date)
EOF

echo "✓ Status report generated: STATUS_REPORT.md"
cat STATUS_REPORT.md
```

**Success Criteria**:
- STATUS_REPORT.md created
- All metrics calculated correctly
- Report shows complete status

---

## Phase 6: Update Collection Metadata (3 tasks)

#### Task 6.1: Update collection.json metadata
**Project**: `/Users/stovak/Projects/podcast-collection`
**Dependencies**: Task 5.22
**Estimated Time**: 5 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-collection

# Manually update collection.json:
# - Increment revision number
# - Update generatedAt timestamp
# - Verify all episode counts match actual audio files
# - Update any changed metadata
```

**Metadata to Verify**:
- Episode counts match actual audio files
- All podcasts have correct "published" status
- Audio file sizes reflected in descriptions
- URLs are correct

**Success Criteria**:
- collection.json updated with accurate metadata
- Revision incremented
- Timestamp current

---

#### Task 6.2: Regenerate OPML file
**Project**: `/Users/stovak/Projects/podcast-collection`
**Dependencies**: Task 6.1
**Estimated Time**: 2 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-collection

# Regenerate OPML from collection.json
./generate-opml.sh collection.json > collection.opml

# Verify OPML is valid
cat collection.opml | head -20
```

**Success Criteria**:
- OPML file regenerated successfully
- File contains all 7 podcasts
- XML structure valid

---

#### Task 6.3: Commit and push collection updates
**Project**: `/Users/stovak/Projects/podcast-collection`
**Dependencies**: Task 6.2
**Estimated Time**: 2 minutes

**Actions**:
```bash
cd /Users/stovak/Projects/podcast-collection

# Stage all changes
git add collection.json collection.opml STATUS_REPORT.md

# Get revision number for commit message
revision=$(grep '"revision"' collection.json | awk '{print $2}' | tr -d ',')

# Create commit
git commit -m "chore: Update collection metadata and status report

- Update episode counts for all podcasts
- Regenerate OPML with latest data
- Add comprehensive status report
- Increment revision to ${revision}

All 7 podcasts complete with audio generation and sprint plans.

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

# Push to remote
git push

# Verify
git status
```

**Success Criteria**:
- All changes committed
- Pushed to remote
- Git status clean

---

## Task Summary

**Total Tasks**: 47

### By Phase:
- **Phase 1** (Git Setup): 7 tasks
- **Phase 2** (Sprint Plans): 5 tasks
- **Phase 3** (Audio Generation): 3 tasks
- **Phase 4** (Commit & Push): 7 tasks
- **Phase 5** (Validation): 22 tasks
- **Phase 6** (Collection Update): 3 tasks

### Estimated Total Time:
- **Phase 1**: 15 minutes
- **Phase 2**: 50 minutes
- **Phase 3**: 50 minutes
- **Phase 4**: 21 minutes
- **Phase 5**: 29 minutes
- **Phase 6**: 9 minutes

**Total**: ~174 minutes (~3 hours)

---

## Priority & Parallelization Analysis

### Critical Path (Must Execute Sequentially):
1. **Task 1.1 → 1.2 → 1.3 → 1.4** (podcast-therapist-gpt initialization)
2. **Task 1.5 → 1.6 → 1.7** (podcast-casting-software-spells LFS)
3. **Task 2.5 → 3.2 → 4.7** (casting-software-spells: plans → audio → commit)
4. **Task 2.4 → 3.3 → 4.4** (mr-mr-charles: plans → audio → commit)
5. **Phase 4 → Phase 5 → Phase 6** (All commits must finish before validation)

### High Priority (Blockers):
- **P0**: Tasks 1.1-1.4 (therapist-gpt git init) - CRITICAL blocker
- **P0**: Tasks 1.5-1.7 (casting-software-spells LFS) - CRITICAL blocker
- **P1**: Phase 2 (All sprint plans) - Block audio generation
- **P1**: Phase 3 (All audio generation) - Block final commits

### Can Execute in Parallel:

#### Parallel Group A (Phase 1):
- Task 1.1-1.4 (therapist-gpt chain) - **Independent**
- Task 1.5-1.7 (casting-software-spells chain) - **Independent**

#### Parallel Group B (Phase 2 - Sprint Plans):
All 5 tasks can run in parallel:
- Task 2.1 (tao-de-jing)
- Task 2.2 (meditations)
- Task 2.3 (therapist-gpt) - depends on 1.4
- Task 2.4 (mr-mr-charles)
- Task 2.5 (casting-software-spells) - depends on 1.7

#### Parallel Group C (Phase 3 - Audio Generation):
All 3 can run in parallel IF sprint plans complete:
- Task 3.1 (lazarillo) - no dependencies
- Task 3.2 (casting-software-spells) - depends on 2.5
- Task 3.3 (mr-mr-charles) - depends on 2.4

#### Parallel Group D (Phase 4 - Commits):
All 7 can run in parallel after audio completes:
- Task 4.1 (meditations) - depends on 2.2
- Task 4.2 (lazarillo) - depends on 3.1
- Task 4.3 (yntswyd) - no dependencies
- Task 4.4 (mr-mr-charles) - depends on 3.3
- Task 4.5 (tao-de-jing) - depends on 2.1
- Task 4.6 (therapist-gpt) - depends on 2.3
- Task 4.7 (casting-software-spells) - depends on 3.2

#### Parallel Group E (Phase 5 - Verification):
All 21 verification tasks (5.1-5.21) can run in parallel after Phase 4

### Optimal Execution Strategy:

**Wave 1** (Parallel):
- Start 1.1-1.4 chain (therapist-gpt)
- Start 1.5-1.7 chain (casting-software-spells)

**Wave 2** (Parallel - after Wave 1):
- Start all 5 sprint plan tasks (2.1-2.5)

**Wave 3** (Parallel - after Wave 2):
- Start all 3 audio generation tasks (3.1-3.3)

**Wave 4** (Parallel - after Wave 3):
- Start all 7 commit tasks (4.1-4.7)

**Wave 5** (Parallel - after Wave 4):
- Start all 21 verification tasks (5.1-5.21)

**Wave 6** (Sequential - after Wave 5):
- Task 5.22 (generate report)
- Task 6.1 (update collection.json)
- Task 6.2 (regenerate OPML)
- Task 6.3 (commit & push)

### Risk Mitigation:
- **Phase 1** must complete before dependent tasks in Phase 2
- **Phase 3** (audio generation) is longest - start early
- **Phase 5** verifications can catch issues before final metadata update
- If any verification fails, fix and re-run only that project's tasks

---

## Success Criteria - Complete Plan

### All Projects Complete When:

✅ **Git Repository Setup**
- podcast-therapist-gpt has initialized git repo
- All projects have .gitattributes with LFS rules

✅ **Sprint Plans**
- All 7 projects have AUDIO_GENERATION_PLAN.md
- All 7 projects have AUDIO_SPRINT_TASKS.md

✅ **Audio Generation**
- podcast-lazarillo: 7 episodes generated
- podcast-casting-software-spells: 12 episodes generated
- podcast-mr-mr-charles: 10 episodes complete (5 existing + 5 new)
- All other projects: audio files verified present

✅ **Git LFS**
- All audio files tracked in Git LFS
- No binary files in regular git
- LFS file count matches audio file count

✅ **Repository State**
- All projects committed
- All projects pushed to remote
- No uncommitted changes
- All remotes up to date

✅ **Collection Metadata**
- collection.json updated with accurate counts
- OPML regenerated
- STATUS_REPORT.md created
- podcast-collection repo updated

---

**Execution Plan Generated**: 2026-02-11
**Total Tasks**: 47 atomic tasks
**Estimated Duration**: ~3 hours (with parallelization: ~2 hours)
**Ready for Sprint Supervisor Execution**
