# install.ps1 - Script to download and setup Winget Manager
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "     Installing Winget Manager" -ForegroundColor White
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$installPath = "$env:USERPROFILE\Documents\WindowsPowerShell\Scripts"

# Create directory if not exists
if (!(Test-Path $installPath)) {
    New-Item -ItemType Directory -Path $installPath -Force | Out-Null
}

# Download the script
$scriptUrl = "https://raw.githubusercontent.com/اسم-المستخدم/winget-tools/main/winget-manager.ps1"
$scriptPath = "$installPath\winget-manager.ps1"

Write-Host "Downloading Winget Manager..." -ForegroundColor Yellow
Invoke-WebRequest -Uri $scriptUrl -OutFile $scriptPath

# Create alias function in PowerShell profile
$profilePath = $PROFILE.CurrentUserAllHosts
if (!(Test-Path $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force | Out-Null
}

$aliasFunction = @"
# Winget Manager Alias
function winget-manager {
    & "$scriptPath"
}
Set-Alias -Name wm -Value winget-manager
"@

# Add to profile if not already there
$profileContent = Get-Content $profilePath -ErrorAction SilentlyContinue
if ($profileContent -notmatch "winget-manager") {
    Add-Content -Path $profilePath -Value "`r`n$aliasFunction"
}

Write-Host ""
Write-Host "Installation completed!" -ForegroundColor Green
Write-Host ""
Write-Host "You can now use:" -ForegroundColor White
Write-Host "  - Type 'wm' or 'winget-manager' in PowerShell" -ForegroundColor Cyan
Write-Host ""
Write-Host "Please restart PowerShell to apply changes." -ForegroundColor Yellow
Read-Host "Press Enter to exit"
