[CmdletBinding()]
param(
    [switch]$Force
)

$ErrorActionPreference = "Stop"

function Write-Step {
    param([string]$Message)
    Write-Host "[install] $Message"
}

$repoRoot = Split-Path -Parent $PSScriptRoot
$sourcePlugin = Join-Path $repoRoot "plugins\\insane-search"
$homeRoot = [Environment]::GetFolderPath("UserProfile")
$targetPlugin = Join-Path $homeRoot "plugins\\insane-search"
$marketplacePath = Join-Path $homeRoot ".agents\\plugins\\marketplace.json"

if (-not (Test-Path $sourcePlugin)) {
    throw "Source plugin not found: $sourcePlugin"
}

New-Item -ItemType Directory -Force -Path (Split-Path -Parent $targetPlugin) | Out-Null
New-Item -ItemType Directory -Force -Path (Split-Path -Parent $marketplacePath) | Out-Null

if (Test-Path $targetPlugin) {
    $existing = Get-Item $targetPlugin -Force
    if ($existing.Attributes -band [IO.FileAttributes]::ReparsePoint) {
        [System.IO.Directory]::Delete($targetPlugin)
    } elseif ($Force) {
        Remove-Item $targetPlugin -Recurse -Force
    } else {
        throw "Target plugin path already exists: $targetPlugin. Re-run with -Force to replace it."
    }
}

Write-Step "Creating local junction"
New-Item -ItemType Junction -Path $targetPlugin -Target $sourcePlugin | Out-Null

function ConvertTo-PluginArray {
    param([object[]]$Plugins)
    $result = @()
    foreach ($plugin in $Plugins) {
        $result += @{
            name = $plugin.name
            source = @{
                source = $plugin.source.source
                path = $plugin.source.path
            }
            policy = @{
                installation = $plugin.policy.installation
                authentication = $plugin.policy.authentication
            }
            category = $plugin.category
        }
    }
    return $result
}

$marketplace = @{
    name = "local-marketplace"
    interface = @{
        displayName = "Local Plugins"
    }
    plugins = @()
}

if (Test-Path $marketplacePath) {
    $rawMarketplace = Get-Content $marketplacePath -Raw | ConvertFrom-Json
    $marketplace = @{
        name = $rawMarketplace.name
        interface = @{
            displayName = $rawMarketplace.interface.displayName
        }
        plugins = @()
    }
    if ($rawMarketplace.plugins) {
        $marketplace.plugins = ConvertTo-PluginArray -Plugins $rawMarketplace.plugins
    }
}

$entry = @{
    name = "insane-search"
    source = @{
        source = "local"
        path = "./plugins/insane-search"
    }
    policy = @{
        installation = "AVAILABLE"
        authentication = "ON_INSTALL"
    }
    category = "Coding"
}

$filtered = @()
foreach ($plugin in $marketplace.plugins) {
    if ($plugin.name -ne "insane-search") {
        $filtered += $plugin
    }
}
$filtered += $entry
$marketplace.plugins = $filtered

Write-Step "Updating home marketplace manifest"
$marketplace | ConvertTo-Json -Depth 8 | Set-Content -Path $marketplacePath -Encoding utf8

Write-Step "Installed insane-search for local Codex use"
Write-Host "Plugin path: $targetPlugin"
Write-Host "Marketplace: $marketplacePath"
