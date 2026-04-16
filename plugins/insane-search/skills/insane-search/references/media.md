# Media with yt-dlp

For video, audio, and podcast pages, try `yt-dlp --dump-json` before scraping HTML.

## Check install

### PowerShell

```powershell
yt-dlp --version
```

If that fails:

```powershell
python -m pip install yt-dlp
```

## Metadata only

```powershell
yt-dlp --dump-json "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
```

## Search helpers

```powershell
yt-dlp --dump-json "ytsearch5:openai codex"
yt-dlp --dump-json "scsearch5:ambient coding music"
```

## Subtitle extraction

```powershell
yt-dlp --write-sub --write-auto-sub --sub-lang "en,ko" --skip-download -o "%(id)s" "URL"
```

## Notes

- prefer metadata-only commands when the boss did not ask for media download
- do not assume `/tmp` exists on Windows
