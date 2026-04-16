# Public Endpoints

## X / Twitter

Use the syndication timeline for profile reads and oEmbed for known tweet URLs.

See [twitter.md](twitter.md).

## Hacker News

Use the official Firebase API.

```powershell
Invoke-WebRequest -UseBasicParsing "https://hacker-news.firebaseio.com/v0/topstories.json" |
  Select-Object -ExpandProperty Content
```

Important:

- `topstories.json` returns IDs
- fetch items separately with `/v0/item/{id}.json`
- do not document fake support that the official API does not promise

Reference: [Hacker News API](https://github.com/HackerNews/API)

## Bluesky

```powershell
Invoke-WebRequest -UseBasicParsing "https://public.api.bsky.app/xrpc/app.bsky.actor.getProfile?actor=alice.bsky.social" |
  Select-Object -ExpandProperty Content
```

## Mastodon

Each instance is its own public API surface. Prefer official REST endpoints on the target instance.

## Stack Exchange

Use the Stack Exchange API for Stack Overflow and sibling sites instead of scraping question pages first.

## arXiv

Use the Atom API for search and recent-paper workflows.
