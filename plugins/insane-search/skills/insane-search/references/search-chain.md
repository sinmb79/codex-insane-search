# Search Chain

## Phase model

Use one consistent phase model everywhere:

| Phase | Goal | Default tools |
|---|---|---|
| 0 | known public endpoint | `web`, `shell_command` |
| 1 | cheap generic fetch | `web.open`, Jina Reader, metadata |
| 2 | alternate routes | RSS, JSON variants, archives, public APIs |
| 3 | browser fallback | Playwright |

## Escalation signals

Escalate when one of these happens:

- HTTP 403, 429, 430, or 503
- challenge page text such as `verify`, `captcha`, `enable javascript`
- body is almost empty on a known JS-heavy site
- direct HTML is weak but metadata suggests real content exists

## Success criteria

Treat a fetch as useful when at least one is true:

- the main article or post body is present
- structured metadata contains the key fields the boss asked for
- a trusted public endpoint returned the requested data directly

## Stop criteria

Stop and report instead of escalating forever when:

- login is required
- the content is clearly private
- only stale archive material exists and freshness matters
