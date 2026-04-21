#===============================================================================
# Installed Apps Scanner + Direct Installer
# Created by: KARIM ABU RIDA
# GitHub: MARKETTV1
#===============================================================================

Clear-Host

function Show-Signature {
    Write-Host "                                                                  " -ForegroundColor DarkGray
    Write-Host "   ██╗  ██╗ █████╗ ██████╗ ██╗███╗   ███╗    █████╗ ██████╗ ██╗   ██╗    ██████╗ ██╗██████╗  █████╗ " -ForegroundColor Cyan
    Write-Host "   ██║ ██╔╝██╔══██╗██╔══██╗██║████╗ ████║    ██╔══██╗██╔══██╗██║   ██║    ██╔══██╗██║██╔══██╗██╔══██╗" -ForegroundColor Cyan
    Write-Host "   █████╔╝ ███████║██████╔╝██║██╔████╔██║    ██████╔╝██║  ██║██║   ██║    ██████╔╝██║██║  ██║███████║" -ForegroundColor Cyan
    Write-Host "   ██╔═██╗ ██╔══██║██╔══██╗██║██║╚██╔╝██║    ██╔══██╗██║  ██║██║   ██║    ██╔══██╗██║██║  ██║██╔══██║" -ForegroundColor Cyan
    Write-Host "   ██║  ██╗██║  ██║██║  ██║██║██║ ╚═╝ ██║    ██║  ██║██████╔╝╚██████╔╝    ██║  ██║██║██████╔╝██║  ██║" -ForegroundColor Cyan
    Write-Host "   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝     ╚═╝    ╚═╝  ╚═╝╚═════╝  ╚═════╝     ╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝" -ForegroundColor Cyan
    Write-Host "                                                                  " -ForegroundColor DarkGray
    Write-Host "                              Created by: KARIM ABU RIDA           " -ForegroundColor Yellow
    Write-Host "                              GitHub: MARKETTV1                    " -ForegroundColor Yellow
    Write-Host "                                                                  " -ForegroundColor DarkGray
}

# List of apps
$AppsList = @(
    @{Num=1; Name="Google Chrome"; Id="Google.Chrome"}
    @{Num=2; Name="Mozilla Firefox"; Id="Mozilla.Firefox"}
    @{Num=3; Name="Brave Browser"; Id="Brave.Brave"}
    @{Num=4; Name="Microsoft Edge"; Id="Microsoft.Edge"}
    @{Num=5; Name="Visual Studio Code"; Id="Microsoft.VisualStudioCode"}
    @{Num=6; Name="7-Zip"; Id="7zip.7zip"}
    @{Num=7; Name="VLC Media Player"; Id="VideoLAN.VLC"}
    @{Num=8; Name="Discord"; Id="Discord.Discord"}
    @{Num=9; Name="Spotify"; Id="Spotify.Spotify"}
    @{Num=10; Name="Telegram"; Id="Telegram.TelegramDesktop"}
    @{Num=11; Name="Zoom"; Id="Zoom.Zoom"}
    @{Num=12; Name="Slack"; Id="Slack.Slack"}
    @{Num=13; Name="Git"; Id="Git.Git"}
    @{Num=14; Name="Node.js"; Id="OpenJS.NodeJS"}
    @{Num=15; Name="Python"; Id="Python.Python.3"}
    @{Num=16; Name="Notepad++"; Id="Notepad++.Notepad++"}
    @{Num=17; Name="GIMP"; Id="GIMP.GIMP"}
    @{Num=18; Name="Steam"; Id="Valve.Steam"}
    @{Num=19; Name="Epic Games"; Id="EpicGames.EpicGamesLauncher"}
    @{Num=20; Name="OBS Studio"; Id="OBSProject.OBSStudio"}
    @{Num=21; Name="Blender"; Id="BlenderFoundation.Blender"}
    @{Num=22; Name="Adobe Reader"; Id="Adobe.Acrobat.Reader.64-bit"}
    @{Num=23; Name="WinRAR"; Id="WinRAR.WinRAR"}
    @{Num=24; Name="qBittorrent"; Id="qBittorrent.qBittorrent"}
    @{Num=25; Name="FileZilla"; Id="FileZilla.Client.FTP"}
)

function Show-AllApps {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Available Applications" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  No.  Application Name" -ForegroundColor Yellow
    Write-Host "  ---  ----------------------------------------" -ForegroundColor DarkGray
    
    foreach ($app in $AppsList) {
        Write-Host "  $($app.Num)    $($app.Name)" -ForegroundColor White
    }
    
    Write-Host ""
    Write-Host "  [0] Back to main menu" -ForegroundColor Gray
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
}

function Get-InstalledVersion {
    param($Id)
    try {
        $result = winget list --id $Id --accept-source-agreements 2>$null
        if ($result -match "$Id\s+(\S+)") {
            return $matches[1]
        }
    } catch {}
    return $null
}

function Get-LatestVersion {
    param($Id)
    try {
        $result = winget show $Id --accept-source-agreements 2>$null
        if ($result -match "Version:\s*(\S+)") {
            return $matches[1]
        }
    } catch {}
    return "Unknown"
}

