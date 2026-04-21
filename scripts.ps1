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

# List of apps (winget IDs + custom apps)
$AppsList = @(
    @{Num=1; Name="Google Chrome"; Id="Google.Chrome"; Type="winget"}
    @{Num=2; Name="Mozilla Firefox"; Id="Mozilla.Firefox"; Type="winget"}
    @{Num=3; Name="Brave Browser"; Id="Brave.Brave"; Type="winget"}
    @{Num=4; Name="Microsoft Edge"; Id="Microsoft.Edge"; Type="winget"}
    @{Num=5; Name="Visual Studio Code"; Id="Microsoft.VisualStudioCode"; Type="winget"}
    @{Num=6; Name="7-Zip"; Id="7zip.7zip"; Type="winget"}
    @{Num=7; Name="VLC Media Player"; Id="VideoLAN.VLC"; Type="winget"}
    @{Num=8; Name="Discord"; Id="Discord.Discord"; Type="winget"}
    @{Num=9; Name="Spotify"; Id="Spotify.Spotify"; Type="winget"}
    @{Num=10; Name="Telegram"; Id="Telegram.TelegramDesktop"; Type="winget"}
    @{Num=11; Name="Zoom"; Id="Zoom.Zoom"; Type="winget"}
    @{Num=12; Name="Slack"; Id="Slack.Slack"; Type="winget"}
    @{Num=13; Name="Git"; Id="Git.Git"; Type="winget"}
    @{Num=14; Name="Node.js"; Id="OpenJS.NodeJS"; Type="winget"}
    @{Num=15; Name="Python"; Id="Python.Python.3"; Type="winget"}
    @{Num=16; Name="Notepad++"; Id="Notepad++.Notepad++"; Type="winget"}
    @{Num=17; Name="GIMP"; Id="GIMP.GIMP"; Type="winget"}
    @{Num=18; Name="Steam"; Id="Valve.Steam"; Type="winget"}
    @{Num=19; Name="Epic Games Launcher"; Id="EpicGames.EpicGamesLauncher"; Type="winget"}
    @{Num=20; Name="OBS Studio"; Id="OBSProject.OBSStudio"; Type="winget"}
    @{Num=21; Name="Blender"; Id="BlenderFoundation.Blender"; Type="winget"}
    @{Num=22; Name="Adobe Acrobat Reader"; Id="Adobe.Acrobat.Reader.64-bit"; Type="winget"}
    @{Num=23; Name="WinRAR"; Id="WinRAR.WinRAR"; Type="winget"}
    @{Num=24; Name="qBittorrent"; Id="qBittorrent.qBittorrent"; Type="winget"}
    @{Num=25; Name="FileZilla"; Id="FileZilla.Client.FTP"; Type="winget"}
    @{Num=26; Name="WhatsApp"; Id="WhatsApp.WhatsApp"; Type="winget"}
    @{Num=27; Name="Signal"; Id="Signal.Signal"; Type="winget"}
    @{Num=28; Name="Thunderbird"; Id="Mozilla.Thunderbird"; Type="winget"}
    @{Num=29; Name="LibreOffice"; Id="TheDocumentFoundation.LibreOffice"; Type="winget"}
    @{Num=30; Name="Audacity"; Id="Audacity.Audacity"; Type="winget"}
    @{Num=31; Name="Inkscape"; Id="Inkscape.Inkscape"; Type="winget"}
    @{Num=32; Name="KeePassXC"; Id="KeePassXCTeam.KeePassXC"; Type="winget"}
    @{Num=33; Name="Rufus"; Id="Rufus.Rufus"; Type="winget"}
    @{Num=34; Name="CPU-Z"; Id="CPUID.CPU-Z"; Type="winget"}
    @{Num=35; Name="HWMonitor"; Id="CPUID.HWMonitor"; Type="winget"}
    @{Num=36; Name="CrystalDiskInfo"; Id="CrystalDewWorld.CrystalDiskInfo"; Type="winget"}
    @{Num=37; Name="CrystalDiskMark"; Id="CrystalDewWorld.CrystalDiskMark"; Type="winget"}
    @{Num=38; Name="VeraCrypt"; Id="IDRIX.VeraCrypt"; Type="winget"}
    @{Num=39; Name="Everything"; Id="voidtools.Everything"; Type="winget"}
    @{Num=40; Name="ShareX"; Id="ShareX.ShareX"; Type="winget"}
    @{Num=41; Name="HandBrake"; Id="HandBrake.HandBrake"; Type="winget"}
    @{Num=42; Name="Krita"; Id="Krita.Krita"; Type="winget"}
    @{Num=43; Name="Darktable"; Id="darktable.darktable"; Type="winget"}
    @{Num=44; Name="XnView"; Id="XnSoft.XnView"; Type="winget"}
    @{Num=45; Name="IrfanView"; Id="IrfanSkiljan.IrfanView"; Type="winget"}
    @{Num=46; Name="SumatraPDF"; Id="SumatraPDF.SumatraPDF"; Type="winget"}
    @{Num=47; Name="Calibre"; Id="Calibre.Calibre"; Type="winget"}
    @{Num=48; Name="JDownloader"; Id="AppWork.JDownloader"; Type="winget"}
    @{Num=49; Name="Transmission"; Id="Transmission.Transmission"; Type="winget"}
    @{Num=50; Name="TeamViewer"; Id="TeamViewer.TeamViewer"; Type="winget"}
    @{Num=51; Name="PuTTY"; Id="PuTTY.PuTTY"; Type="winget"}
    @{Num=52; Name="WinSCP"; Id="WinSCP.WinSCP"; Type="winget"}
    @{Num=53; Name="Wireshark"; Id="WiresharkFoundation.Wireshark"; Type="winget"}
    @{Num=54; Name="VirtualBox"; Id="Oracle.VirtualBox"; Type="winget"}
    @{Num=55; Name="Docker Desktop"; Id="Docker.DockerDesktop"; Type="winget"}
    @{Num=56; Name="MySQL Workbench"; Id="Oracle.MySQLWorkbench"; Type="winget"}
    @{Num=57; Name="Postman"; Id="Postman.Postman"; Type="winget"}
    @{Num=58; Name="MongoDB Compass"; Id="MongoDB.Compass"; Type="winget"}
    @{Num=59; Name="GitHub Desktop"; Id="GitHub.GitHubDesktop"; Type="winget"}
    @{Num=60; Name="Figma"; Id="Figma.Figma"; Type="winget"}
    @{Num=61; Name="Unity Hub"; Id="Unity.UnityHub"; Type="winget"}
    @{Num=62; Name="Revo Uninstaller"; Id="RevoGroup.RevoUninstaller"; Type="winget"}
    @{Num=63; Name="PowerISO"; Id="PowerSoftware.PowerISO"; Type="winget"}
    @{Num=64; Name="UltraISO"; Id="EZBSystems.UltraISO"; Type="winget"}
    @{Num=65; Name="TeraCopy"; Id="CodeSector.TeraCopy"; Type="winget"}
    @{Num=66; Name="Google Earth Pro"; Id="Google.GoogleEarthPro"; Type="winget"}
    @{Num=67; Name="Microsoft Teams"; Id="Microsoft.Teams"; Type="winget"}
    @{Num=68; Name="AnyDesk"; Id="AnyDeskSoftwareGmbH.AnyDesk"; Type="winget"}
    @{Num=69; Name="CCleaner"; Id="Piriform.CCleaner"; Type="winget"}
    @{Num=70; Name="Avast Free Antivirus"; Id="AvastSoftware.AvastAntivirus"; Type="winget"}
    @{Num=71; Name="Avira Antivirus"; Id="Avira.AviraAntivirus"; Type="winget"}
    @{Num=72; Name="ESET NOD32"; Id="ESET.ESETNOD32"; Type="winget"}
    @{Num=73; Name="AVG Antivirus"; Id="AVG.AVGAntivirus"; Type="winget"}
    @{Num=74; Name="CutePDF Writer"; Id="CutePDF.CutePDFWriter"; Type="winget"}
    @{Num=75; Name="Apache OpenOffice"; Id="Apache.OpenOffice"; Type="winget"}
    @{Num=76; Name="PeaZip"; Id="PeaZip.PeaZip"; Type="winget"}
    # Custom apps (not in winget)
    @{Num=77; Name="Winshot"; Id="custom"; Type="custom"; Url="https://github.com/mrgoonie/winshot/releases/download/v1.6.0/winshot.exe"; SilentArg="/S"}
)

