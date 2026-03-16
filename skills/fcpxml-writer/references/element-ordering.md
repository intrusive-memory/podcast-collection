# FCPXML v1.11 DTD Element Ordering Reference

FCP validates FCPXML against its DTD on import. Child element order is strict. This reference documents the required ordering for every commonly-used element.

## Entity Definitions

These macros expand inside element definitions:

```
%time;           = CDATA (rational format: "value/timescales" e.g. "417792/24000s")
%audioHz;        = ( 32k | 44.1k | 48k | 88.2k | 96k | 176.4k | 192k )
%timing-params;  = (conform-rate?, timeMap?)
%intrinsic-params-video; = (object-tracker?, adjust-crop?, adjust-corners?, adjust-conform?,
                    adjust-transform?, adjust-blend?, adjust-stabilization?,
                    adjust-rollingShutter?, adjust-360-transform?, adjust-reorient?,
                    adjust-orientation?, adjust-cinematic?, adjust-colorConform?)
%intrinsic-params-audio; = (adjust-volume?, adjust-panner?)
%intrinsic-params; = (%intrinsic-params-video;, %intrinsic-params-audio;)
%anchor_item;    = audio | video | clip | title | caption | mc-clip | ref-clip |
                   sync-clip | asset-clip | audition | spine | live-drawing
%clip_item;      = audio | video | clip | title | mc-clip | ref-clip | sync-clip |
                   asset-clip | audition | gap | live-drawing
%marker_item;    = (marker | chapter-marker | rating | keyword | analysis-marker)
%video_filter_item; = (filter-video | filter-video-mask)
%event_item;     = clip | audition | mc-clip | ref-clip | sync-clip | asset-clip |
                   collection-folder | keyword-collection | smart-collection | project
```

## Root Element

```
fcpxml = (import-options?, resources?, (library | event* | (%event_item;)*))
  version: FIXED "1.11"
```

## Resources

```
resources = (asset | effect | format | media | locator)*
```

### format (EMPTY — no children)
Attrs: id(required), name, frameDuration, fieldOrder, width, height, paspH, paspV, colorSpace, projection, stereoscopic

### asset = (media-rep+, metadata?)
Attrs: id(required), name, uid, start, duration, hasVideo, format, hasAudio, videoSources, audioSources, audioChannels, audioRate

### media-rep (EMPTY — no children)
Attrs: kind, sig, src(required), suggestedFilename

## Structure Elements

### event = (%event_item;)*
Attrs: name, uid

### project = (sequence)
Attrs: name, uid, id, modDate

### sequence = (note?, spine, metadata?)
Attrs: format(IDREF), duration, tcStart, tcFormat, audioLayout, audioRate, renderFormat, keywords

### spine = (%clip_item; | transition)*
Attrs: lane, offset, name, format

## Clip Elements

### asset-clip — STRICT ORDER:
```
1. note?
2. %timing-params;         → conform-rate?, timeMap?
3. %intrinsic-params;      → video adjustments..., adjust-volume?, adjust-panner?
4. (%anchor_item;)*        → audio|video|clip|title|caption|mc-clip|ref-clip|
                              sync-clip|asset-clip|audition|spine|live-drawing
5. (%marker_item;)*        → marker|chapter-marker|rating|keyword|analysis-marker
6. audio-channel-source*
7. (%video_filter_item;)*  → filter-video|filter-video-mask
8. filter-audio*
9. metadata?
```
Attrs: ref(required IDREF to asset), name, start, duration, enabled, lane, offset, srcEnable, audioStart, audioDuration, audioRole, videoRole, modDate, tcFormat

### gap — STRICT ORDER:
```
1. note?
2. (%anchor_item;)*        → caption, asset-clip, spine, etc.
3. (%marker_item;)*        → marker, chapter-marker, etc.
4. metadata?
```
Attrs: name, offset, start, duration(required), enabled

## Caption Element

### caption = (text*, text-style-def*, note?)
Attrs: name, start, duration(required), enabled, lane, offset, role

Role format for captions: `SRT?captionFormat=SRT.en` or `iTT?captionFormat=ITT.en`

### text = (text-style | text-style-def)*
Attrs: placement (bottom | top | left | right | center)

### text-style-def = (text-style)
Attrs: id(required)

### text-style (EMPTY — no children, or contains text content)
Attrs: ref, font, fontSize, fontFace, fontColor, bold, italic, strokeColor, strokeWidth, backgroundColor, alignment

## Marker Elements

### marker (EMPTY)
Attrs: start(required), duration(required), value(required), note, completed

### chapter-marker (EMPTY)
Attrs: start(required), duration(required), value(required), note, posterOffset
