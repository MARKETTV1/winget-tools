#===============================================================================
# KARIM ABU RIDA - All-in-One Windows Manager
# Version: 4.1
# Tools: Winget Manager + App Scanner/Installer + IDM Activation
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

#===============================================================================
# APPS LIST (Winget + Custom)
#===============================================================================
$AppsList = @(
    @{Num=1;  Name="Google Chrome";          Id="Google.Chrome";                          Type="winget"}
    @{Num=2;  Name="Mozilla Firefox";        Id="Mozilla.Firefox";                        Type="winget"}
    @{Num=3;  Name="Brave Browser";          Id="Brave.Brave";                            Type="winget"}
    @{Num=4;  Name="Microsoft Edge";         Id="Microsoft.Edge";                         Type="winget"}
    @{Num=5;  Name="Visual Studio Code";     Id="Microsoft.VisualStudioCode";             Type="winget"}
    @{Num=6;  Name="7-Zip";                  Id="7zip.7zip";                              Type="winget"}
    @{Num=7;  Name="VLC Media Player";       Id="VideoLAN.VLC";                           Type="winget"}
    @{Num=8;  Name="Discord";                Id="Discord.Discord";                        Type="winget"}
    @{Num=9;  Name="Spotify";                Id="Spotify.Spotify";                        Type="winget"}
    @{Num=10; Name="Telegram";               Id="Telegram.TelegramDesktop";               Type="winget"}
    @{Num=11; Name="Zoom";                   Id="Zoom.Zoom";                              Type="winget"}
    @{Num=12; Name="Slack";                  Id="Slack.Slack";                            Type="winget"}
    @{Num=13; Name="Git";                    Id="Git.Git";                                Type="winget"}
    @{Num=14; Name="Node.js";                Id="OpenJS.NodeJS";                          Type="winget"}
    @{Num=15; Name="Python";                 Id="Python.Python.3";                        Type="winget"}
    @{Num=16; Name="Notepad++";              Id="Notepad++.Notepad++";                    Type="winget"}
    @{Num=17; Name="GIMP";                   Id="GIMP.GIMP";                              Type="winget"}
    @{Num=18; Name="Steam";                  Id="Valve.Steam";                            Type="winget"}
    @{Num=19; Name="Epic Games Launcher";    Id="EpicGames.EpicGamesLauncher";            Type="winget"}
    @{Num=20; Name="OBS Studio";             Id="OBSProject.OBSStudio";                   Type="winget"}
    @{Num=21; Name="Blender";                Id="BlenderFoundation.Blender";              Type="winget"}
    @{Num=22; Name="Adobe Acrobat Reader";   Id="Adobe.Acrobat.Reader.64-bit";            Type="winget"}
    @{Num=23; Name="WinRAR";                 Id="WinRAR.WinRAR";                          Type="winget"}
    @{Num=24; Name="qBittorrent";            Id="qBittorrent.qBittorrent";                Type="winget"}
    @{Num=25; Name="FileZilla";              Id="FileZilla.Client.FTP";                   Type="winget"}
    @{Num=26; Name="WhatsApp";               Id="WhatsApp.WhatsApp";                      Type="winget"}
    @{Num=27; Name="Signal";                 Id="Signal.Signal";                          Type="winget"}
    @{Num=28; Name="Thunderbird";            Id="Mozilla.Thunderbird";                    Type="winget"}
    @{Num=29; Name="LibreOffice";            Id="TheDocumentFoundation.LibreOffice";      Type="winget"}
    @{Num=30; Name="Audacity";               Id="Audacity.Audacity";                      Type="winget"}
    @{Num=31; Name="Inkscape";               Id="Inkscape.Inkscape";                      Type="winget"}
    @{Num=32; Name="KeePassXC";              Id="KeePassXCTeam.KeePassXC";               Type="winget"}
    @{Num=33; Name="Rufus";                  Id="Rufus.Rufus";                            Type="winget"}
    @{Num=34; Name="CPU-Z";                  Id="CPUID.CPU-Z";                            Type="winget"}
    @{Num=35; Name="HWMonitor";              Id="CPUID.HWMonitor";                        Type="winget"}
    @{Num=36; Name="CrystalDiskInfo";        Id="CrystalDewWorld.CrystalDiskInfo";        Type="winget"}
    @{Num=37; Name="CrystalDiskMark";        Id="CrystalDewWorld.CrystalDiskMark";        Type="winget"}
    @{Num=38; Name="VeraCrypt";              Id="IDRIX.VeraCrypt";                        Type="winget"}
    @{Num=39; Name="Everything";             Id="voidtools.Everything";                   Type="winget"}
    @{Num=40; Name="ShareX";                 Id="ShareX.ShareX";                          Type="winget"}
    @{Num=41; Name="HandBrake";              Id="HandBrake.HandBrake";                    Type="winget"}
    @{Num=42; Name="Krita";                  Id="Krita.Krita";                            Type="winget"}
    @{Num=43; Name="Darktable";              Id="darktable.darktable";                    Type="winget"}
    @{Num=44; Name="XnView";                 Id="XnSoft.XnView";                          Type="winget"}
    @{Num=45; Name="IrfanView";              Id="IrfanSkiljan.IrfanView";                 Type="winget"}
    @{Num=46; Name="SumatraPDF";             Id="SumatraPDF.SumatraPDF";                  Type="winget"}
    @{Num=47; Name="Calibre";                Id="Calibre.Calibre";                        Type="winget"}
    @{Num=48; Name="JDownloader";            Id="AppWork.JDownloader";                    Type="winget"}
    @{Num=49; Name="Transmission";           Id="Transmission.Transmission";              Type="winget"}
    @{Num=50; Name="TeamViewer";             Id="TeamViewer.TeamViewer";                  Type="winget"}
    @{Num=51; Name="PuTTY";                  Id="PuTTY.PuTTY";                            Type="winget"}
    @{Num=52; Name="WinSCP";                 Id="WinSCP.WinSCP";                          Type="winget"}
    @{Num=53; Name="Wireshark";              Id="WiresharkFoundation.Wireshark";          Type="winget"}
    @{Num=54; Name="VirtualBox";             Id="Oracle.VirtualBox";                      Type="winget"}
    @{Num=55; Name="Docker Desktop";         Id="Docker.DockerDesktop";                   Type="winget"}
    @{Num=56; Name="MySQL Workbench";        Id="Oracle.MySQLWorkbench";                  Type="winget"}
    @{Num=57; Name="Postman";                Id="Postman.Postman";                        Type="winget"}
    @{Num=58; Name="MongoDB Compass";        Id="MongoDB.Compass";                        Type="winget"}
    @{Num=59; Name="GitHub Desktop";         Id="GitHub.GitHubDesktop";                   Type="winget"}
    @{Num=60; Name="Figma";                  Id="Figma.Figma";                            Type="winget"}
    @{Num=61; Name="Unity Hub";              Id="Unity.UnityHub";                         Type="winget"}
    @{Num=62; Name="Revo Uninstaller";       Id="RevoGroup.RevoUninstaller";              Type="winget"}
    @{Num=63; Name="PowerISO";               Id="PowerSoftware.PowerISO";                 Type="winget"}
    @{Num=64; Name="UltraISO";               Id="EZBSystems.UltraISO";                    Type="winget"}
    @{Num=65; Name="TeraCopy";               Id="CodeSector.TeraCopy";                    Type="winget"}
    @{Num=66; Name="Google Earth Pro";       Id="Google.EarthPro";                        Type="winget"}
    @{Num=67; Name="Microsoft Teams";        Id="Microsoft.Teams";                        Type="winget"}
    @{Num=68; Name="AnyDesk";                Id="AnyDeskSoftwareGmbH.AnyDesk";            Type="winget"}
    @{Num=69; Name="CCleaner";               Id="Piriform.CCleaner";                      Type="winget"}
    @{Num=70; Name="Avast Free Antivirus";   Id="AvastSoftware.AvastAntivirus";           Type="winget"}
    @{Num=71; Name="Avira Antivirus";        Id="Avira.AviraAntivirus";                   Type="winget"}
    @{Num=72; Name="ESET NOD32";             Id="ESET.ESETNOD32";                         Type="winget"}
    @{Num=73; Name="AVG Antivirus";          Id="AVG.AVGAntivirus";                       Type="winget"}
    @{Num=74; Name="CutePDF Writer";         Id="CutePDF.CutePDFWriter";                  Type="winget"}
    @{Num=75; Name="Apache OpenOffice";      Id="Apache.OpenOffice";                      Type="winget"}
    @{Num=76; Name="PeaZip";                 Id="PeaZip.PeaZip";                          Type="winget"}
    @{Num=77; Name="Winshot";                Id="custom"; Type="custom";
               Url="https://github.com/mrgoonie/winshot/releases/download/v1.6.0/winshot.exe"; SilentArg="/S"}
    @{Num=78; Name="Neat Download Manager";  Id="custom"; Type="custom";
               Url="https://neatdownloadmanager.com/file/NeatDM_setup.exe"; SilentArg="/S"}
)

