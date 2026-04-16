[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

function Assert-Path {
    param([string]$Path)
    if (-not (Test-Path $Path)) {
        throw "Missing required path: $Path"
    }
}

$repoRoot = Split-Path -Parent $PSScriptRoot

$requiredPaths = @(
    (Join-Path $repoRoot "README.md"),
    (Join-Path $repoRoot "README.ko.md"),
    (Join-Path $repoRoot ".agents\\plugins\\marketplace.json"),
    (Join-Path $repoRoot "plugins\\insane-search\\.codex-plugin\\plugin.json"),
    (Join-Path $repoRoot "plugins\\insane-search\\skills\\insane-search\\SKILL.md"),
    (Join-Path $repoRoot "plugins\\insane-search\\skills\\insane-search\\references\\search-chain.md"),
    (Join-Path $repoRoot "scripts\\install-local.ps1"),
    (Join-Path $repoRoot "scripts\\uninstall-local.ps1")
)

foreach ($path in $requiredPaths) {
    Assert-Path $path
}

$pluginManifest = Get-Content (Join-Path $repoRoot "plugins\\insane-search\\.codex-plugin\\plugin.json") -Raw | ConvertFrom-Json
$marketplace = Get-Content (Join-Path $repoRoot ".agents\\plugins\\marketplace.json") -Raw | ConvertFrom-Json

if ($pluginManifest.name -ne "insane-search") {
    throw "Plugin manifest name mismatch."
}

if (-not $marketplace.plugins) {
    throw "Marketplace manifest has no plugins array."
}

if (-not ($marketplace.plugins | Where-Object { $_.name -eq "insane-search" })) {
    throw "Marketplace manifest is missing the insane-search entry."
}

Write-Host "[validate] manifests and required files look good"
