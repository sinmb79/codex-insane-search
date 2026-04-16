[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

function Write-Step {
    param([string]$Message)
    Write-Host "[uninstall] $Message"
}

$homeRoot = [Environment]::GetFolderPath("UserProfile")
$targetPlugin = Join-Path $homeRoot "plugins\\insane-search"
$marketplacePath = Join-Path $homeRoot ".agents\\plugins\\marketplace.json"

if (Test-Path $targetPlugin) {
    Write-Step "Removing local plugin junction"
    $existing = Get-Item $targetPlugin -Force
    if ($existing.Attributes -band [IO.FileAttributes]::ReparsePoint) {
        [System.IO.Directory]::Delete($targetPlugin)
    } else {
        Remove-Item $targetPlugin -Recurse -Force
    }
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
        $filtered = @()
        foreach ($plugin in $rawMarketplace.plugins) {
            if ($plugin.name -ne "insane-search") {
                $filtered += @{
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
        }
        $marketplace.plugins = $filtered
        Write-Step "Updating home marketplace manifest"
        $marketplace | ConvertTo-Json -Depth 8 | Set-Content -Path $marketplacePath -Encoding utf8
    }
}

Write-Step "Removed insane-search from local Codex setup"
