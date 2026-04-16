# Korea-Specific Notes

## Naver Finance

For price data and chart-style historical data, prefer the unofficial JSON endpoint over scraping the main page.

Examples:

```powershell
Invoke-WebRequest -UseBasicParsing "https://api.finance.naver.com/siseJson.naver?symbol=005930&requestType=0&timeframe=minute&count=200" |
  Select-Object -ExpandProperty Content
```

## Naver blogs and news

Try lightweight page access first, then Jina Reader, then browser fallback only if the page is runtime-heavy.