#===============================================================================
# SHARED HELPERS
#===============================================================================
function Install-CustomApp {
    param($App)
    Write-Host ">>> Installing $($App.Name)..." -ForegroundColor Cyan
    Write-Host "    Downloading..." -ForegroundColor Gray
    $installer = "$env:TEMP\$($App.Name -replace ' ','_')_installer.exe"
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri $App.Url -OutFile $installer -UseBasicParsing -ErrorAction Stop
        Write-Host "    Download complete!" -ForegroundColor Gray
        $process = Start-Process $installer -ArgumentList $App.SilentArg -Wait -PassThru -NoNewWindow
        Remove-Item $installer -Force -ErrorAction SilentlyContinue
        Write-Host "[OK] $($App.Name) installed! (Exit: $($process.ExitCode))" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "[FAIL] $($App.Name): $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

function Get-InstalledVersion { param($Id)
    if ($Id -eq "custom") { return $null }
    try {
        $r = winget list --id $Id --accept-source-agreements 2>$null
        if ($r -match "$Id\s+(\S+)") { return $matches[1] }
    } catch {}
    return $null
}

function Get-LatestVersion { param($App)
    if ($App.Type -eq "custom") { return "Custom App" }
    try {
        $r = winget show $App.Id --accept-source-agreements 2>$null
        if ($r -match "Version:\s*(\S+)") { return $matches[1] }
    } catch {}
    return "Unknown"
}

#===============================================================================
# MODULE 1 — WINGET MANAGER
#===============================================================================
function Show-AllSystemApps {
    Clear-Host; Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                All Installed Applications - Version Viewer" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""; Write-Host "Loading... please wait" -ForegroundColor Yellow; Write-Host ""

    Write-Host "----------------------------------------" -ForegroundColor Magenta
    Write-Host "[A] WINGET APPLICATIONS" -ForegroundColor Green
    Write-Host "----------------------------------------" -ForegroundColor Magenta; Write-Host ""
    $wingetApps = winget list --accept-source-agreements 2>$null
    $wList = @(); $found = $false
    foreach ($line in ($wingetApps -split "`n")) {
        if ($line -match "^-+---") { $found = $true; continue }
        if ($found -and $line.Trim() -ne "") {
            $p = $line -split '\s{2,}'
            if ($p.Count -ge 2 -and $p[0] -match "[a-zA-Z0-9]") {
                $wList += [PSCustomObject]@{ Name=$p[1].Trim(); Version=if($p.Count -gt 2){$p[2].Trim()}else{"Unknown"} }
            }
        }
    }
    $show = [Math]::Min(100, $wList.Count)
    for ($i=0; $i -lt $show; $i++) {
        Write-Host "$($i+1). " -NoNewline -ForegroundColor Cyan
        Write-Host "$($wList[$i].Name)" -NoNewline -ForegroundColor White
        Write-Host " [$($wList[$i].Version)]" -ForegroundColor Yellow
    }
    if ($wList.Count -gt 100) { Write-Host "... and $($wList.Count-100) more" -ForegroundColor Gray }
    Write-Host ""; Write-Host "Total: $($wList.Count)" -ForegroundColor Green; Write-Host ""

    Write-Host "----------------------------------------" -ForegroundColor Magenta
    Write-Host "[B] MICROSOFT STORE APPS" -ForegroundColor Green
    Write-Host "----------------------------------------" -ForegroundColor Magenta; Write-Host ""
    $sList = Get-AppxPackage | Sort-Object Name | ForEach-Object {
        [PSCustomObject]@{ Name=$_.Name; Version=if($_.Version){$_.Version}else{"Unknown"} }
    }
    $showS = [Math]::Min(50, $sList.Count)
    for ($i=0; $i -lt $showS; $i++) {
        Write-Host "$($i+1). " -NoNewline -ForegroundColor Cyan
        Write-Host "$($sList[$i].Name)" -NoNewline -ForegroundColor White
        Write-Host " [$($sList[$i].Version)]" -ForegroundColor Yellow
    }
    if ($sList.Count -gt 50) { Write-Host "... and $($sList.Count-50) more" -ForegroundColor Gray }
    Write-Host ""; Write-Host "Total: $($sList.Count)" -ForegroundColor Green; Write-Host ""

    Write-Host "----------------------------------------" -ForegroundColor Magenta
    Write-Host "[C] TRADITIONAL APPLICATIONS" -ForegroundColor Green
    Write-Host "----------------------------------------" -ForegroundColor Magenta; Write-Host ""
    $rList = @()
    foreach ($path in @("HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*","HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*")) {
        try {
            Get-ItemProperty $path -ErrorAction SilentlyContinue |
            Where-Object { $_.DisplayName -and $_.DisplayName -notmatch "^KB\d" } |
            ForEach-Object { $rList += [PSCustomObject]@{ Name=$_.DisplayName; Version=if($_.DisplayVersion){$_.DisplayVersion}else{"Unknown"} } }
        } catch {}
    }
    $rList = $rList | Sort-Object Name -Unique
    $showR = [Math]::Min(50, $rList.Count)
    for ($i=0; $i -lt $showR; $i++) {
        Write-Host "$($i+1). " -NoNewline -ForegroundColor Cyan
        Write-Host "$($rList[$i].Name)" -NoNewline -ForegroundColor White
        Write-Host " [$($rList[$i].Version)]" -ForegroundColor Yellow
    }
    if ($rList.Count -gt 50) { Write-Host "... and $($rList.Count-50) more" -ForegroundColor Gray }

    Write-Host ""; Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "SUMMARY" -ForegroundColor White
    Write-Host "Winget: $($wList.Count)  |  Store: $($sList.Count)  |  Traditional: $($rList.Count)" -ForegroundColor Yellow
    Write-Host "TOTAL: $($wList.Count+$sList.Count+$rList.Count)" -ForegroundColor Green
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""; Read-Host "Press Enter to return to main menu"
}

function Update-Selective {
    Clear-Host; Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                   Selective Winget Update Manager" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""; Write-Host "Checking for updates..." -ForegroundColor Yellow; Write-Host ""

    $upgradeOutput = winget upgrade --accept-source-agreements 2>$null
    $uList = @(); $found = $false
    foreach ($line in ($upgradeOutput -split "`n")) {
        if ($line -match "^-+---") { $found = $true; continue }
        if ($found -and $line.Trim() -ne "") {
            $p = $line -split '\s{2,}'
            if ($p.Count -ge 4 -and $p[0] -match "[a-zA-Z0-9]") {
                $uList += [PSCustomObject]@{ Id=$p[0].Trim(); Name=$p[1].Trim(); Current=$p[2].Trim(); Available=$p[3].Trim() }
            }
        }
    }

    if ($uList.Count -eq 0) {
        Write-Host "No updates available!" -ForegroundColor Green
        Write-Host ""; Read-Host "Press Enter to return"; return
    }

    Write-Host "Available updates:" -ForegroundColor Green; Write-Host ""
    for ($i=0; $i -lt $uList.Count; $i++) {
        Write-Host "[$($i+1)] " -NoNewline -ForegroundColor Cyan
        Write-Host "$($uList[$i].Name) " -NoNewline -ForegroundColor White
        Write-Host "($($uList[$i].Current) -> $($uList[$i].Available))" -ForegroundColor Yellow
    }

    Write-Host ""
    Write-Host "Options: numbers 1,2,3  |  'all'  |  '0' to go back" -ForegroundColor Gray
    Write-Host ""
    $userInput = Read-Host "Your choice"
    if ($userInput -eq "0") { return }

    $toUpdate = @()
    if ($userInput -eq "all") { $toUpdate = $uList }
    else {
        foreach ($n in ($userInput -split ",")) {
            $idx = [int]$n.Trim() - 1
            if ($idx -ge 0 -and $idx -lt $uList.Count) { $toUpdate += $uList[$idx] }
        }
    }

    if ($toUpdate.Count -eq 0) { Write-Host "No valid selection!" -ForegroundColor Red; Read-Host "Press Enter"; return }

    Write-Host ""; Write-Host "Selected:" -ForegroundColor Green
    $toUpdate | ForEach-Object { Write-Host "  - $($_.Name)" -ForegroundColor White }
    Write-Host ""
    $confirm = Read-Host "Proceed? (y/n)"
    if ($confirm -ne "y" -and $confirm -ne "Y") { Write-Host "Cancelled!" -ForegroundColor Red; Read-Host "Press Enter"; return }

    Write-Host ""; Write-Host "Starting updates..." -ForegroundColor Yellow; Write-Host ""
    foreach ($app in $toUpdate) {
        Write-Host ">>> Updating $($app.Name)..." -ForegroundColor Cyan
        winget upgrade $app.Id --accept-package-agreements --accept-source-agreements --silent
        if ($LASTEXITCODE -eq 0) { Write-Host "[OK] $($app.Name) updated!" -ForegroundColor Green }
        else { Write-Host "[FAIL] $($app.Name)" -ForegroundColor Red }
        Write-Host ""
    }

    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "Done!" -ForegroundColor Green
    Write-Host ""; Read-Host "Press Enter to return"
}

#===============================================================================
# MODULE 2 — APP SCANNER + DIRECT INSTALLER
#===============================================================================
function Show-AppsList {
    Clear-Host; Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Available Applications (Three Columns)" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan; Write-Host ""

    $perCol = [math]::Ceiling($AppsList.Count / 3)
    $c1 = $AppsList[0..($perCol-1)]
    $c2 = $AppsList[$perCol..(($perCol*2)-1)]
    $c3 = $AppsList[($perCol*2)..($AppsList.Count-1)]
    $maxL = [math]::Max([math]::Max($c1.Count,$c2.Count),$c3.Count)

    Write-Host "  Column 1                          Column 2                          Column 3" -ForegroundColor Yellow
    Write-Host "  --------                          --------                          --------" -ForegroundColor DarkGray

    for ($i=0; $i -lt $maxL; $i++) {
        $t1 = if ($i -lt $c1.Count) { "  $($c1[$i].Num). $($c1[$i].Name)$(if($c1[$i].Type -eq 'custom'){' *'})".PadRight(35) } else { " "*35 }
        $t2 = if ($i -lt $c2.Count) { "  $($c2[$i].Num). $($c2[$i].Name)$(if($c2[$i].Type -eq 'custom'){' *'})".PadRight(35) } else { " "*35 }
        $t3 = if ($i -lt $c3.Count) { "  $($c3[$i].Num). $($c3[$i].Name)$(if($c3[$i].Type -eq 'custom'){' *'})" } else { "" }
        Write-Host "$t1$t2$t3" -ForegroundColor White
    }

    Write-Host ""; Write-Host "  * Custom app (direct download)" -ForegroundColor Yellow
    Write-Host "  Total: $($AppsList.Count) apps" -ForegroundColor Green
    Write-Host ""; Write-Host "  [0] Back to main menu" -ForegroundColor Gray
    Write-Host "================================================================================" -ForegroundColor Cyan
}

function Scan-InstalledApps {
    Clear-Host; Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Scanning Installed Applications" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""; Write-Host "Please wait..." -ForegroundColor Yellow; Write-Host ""

    $results = @(); $total = $AppsList.Count; $current = 0
    foreach ($app in $AppsList) {
        $current++
        Write-Progress -Activity "Scanning..." -Status $app.Name -PercentComplete (($current/$total)*100)
        if ($app.Type -eq "custom") {
            $p = "$env:ProgramFiles\Winshot\winshot.exe"
            if ($app.Name -eq "Neat Download Manager") {
                $p = "$env:ProgramFiles\NeatDM\NeatDM.exe"
            }
            if (Test-Path $p) {
                $v = (Get-Item $p).VersionInfo.FileVersion
                $results += [PSCustomObject]@{ Num=$app.Num; Name=$app.Name; Current=if($v){$v}else{"Installed"}; Latest="Latest" }
            }
        } else {
            $inst = Get-InstalledVersion -Id $app.Id
            if ($inst) {
                $latest = Get-LatestVersion -App $app
                $results += [PSCustomObject]@{ Num=$app.Num; Name=$app.Name; Current=$inst; Latest=$latest }
            }
        }
    }
    Write-Progress -Activity "Scanning..." -Completed

    Clear-Host; Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Installed Applications Report" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""; Write-Host "Found $($results.Count) installed apps" -ForegroundColor Green; Write-Host ""
    Write-Host "================================================================================================" -ForegroundColor DarkGray
    Write-Host " No.  Name                                       Current                   Latest" -ForegroundColor Yellow
    Write-Host "================================================================================================" -ForegroundColor DarkGray

    foreach ($app in ($results | Sort-Object Name)) {
        Write-Host " $($app.Num). " -NoNewline -ForegroundColor Cyan
        Write-Host "$($app.Name.PadRight(42))" -NoNewline -ForegroundColor White
        Write-Host "$($app.Current.PadRight(25))" -NoNewline -ForegroundColor Cyan
        $color = if ($app.Current -eq $app.Latest) { "Green" } elseif ($app.Latest -in "Unknown","Custom App","Latest") { "Gray" } else { "Yellow" }
        Write-Host "$($app.Latest)" -ForegroundColor $color
    }

    Write-Host "================================================================================================" -ForegroundColor DarkGray
    Write-Host ""
    $upd = ($results | Where-Object { $_.Current -ne $_.Latest -and $_.Latest -notin "Unknown","Custom App","Latest" }).Count
    if ($upd -gt 0) { Write-Host "Updates available: $upd apps" -ForegroundColor Yellow }
    else { Write-Host "All apps are up to date!" -ForegroundColor Green }

    Write-Host ""; Read-Host "Press Enter to return to main menu"
    return $results
}

function Install-ByNumbers {
    param($Numbers)
    $selected = $AppsList | Where-Object { $Numbers -contains $_.Num }
    if (-not $selected) { Write-Host "No valid apps selected!" -ForegroundColor Red; return }

    Write-Host ""; Write-Host "Selected:" -ForegroundColor Green
    foreach ($app in $selected) {
        Write-Host "  - $($app.Name)$(if($app.Type -eq 'custom'){' (custom)'})" -ForegroundColor White
    }
    Write-Host ""
    $confirm = Read-Host "Proceed with installation? (y/n)"
    if ($confirm -ne "y") { Write-Host "Cancelled." -ForegroundColor Red; return }

    Write-Host ""; Write-Host "Starting installation..." -ForegroundColor Yellow; Write-Host ""
    foreach ($app in $selected) {
        if ($app.Type -eq "custom") {
            Install-CustomApp -App $app
        } else {
            Write-Host ">>> Installing $($app.Name)..." -ForegroundColor Cyan
            winget install $app.Id --accept-package-agreements --accept-source-agreements --silent
            if ($LASTEXITCODE -in 0,1,-1978335189) { Write-Host "[OK] $($app.Name) installed!" -ForegroundColor Green }
            else { Write-Host "[FAIL] $($app.Name) (Error: $LASTEXITCODE)" -ForegroundColor Red }
        }
        Write-Host ""
    }
}

#===============================================================================
# MODULE 3 — IDM ACTIVATION
#===============================================================================
function Run-IDMActivation {
    Clear-Host; Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                   IDM Activation Script (IAS)" -ForegroundColor Magenta
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "   [1] Download and run IDM Activation" -ForegroundColor Green
    Write-Host "   [0] Back to main menu" -ForegroundColor Gray
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""

    $subChoice = Read-Host "Enter your choice"

    if ($subChoice -eq "0") { return }

    if ($subChoice -eq "1") {
        Write-Host ""; Write-Host "Downloading IAS script..." -ForegroundColor Yellow
        try {
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            $iasPath = "$env:TEMP\IAS.cmd"
            Invoke-WebRequest -Uri "https://raw.githubusercontent.com/MARKETTV1/idm/refs/heads/main/IAS.cmd" -OutFile $iasPath -ErrorAction Stop
            Write-Host "Download complete! Launching..." -ForegroundColor Green
            Write-Host ""
            Start-Process cmd.exe -ArgumentList "/c `"$iasPath`"" -Verb RunAs -Wait
            Write-Host ""; Write-Host "IDM Activation finished." -ForegroundColor Green
        } catch {
            Write-Host ""; Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
        }
    } else {
        Write-Host "Invalid choice!" -ForegroundColor Red
    }

    Write-Host ""
    Read-Host "Press Enter to return to main menu"
}

#===============================================================================
# MAIN MENU
#===============================================================================
function Show-MainMenu {
    Clear-Host; Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "              All-in-One Windows Manager v4.1 - by KARIM ABU RIDA" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "   ── WINGET MANAGER ─────────────────────────────────────────────" -ForegroundColor DarkGray
    Write-Host "   [1] Show all installed system apps with versions" -ForegroundColor Green
    Write-Host "   [2] Check for updates and update selectively" -ForegroundColor Green
    Write-Host ""
    Write-Host "   ── APP SCANNER & INSTALLER ──────────────────────────────────" -ForegroundColor DarkGray
    Write-Host "   [3] Show available apps list (78 apps)" -ForegroundColor Cyan
    Write-Host "   [4] Scan and show installed apps with versions" -ForegroundColor Cyan
    Write-Host "   [5] Install apps directly by number" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "   ── ACTIVATION ───────────────────────────────────────────────" -ForegroundColor DarkGray
    Write-Host "   [6] IDM Activation (Internet Download Manager)" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "   [7] Exit" -ForegroundColor Red
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                         Developed by: KARIM ABU RIDA" -ForegroundColor Yellow
    Write-Host "================================================================================" -ForegroundColor Cyan
}

#===============================================================================
# MAIN LOOP
#===============================================================================
do {
    Show-MainMenu
    $choice = Read-Host "`nEnter your choice (1-7)"

    switch ($choice) {
        "1" { Show-AllSystemApps }
        "2" { Update-Selective }
        "3" {
            Show-AppsList
            Read-Host "`nPress Enter to return to main menu"
        }
        "4" { Scan-InstalledApps }
        "5" {
            Show-AppsList
            Write-Host ""
            Write-Host "  Examples: 1,2,3  or  1 2 3" -ForegroundColor Gray
            Write-Host "  [0] Back to main menu" -ForegroundColor Gray
            Write-Host ""
            $raw = Read-Host "Enter numbers"
            if ($raw -ne "0") {
                $raw = $raw -replace " ",","
                $nums = @()
                foreach ($n in ($raw -split ",")) { if ($n.Trim() -match "^\d+$") { $nums += [int]$n.Trim() } }
                if ($nums.Count -gt 0) { Install-ByNumbers -Numbers $nums }
                else { Write-Host "No valid numbers!" -ForegroundColor Red }
                Read-Host "`nPress Enter to continue"
            }
        }
        "6" { Run-IDMActivation }
        "7" {
            Clear-Host; Show-Signature
            Write-Host ""
            Write-Host "================================================================================" -ForegroundColor Cyan
            Write-Host "                   Thank you for using All-in-One Manager!" -ForegroundColor White
            Write-Host "================================================================================" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "                         Developed by: KARIM ABU RIDA" -ForegroundColor Yellow
            Write-Host "                         GitHub: MARKETTV1" -ForegroundColor Yellow
            Write-Host ""
            Write-Host "Goodbye!" -ForegroundColor Green
            Write-Host ""
            Start-Sleep -Seconds 2
            break
        }
        default {
            Write-Host "Invalid choice! Enter 1-7" -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    }
} while ($choice -ne "7")
