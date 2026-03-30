# Fountain Format Quick Reference

Highland 2 uses the Fountain screenplay format for the `text.md` file. This is a brief reference for understanding Fountain syntax when reading .highland files.

## Title Page

Title page elements are at the beginning of the document with key-value pairs:

```fountain
TITLE:
    Big Fish
CREDIT:
    written by
AUTHOR:
    John August
INFO:
    based on the novel by Daniel Wallace
```

Common keys: `TITLE:`, `CREDIT:`, `AUTHOR:`, `SOURCE:`, `DRAFT DATE:`, `CONTACT:`, `INFO:`

## Scene Headings

Lines starting with `INT.`, `EXT.`, `INT./EXT.`, `I/E`, or `EST.` (case insensitive):

```fountain
INT. BEDROOM - NIGHT

EXT. CENTRAL PARK - DAY

INT./EXT. CAR - CONTINUOUS
```

## Action

Regular paragraphs are action/description:

```fountain
The Beast's journey takes it past a dangling fish hook, baited with worms.
```

## Character Names

Character names are in ALL CAPS on their own line, followed by dialogue:

```fountain
EDWARD
There are some fish that cannot be caught.
```

## Dialogue

Text following a character name is dialogue:

```fountain
EDWARD
It's not that they're faster or stronger than other fish.
They're just touched by something extra.
```

## Parentheticals

Dialogue direction in parentheses on its own line:

```fountain
EDWARD
(whispering)
Call it luck. Call it grace.
```

## Character Extensions

Extensions like (V.O.), (O.S.), (CONT'D) follow character names:

```fountain
EDWARD (V.O.)
By the time I was born, he was already a legend.
```

## Transitions

Transitions are right-aligned and in ALL CAPS ending with `TO:`:

```fountain
CUT TO:

FADE OUT.

DISSOLVE TO:
```

Or force a transition with `>`:

```fountain
> FADE TO BLACK
```

## Notes

Notes are wrapped in `[[ ]]` and are not included in output:

```fountain
[[This is a note for the writer]]
```

## Sections and Synopses

Sections start with `#` (not included in output):

```fountain
# Act I

## Opening Scene
```

Synopses start with `=` (not included in output):

```fountain
= Will arrives to find his father on his deathbed.
```

## Centered Text

Text wrapped in `> <` is centered:

```fountain
> _ACT I_ <

> THE END <
```

## Emphasis

- `*italics*` → *italics*
- `**bold**` → **bold**
- `***bold italic***` → ***bold italic***
- `_underline_` → underline

## Page Breaks

Three or more equals signs:

```fountain
===
```

## Forced Elements

Prefix with special characters to force element types:

- `.` - Force scene heading: `.ROOFTOP`
- `!` - Force action: `!This is action`
- `@` - Force character: `@McCLANE`
- `~` - Force lyrics (centered italic)

## Common Patterns

**Dual Dialogue** (two characters speaking simultaneously):
```fountain
CHARACTER A
Dialogue for A.

^CHARACTER B
Dialogue for B.
```

**Scene Numbers**:
```fountain
INT. KITCHEN - DAY #10#
```

For complete Fountain specification, see: https://fountain.io/syntax
