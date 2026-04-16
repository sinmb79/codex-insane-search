---
name: insane-search
description: Use when a normal fetch or search path fails, when a page is JS-heavy, or when a known platform has a better public endpoint than generic scraping.
---

# Insane Search for Codex

Use this skill when the boss asks for content from a site that is blocked, JS-heavy, bot-protected, or better served by a known public endpoint.

## Core rule

Do not jump to the browser first.

Work in this order:

1. **Phase 0: known public endpoints**
2. **Phase 1: lightweight fetches**
3. **Phase 2: alternate routes and public fallbacks**
4. **Phase 3: real browser automation**

If login or paywall is clearly required, stop and say so.

## Codex tool mapping

| Need | Preferred tool |
|---|---|
| Fresh discovery | `web.search_query` |
| Read a specific page | `web.open` |
| Quick public HTTP call | `functions.shell_command` with PowerShell |
| Browser rendering or interaction | Playwright tools |
| Media metadata | `functions.shell_command` with `yt-dlp` |

## Phase 0: known public endpoints

Use a platform endpoint first if it is cleaner than scraping.

- X/Twitter profile timeline: see [twitter.md](references/twitter.md)
- Hacker News: see [public-endpoints.md](references/public-endpoints.md)
- Bluesky, Mastodon, Stack Exchange, arXiv: see [public-endpoints.md](references/public-endpoints.md)
- Naver Finance: see [korea-sites.md](references/korea-sites.md)

## Phase 1: lightweight fetches

Start cheap.

- open the page directly
- try Jina Reader
- inspect OGP and JSON-LD if the page is partial but not empty

Reference: [search-chain.md](references/search-chain.md), [jina-reader.md](references/jina-reader.md), [metadata.md](references/metadata.md)

## Phase 2: alternate routes and public fallbacks

If the direct page is weak or blocked:

- try mobile URLs
- try `.json`, `/rss`, or `/feed` variants
- try an archive or AMP cache only as a low-trust backup
- use platform-specific public APIs where available

Reference: [search-chain.md](references/search-chain.md), [cache-archive.md](references/cache-archive.md), [public-endpoints.md](references/public-endpoints.md)

## Phase 3: browser fallback

Use the real browser when:

- the site is JS-rendered
- the page body is nearly empty
- the site is bot-protected but still publicly readable

Reference: [browser-fallback.md](references/browser-fallback.md)

## Media

For YouTube, Vimeo, SoundCloud, and other supported media platforms, prefer `yt-dlp --dump-json` over page scraping.

Reference: [media.md](references/media.md)

## Failure policy

- If the site is blocked but a public fallback exists, say which fallback you used.
- If only archive content is available, label it clearly as archive-derived.
- If authentication is required, say `authentication required`.
- Do not invent access that you do not have.