function Scan-InstalledApps {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Scanning Installed Applications" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Please wait... (checking installed apps)" -ForegroundColor Yellow
    Write-Host ""
    
    $results = @()
    $total = $AppsList.Count
    $current = 0
    
    foreach ($app in $AppsList) {
        $current++
        Write-Progress -Activity "Scanning..." -Status $app.Name -PercentComplete (($current / $total) * 100)
        
        $installed = Get-InstalledVersion -Id $app.Id
        
        if ($installed) {
            $latest = Get-LatestVersion -Id $app.Id
            $results += [PSCustomObject]@{
                Num = $app.Num
                Name = $app.Name
                CurrentVersion = $installed
                LatestVersion = $latest
            }
        }
    }
    
    Write-Progress -Activity "Scanning..." -Completed
    
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Installed Applications Report" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Found $($results.Count) installed applications" -ForegroundColor Green
    Write-Host ""
    Write-Host "================================================================================================" -ForegroundColor DarkGray
    Write-Host " No. Application Name                          Current Version           Latest Version" -ForegroundColor Yellow
    Write-Host "================================================================================================" -ForegroundColor DarkGray
    
    foreach ($app in ($results | Sort-Object Name)) {
        Write-Host " $($app.Num). " -NoNewline -ForegroundColor Cyan
        Write-Host "$($app.Name.PadRight(40))" -NoNewline -ForegroundColor White
        Write-Host " $($app.CurrentVersion.PadRight(25))" -NoNewline -ForegroundColor Cyan
        
        if ($app.CurrentVersion -eq $app.LatestVersion) {
            Write-Host " $($app.LatestVersion)" -ForegroundColor Green
        } elseif ($app.LatestVersion -eq "Unknown") {
            Write-Host " $($app.LatestVersion)" -ForegroundColor Gray
        } else {
            Write-Host " $($app.LatestVersion)" -ForegroundColor Yellow
        }
    }
    
    Write-Host "================================================================================================" -ForegroundColor DarkGray
    Write-Host ""
    
    $updatesCount = 0
    foreach ($app in $results) {
        if ($app.CurrentVersion -ne $app.LatestVersion -and $app.LatestVersion -ne "Unknown") {
            $updatesCount++
        }
    }
    
    if ($updatesCount -gt 0) {
        Write-Host "Updates available: $updatesCount applications" -ForegroundColor Yellow
    } else {
        Write-Host "All installed applications are up to date!" -ForegroundColor Green
    }
    
    Write-Host ""
    Write-Host "  [0] Back to main menu" -ForegroundColor Gray
    Write-Host ""
    
    return $results
}

function Install-ByNumbers {
    param($Numbers)
    
    $selected = @()
    foreach ($num in $Numbers) {
        $app = $AppsList | Where-Object { $_.Num -eq $num }
        if ($app) { $selected += $app }
    }
    
    if ($selected.Count -eq 0) {
        Write-Host "No valid applications selected!" -ForegroundColor Red
        return $false
    }
    
    Write-Host ""
    Write-Host "Selected applications:" -ForegroundColor Green
    foreach ($app in $selected) {
        Write-Host "  - $($app.Name)" -ForegroundColor White
    }
    
    Write-Host ""
    $confirm = Read-Host "Proceed with installation? (y/n)"
    if ($confirm -ne "y") {
        Write-Host "Installation cancelled." -ForegroundColor Red
        return $false
    }
    
    Write-Host ""
    Write-Host "Starting installation..." -ForegroundColor Yellow
    Write-Host ""
    
    foreach ($app in $selected) {
        Write-Host ">>> Installing $($app.Name)..." -ForegroundColor Cyan
        winget install $app.Id --accept-package-agreements --accept-source-agreements --silent
        
        if ($LASTEXITCODE -eq 0 -or $LASTEXITCODE -eq 1 -or $LASTEXITCODE -eq -1978335189) {
            Write-Host "[✓] $($app.Name) installed successfully!" -ForegroundColor Green
        } else {
            Write-Host "[✗] Failed to install $($app.Name)" -ForegroundColor Red
        }
        Write-Host ""
    }
    
    return $true
}

# Main menu
do {
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Installed Apps Scanner + Installer" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "   [1] Show all available apps (with numbers)" -ForegroundColor Green
    Write-Host "   [2] Scan and show installed apps with versions" -ForegroundColor Cyan
    Write-Host "   [3] Install apps directly (by numbers, no scan)" -ForegroundColor Magenta
    Write-Host "   [4] Exit" -ForegroundColor Red
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                         Developed by: KARIM ABU RIDA" -ForegroundColor Yellow
    Write-Host "================================================================================" -ForegroundColor Cyan
    
    $choice = Read-Host "`nEnter your choice (1-4)"
    
    switch ($choice) {
        "1" {
            Show-AllApps
            $back = Read-Host "`nEnter 0 to go back"
            if ($back -eq "0") { continue }
        }
        "2" {
            Scan-InstalledApps
            $back = Read-Host "Enter 0 to go back"
            if ($back -eq "0") { continue }
        }
        "3" {
            Show-AllApps
            Write-Host ""
            Write-Host "Examples: 1,2,3  or  1 2 3  or  1,2,3,9,15" -ForegroundColor Gray
            Write-Host "  [0] Back to main menu" -ForegroundColor Gray
            Write-Host ""
            $input = Read-Host "Enter numbers (spaces or commas)"
            
            if ($input -eq "0") { continue }
            
            $input = $input -replace " ", ","
            $numbers = @()
            foreach ($n in ($input -split ",")) {
                $num = $n.Trim()
                if ($num -match "^\d+$") {
                    $numbers += [int]$num
                }
            }
            
            if ($numbers.Count -gt 0) {
                Install-ByNumbers -Numbers $numbers
            } else {
                Write-Host "No valid numbers entered!" -ForegroundColor Red
            }
            Read-Host "`nPress Enter to continue"
        }
        "4" {
            Clear-Host
            Show-Signature
            Write-Host ""
            Write-Host "Exiting... Goodbye!" -ForegroundColor Green
            Write-Host ""
            Start-Sleep -Seconds 2
            break
        }
        default {
            Write-Host "Invalid choice!" -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    }
} while ($choice -ne "4")
