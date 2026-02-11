# Intrusive Memory Podcast Collection

A curated collection of podcasts from **Intrusive Memory** - featuring literary adaptations, philosophical meditations, and original fiction series.

## What is a Podcast Collection?

Similar to [Swift Package Collections](https://swift.org/blog/package-collections/), this is a structured JSON file that aggregates multiple podcast feeds with rich metadata for discovery and subscription management. While individual podcasts use RSS/XML feeds, this collection provides:

- **Structured metadata** for discovery (genres, keywords, status)
- **JSON Schema validation** for consistency
- **Collection-level curation** and organization
- **OPML export** for compatibility with existing podcast apps

## Included Podcasts

| Podcast | Episodes | Genre | Description |
|---------|----------|-------|-------------|
| [Daily Dao - Tao De Jing](#daily-dao---tao-de-jing-podcast) | 81 | Philosophy | A contemplative journey through the 81 chapters of Laozi's ancient Chinese philosophical text. |
| [Meditations](#meditations) | 365 | Philosophy | Daily readings from Marcus Aurelius' personal writings on Stoic philosophy and the art of living. |
| [The Life of Lazarillo de Tormes](#the-life-of-lazarillo-de-tormes) | 7 | Literature/Fiction | A modern English translation of the anonymous 16th-century Spanish picaresque novel. |
| [You're Nobody til Somebody Wants You Dead](#youre-nobody-til-somebody-wants-you-dead) | 9 | Fiction | A noir-style fiction podcast exploring themes of identity, mortality, and what it means to be seen. |
| [Podcast Therapist GPT Episodes](#podcast-therapist-gpt-episodes) | 2 | Education | Therapeutic insights and mental health guidance through AI-generated conversations. |
| [Podcast Mr Mr Charles](#podcast-mr-mr-charles) | 10 | Comedy | A comedy podcast series featuring original characters and humorous storytelling. |
| [Casting Software Spells](#casting-software-spells) | 12 | Technology/Education | Exploring software development as modern magic through agentic incantation and AI-powered automation. |

## Using This Collection

### Subscribe to All Podcasts (OPML)

Download [`collection.opml`](collection.opml) and import it into your podcast app:

- **Apple Podcasts**: File > Import
- **Overcast**: Settings > Import/Export > Import OPML
- **Pocket Casts**: Settings > Import/Export > Import from OPML file

### Browse Individual Feeds

The [`collection.json`](collection.json) file contains direct links to each podcast's RSS feed. You can subscribe to individual podcasts via their feed URLs.

### Validate the Collection

```bash
# Install a JSON Schema validator like ajv-cli
npm install -g ajv-cli

# Validate the collection against the schema
ajv validate -s schema.json -d collection.json
```

## Podcast Details

### Daily Dao - Tao De Jing Podcast

**81 episodes** | **Philosophy** | **Completed**

A contemplative journey through the 81 chapters of the Tao De Jing, the ancient Chinese philosophical text attributed to Laozi.

- **Feed**: [RSS](https://intrusive-memory.productions/daily-dao/feed.xml)
- **Website**: [intrusive-memory.productions/daily-dao](https://intrusive-memory.productions/daily-dao/)
- **Language**: English (British)
- **Tags**: taoism, philosophy, meditation, chinese-philosophy, wisdom, spirituality

### Meditations

**365 episodes** | **Philosophy** | **Active**

Daily readings from Marcus Aurelius' Meditations, the personal writings of the Roman Emperor and Stoic philosopher.

- **Feed**: [RSS](https://intrusive-memory.productions/meditations/feed.xml)
- **Website**: [intrusive-memory.productions/meditations](https://intrusive-memory.productions/meditations/)
- **Language**: English (US)
- **Tags**: stoicism, philosophy, meditation, self-improvement, ancient-wisdom

### The Life of Lazarillo de Tormes

**7 episodes** | **Literature/Fiction** | **Active**

A modern English translation of the anonymous 16th-century Spanish picaresque novel following a young boy's journey through Renaissance Spain.

- **Feed**: [RSS](https://intrusive-memory.productions/lazarillo/feed.xml)
- **Website**: [intrusive-memory.productions/lazarillo](https://intrusive-memory.productions/lazarillo/)
- **Tags**: picaresque, spanish-literature, renaissance, translation, classic-literature, satire

### You're Nobody til Somebody Wants You Dead

**9 episodes** | **Fiction** | **Active**

A noir-style fiction podcast exploring themes of identity, mortality, and what it means to be truly seen.

- **Feed**: [RSS](https://intrusive-memory.productions/yntswyd/feed.xml)
- **Website**: [intrusive-memory.productions/yntswyd](https://intrusive-memory.productions/yntswyd/)
- **Tags**: fiction, noir, drama, original-fiction

### Podcast Therapist GPT Episodes

**2 episodes** | **Education** | **Active**

Therapeutic insights and advice through AI-generated conversations exploring mental health and personal growth.

- **Feed**: [RSS](https://intrusive-memory.productions/therapist-gpt/feed.xml)
- **Website**: [intrusive-memory.productions/therapist-gpt](https://intrusive-memory.productions/therapist-gpt/)
- **Tags**: therapy, mental-health, ai, education

### Podcast Mr Mr Charles

**10 episodes** | **Comedy** | **Active**

A comedy podcast series featuring original characters and humorous storytelling.

- **Feed**: [RSS](https://intrusive-memory.productions/mr-mr-charles/feed.xml)
- **Website**: [intrusive-memory.productions/mr-mr-charles](https://intrusive-memory.productions/mr-mr-charles/)
- **Tags**: comedy, humor

### Casting Software Spells

**12 episodes** | **Technology/Education** | **Active**

Exploring software development as modern magic through agentic incantation and AI-powered automation.

- **Feed**: [RSS](https://intrusive-memory.productions/casting-software-spells/feed.xml)
- **Website**: [intrusive-memory.productions/casting-software-spells](https://intrusive-memory.productions/casting-software-spells/)
- **Language**: English (US)
- **Tags**: software-development, programming, technology, education, automation, ai, devtools, agentic-ai

## Collection Format

This collection uses a JSON format inspired by Swift Package Collections but adapted for podcasts:

```json
{
  "$schema": "https://raw.githubusercontent.com/intrusive-memory/podcast-collection/main/schema.json",
  "name": "Intrusive Memory Podcasts",
  "formatVersion": "1.0",
  "podcasts": [
    {
      "name": "Daily Dao - Tao De Jing Podcast",
      "published": false,
      "feedURL": "https://intrusive-memory.productions/daily-dao/feed.xml",
      "websiteURL": "https://intrusive-memory.productions/daily-dao/",
      "summary": "...",
      "genre": "Philosophy",
      "keywords": ["taoism", "philosophy", "meditation"],
      "episodeCount": 81,
      "status": "completed"
    }
  ]
}
```

### Published Status

The `published` boolean field indicates whether a podcast is ready for public consumption:

- `"published": false` - Podcast is in development, incomplete, or not yet ready for distribution
- `"published": true` - Podcast is complete and publicly available

This allows the collection to:
- Maintain a complete list of all podcasts (including works-in-progress)
- Filter out unpublished podcasts for public-facing displays
- Track production status without checking individual podcast directories

**Note**: All podcasts in this collection are currently marked as unpublished (`"published": false`) as they are in active development.

### Schema Validation

The collection is validated against [`schema.json`](schema.json), which defines:

- Required fields (name, feedURL)
- Optional metadata (genre, keywords, status, seasons)
- Data types and formats
- Enum values for constrained fields

This ensures collections are consistent and machine-readable.

## Generating OPML

To generate an OPML file from the collection:

```bash
./generate-opml.sh collection.json > collection.opml
```

The OPML format is compatible with all major podcast apps for easy batch subscription.

## Contributing

To add a podcast to this collection:

1. Ensure the podcast has a valid RSS feed
2. Add an entry to `collection.json` with complete metadata
3. Validate with `ajv validate -s schema.json -d collection.json`
4. Submit a pull request

## About Intrusive Memory

Intrusive Memory produces podcasts that transform classic literature, philosophy, and original fiction into audio experiences. All podcasts are generated using the [Produciesta](https://github.com/intrusive-memory/Produciesta) toolkit for screenplay-to-audio conversion.

## License

This collection file is released under the MIT License. Individual podcasts retain their own licensing.