function Install-CustomApp {
    param($App)
    
    Write-Host ">>> Installing $($App.Name)..." -ForegroundColor Cyan
    Write-Host "    Downloading from GitHub..." -ForegroundColor Gray
    
    $installer = "$env:TEMP\$($App.Name -replace ' ', '_')_installer.exe"
    
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri $App.Url -OutFile $installer -UseBasicParsing -ErrorAction Stop
        Write-Host "    Download complete!" -ForegroundColor Gray
        
        Write-Host "    Installing..." -ForegroundColor Gray
        $process = Start-Process $installer -ArgumentList $App.SilentArg -Wait -PassThru -NoNewWindow
        
        Remove-Item $installer -Force -ErrorAction SilentlyContinue
        
        if ($process.ExitCode -eq 0) {
            Write-Host "[✓] $($App.Name) installed successfully!" -ForegroundColor Green
            return $true
        } else {
            Write-Host "[✓] $($App.Name) installation completed (Exit: $($process.ExitCode))" -ForegroundColor Green
            return $true
        }
    } catch {
        Write-Host "[✗] Failed to install $($App.Name): $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

function Show-AllApps {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Available Applications (Three Columns)" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    
    $perColumn = [math]::Ceiling($AppsList.Count / 3)
    $col1 = $AppsList[0..($perColumn-1)]
    $col2 = $AppsList[$perColumn..(($perColumn*2)-1)]
    $col3 = $AppsList[($perColumn*2)..($AppsList.Count-1)]
    
    Write-Host "  Column 1                          Column 2                          Column 3" -ForegroundColor Yellow
    Write-Host "  --------                          --------                          --------" -ForegroundColor DarkGray
    
    $maxLines = [math]::Max([math]::Max($col1.Count, $col2.Count), $col3.Count)
    
    for ($i = 0; $i -lt $maxLines; $i++) {
        $col1Text = ""
        $col2Text = ""
        $col3Text = ""
        
        if ($i -lt $col1.Count) {
            $col1Text = "  $($col1[$i].Num). $($col1[$i].Name)"
            if ($col1[$i].Type -eq "custom") { $col1Text = "  $($col1[$i].Num). $($col1[$i].Name) *" }
            $col1Text = $col1Text.PadRight(35)
        } else {
            $col1Text = " " * 35
        }
        
        if ($i -lt $col2.Count) {
            $col2Text = "  $($col2[$i].Num). $($col2[$i].Name)"
            if ($col2[$i].Type -eq "custom") { $col2Text = "  $($col2[$i].Num). $($col2[$i].Name) *" }
            $col2Text = $col2Text.PadRight(35)
        } else {
            $col2Text = " " * 35
        }
        
        if ($i -lt $col3.Count) {
            $col3Text = "  $($col3[$i].Num). $($col3[$i].Name)"
            if ($col3[$i].Type -eq "custom") { $col3Text = "  $($col3[$i].Num). $($col3[$i].Name) *" }
        }
        
        Write-Host "$col1Text$col2Text$col3Text" -ForegroundColor White
    }
    
    Write-Host ""
    Write-Host "  * Custom app (direct download)" -ForegroundColor Yellow
    Write-Host "  Total: $($AppsList.Count) applications" -ForegroundColor Green
    Write-Host ""
    Write-Host "  [0] Back to main menu" -ForegroundColor Gray
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
}

function Get-InstalledVersion {
    param($Id)
    if ($Id -eq "custom") { return $null }
    try {
        $result = winget list --id $Id --accept-source-agreements 2>$null
        if ($result -match "$Id\s+(\S+)") {
            return $matches[1]
        }
    } catch {}
    return $null
}

function Get-LatestVersion {
    param($App)
    if ($App.Type -eq "custom") { return "Custom App" }
    try {
        $result = winget show $App.Id --accept-source-agreements 2>$null
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
        
        if ($app.Type -eq "custom") {
            # Check if Winshot is installed by looking for the exe
            $winshotPath = "$env:ProgramFiles\Winshot\winshot.exe"
            if (Test-Path $winshotPath) {
                $version = (Get-Item $winshotPath).VersionInfo.FileVersion
                if (-not $version) { $version = "Installed" }
                $results += [PSCustomObject]@{
                    Num = $app.Num
                    Name = $app.Name
                    CurrentVersion = $version
                    LatestVersion = "1.6.0"
                }
            }
        } else {
            $installed = Get-InstalledVersion -Id $app.Id
            if ($installed) {
                $latest = Get-LatestVersion -App $app
                $results += [PSCustomObject]@{
                    Num = $app.Num
                    Name = $app.Name
                    CurrentVersion = $installed
                    LatestVersion = $latest
                }
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
        } elseif ($app.LatestVersion -eq "Unknown" -or $app.LatestVersion -eq "Custom App") {
            Write-Host " $($app.LatestVersion)" -ForegroundColor Gray
        } else {
            Write-Host " $($app.LatestVersion)" -ForegroundColor Yellow
        }
    }
    
    Write-Host "================================================================================================" -ForegroundColor DarkGray
    Write-Host ""
    
    $updatesCount = 0
    foreach ($app in $results) {
        if ($app.CurrentVersion -ne $app.LatestVersion -and $app.LatestVersion -ne "Unknown" -and $app.LatestVersion -ne "Custom App") {
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
        $typeInfo = if ($app.Type -eq "custom") { " (custom download)" } else { "" }
        Write-Host "  - $($app.Name)$typeInfo" -ForegroundColor White
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
        if ($app.Type -eq "custom") {
            Install-CustomApp -App $app
        } else {
            Write-Host ">>> Installing $($app.Name)..." -ForegroundColor Cyan
            winget install $app.Id --accept-package-agreements --accept-source-agreements --silent
            
            if ($LASTEXITCODE -eq 0 -or $LASTEXITCODE -eq 1 -or $LASTEXITCODE -eq -1978335189) {
                Write-Host "[✓] $($app.Name) installed successfully!" -ForegroundColor Green
            } else {
                Write-Host "[✗] Failed to install $($app.Name)" -ForegroundColor Red
            }
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
    Write-Host "   [1] Show all available apps (three columns)" -ForegroundColor Green
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
            Write-Host "  * = Custom app (direct download from GitHub)" -ForegroundColor Yellow
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
