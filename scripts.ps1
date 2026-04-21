#===============================================================================
# Installed Apps Scanner - Show installed apps with current & latest versions
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

# List of apps to check
$AppsList = @(
    @{Name="Google Chrome"; Id="Google.Chrome"}
    @{Name="Mozilla Firefox"; Id="Mozilla.Firefox"}
    @{Name="Brave Browser"; Id="Brave.Brave"}
    @{Name="Microsoft Edge"; Id="Microsoft.Edge"}
    @{Name="Visual Studio Code"; Id="Microsoft.VisualStudioCode"}
    @{Name="7-Zip"; Id="7zip.7zip"}
    @{Name="VLC Media Player"; Id="VideoLAN.VLC"}
    @{Name="Discord"; Id="Discord.Discord"}
    @{Name="Spotify"; Id="Spotify.Spotify"}
    @{Name="Telegram"; Id="Telegram.TelegramDesktop"}
    @{Name="Zoom"; Id="Zoom.Zoom"}
    @{Name="Slack"; Id="Slack.Slack"}
    @{Name="Git"; Id="Git.Git"}
    @{Name="Node.js"; Id="OpenJS.NodeJS"}
    @{Name="Python"; Id="Python.Python.3"}
    @{Name="Notepad++"; Id="Notepad++.Notepad++"}
    @{Name="GIMP"; Id="GIMP.GIMP"}
    @{Name="Steam"; Id="Valve.Steam"}
    @{Name="Epic Games"; Id="EpicGames.EpicGamesLauncher"}
    @{Name="OBS Studio"; Id="OBSProject.OBSStudio"}
    @{Name="Blender"; Id="BlenderFoundation.Blender"}
    @{Name="Adobe Reader"; Id="Adobe.Acrobat.Reader.64-bit"}
    @{Name="WinRAR"; Id="WinRAR.WinRAR"}
    @{Name="qBittorrent"; Id="qBittorrent.qBittorrent"}
    @{Name="FileZilla"; Id="FileZilla.Client.FTP"}
    @{Name="TeamViewer"; Id="TeamViewer.TeamViewer"}
    @{Name="Putty"; Id="PuTTY.PuTTY"}
    @{Name="Wireshark"; Id="WiresharkFoundation.Wireshark"}
    @{Name="VirtualBox"; Id="Oracle.VirtualBox"}
    @{Name="Docker Desktop"; Id="Docker.DockerDesktop"}
)

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
                Name = $app.Name
                CurrentVersion = $installed
                LatestVersion = $latest
            }
        }
    }
    
    Write-Progress -Activity "Scanning..." -Completed
    
    # Display results
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Installed Applications Report" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Found $($results.Count) installed applications" -ForegroundColor Green
    Write-Host ""
    Write-Host "================================================================================================" -ForegroundColor DarkGray
    Write-Host " Application Name                          Current Version           Latest Version" -ForegroundColor Yellow
    Write-Host "================================================================================================" -ForegroundColor DarkGray
    
    foreach ($app in ($results | Sort-Object Name)) {
        Write-Host " $($app.Name.PadRight(40))" -NoNewline -ForegroundColor White
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
    
    # Summary
    $updatesCount = 0
    foreach ($app in $results) {
        if ($app.CurrentVersion -ne $app.LatestVersion -and $app.LatestVersion -ne "Unknown") {
            $updatesCount++
        }
    }
    
    if ($updatesCount -gt 0) {
        Write-Host "Updates available: $updatesCount applications" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Apps with available updates:" -ForegroundColor Yellow
        foreach ($app in ($results | Where-Object { $_.CurrentVersion -ne $_.LatestVersion -and $_.LatestVersion -ne "Unknown" })) {
            Write-Host "  - $($app.Name): $($app.CurrentVersion) -> $($app.LatestVersion)" -ForegroundColor White
        }
    } else {
        Write-Host "All installed applications are up to date!" -ForegroundColor Green
    }
    
    Write-Host ""
    return $results
}

# Main menu
do {
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Installed Apps Scanner" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "   [1] Scan and show installed apps with versions" -ForegroundColor Green
    Write-Host "   [2] Exit" -ForegroundColor Red
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                         Developed by: KARIM ABU RIDA" -ForegroundColor Yellow
    Write-Host "================================================================================" -ForegroundColor Cyan
    
    $choice = Read-Host "`nEnter your choice (1-2)"
    
    switch ($choice) {
        "1" {
            $results = Scan-InstalledApps
            Read-Host "Press Enter to continue"
        }
        "2" {
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
} while ($choice -ne "2")
