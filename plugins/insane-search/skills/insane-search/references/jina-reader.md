# Jina Reader

Jina Reader is a strong lightweight fallback for public pages.

## Rate limits

Be precise:

- without API key: **20 RPM**
- with free API key: **500 RPM**

Reference: [Jina Reader docs](https://jina.ai/ko/reader/)

## Basic usage

### PowerShell

```powershell
Invoke-WebRequest -UseBasicParsing "https://r.jina.ai/http://example.com" |
  Select-Object -ExpandProperty Content
```

### curl

```bash
curl -s "https://r.jina.ai/http://example.com"
```

## Use it for

- Medium or Substack summaries
- public blog posts
- article extraction where raw HTML is noisy
- fast markdown conversion before browser escalation

## Notes

- Jina is not a magic bypass for authentication.
- If rate limits matter, document whether you used it with or without a key.
