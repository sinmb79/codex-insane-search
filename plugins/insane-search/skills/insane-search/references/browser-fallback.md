# Browser Fallback

Use Playwright only after cheaper routes fail.

## Typical flow

1. `browser_navigate`
2. `browser_wait_for`
3. `browser_snapshot` or `browser_evaluate`
4. optionally `browser_network_requests`

## Best uses

- JS-rendered pages
- empty HTML shells
- sites where metadata exists but body content needs runtime rendering

## Data-first rule

If the browser reveals an internal public JSON endpoint, prefer that endpoint for follow-up requests instead of scraping the rendered DOM repeatedly.

## Warning

Browser fallback is heavier and slower than `web.open` or public APIs. Use it intentionally.
