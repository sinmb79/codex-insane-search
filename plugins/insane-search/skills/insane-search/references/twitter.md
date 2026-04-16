# X / Twitter

## Profile timeline

For a public profile timeline:

```powershell
$html = Invoke-WebRequest -UseBasicParsing "https://syndication.twitter.com/srv/timeline-profile/screen-name/openai"
$html.Content
```

The response is HTML with `__NEXT_DATA__`.

## Extraction pattern

- fetch the syndication page
- parse `__NEXT_DATA__`
- read `props.pageProps.timeline.entries`

## Known limits

- public profiles only
- unofficial endpoint
- no guarantee of long-term stability

## Known tweet URL

For a known tweet:

```powershell
Invoke-WebRequest -UseBasicParsing "https://publish.twitter.com/oembed?url=https://x.com/openai/status/123" |
  Select-Object -ExpandProperty Content
```

Use this for embed-ready HTML and basic metadata.
