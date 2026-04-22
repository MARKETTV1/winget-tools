#===============================================================================
# KARIM ABU RIDA - All-in-One Windows Manager
# Version: 5.0
# Tools: System Info + Winget Manager + App Scanner/Installer + IDM Activation
# GitHub: MARKETTV1
#===============================================================================

Clear-Host

function Show-Signature {
    Write-Host "                                                                  " -ForegroundColor DarkGray
    Write-Host "   ██╗  ██╗ █████╗ ██████╗ ██╗███╗   ███╗    █████╗  ██████╗ ██╗   ██╗    ██████╗ ██╗██████╗  █████╗ " -ForegroundColor Cyan
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
# SYSTEM INFORMATION DASHBOARD
#===============================================================================
function Get-CorrectWindowsVersion {
    $regPath = "HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion"
    
    $build = (Get-ItemProperty -Path $regPath -Name CurrentBuild -ErrorAction SilentlyContinue).CurrentBuild
    $buildInt = [int]$build
    
    $productName = (Get-ItemProperty -Path $regPath -Name ProductName -ErrorAction SilentlyContinue).ProductName
    $displayVersion = (Get-ItemProperty -Path $regPath -Name DisplayVersion -ErrorAction SilentlyContinue).DisplayVersion
    $releaseId = (Get-ItemProperty -Path $regPath -Name ReleaseId -ErrorAction SilentlyContinue).ReleaseId
    
    if ($buildInt -ge 22000) {
        $windowsName = "Windows 11"
        $edition = $productName -replace "Windows 10 ", "" -replace "Windows 11 ", ""
        $finalName = "Windows 11 $edition"
    } elseif ($buildInt -ge 10240) {
        $windowsName = "Windows 10"
        $edition = $productName -replace "Windows 10 ", ""
        $finalName = "Windows 10 $edition"
    } elseif ($buildInt -ge 9200) {
        $finalName = "Windows 8.1"
    } elseif ($buildInt -ge 7600) {
        $finalName = "Windows 7"
    } else {
        $finalName = $productName
    }
    
    $versionFriendly = ""
    if ($displayVersion) {
        $versionFriendly = $displayVersion
    } elseif ($releaseId) {
        $versionFriendly = $releaseId
    }
    
    return @{
        FullName = $finalName
        Build = $buildInt
        VersionFriendly = $versionFriendly
    }
}

function Get-LocalIP {
    try {
        $ip = (Get-NetIPAddress -AddressFamily IPv4 -ErrorAction SilentlyContinue | 
               Where-Object { $_.InterfaceAlias -notlike "*Loopback*" -and $_.PrefixOrigin -ne "WellKnown" } | 
               Select-Object -First 1).IPAddress
        if (-not $ip) {
            $ip = (Test-Connection -ComputerName $env:COMPUTERNAME -Count 1 -ErrorAction SilentlyContinue).IPV4Address.IPAddressToString
        }
        if (-not $ip) { $ip = "Unable to retrieve" }
        return $ip
    } catch {
        return "Unable to retrieve"
    }
}

function Get-PublicIP {
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $publicIP = (Invoke-WebRequest -Uri "https://api.ipify.org" -UseBasicParsing -TimeoutSec 5 -ErrorAction Stop).Content
        if ($publicIP -match '^\d+\.\d+\.\d+\.\d+$') {
            return $publicIP
        }
    } catch {}
    
    try {
        $publicIP = (Invoke-WebRequest -Uri "https://icanhazip.com" -UseBasicParsing -TimeoutSec 5 -ErrorAction Stop).Content.Trim()
        if ($publicIP -match '^\d+\.\d+\.\d+\.\d+$') {
            return $publicIP
        }
    } catch {}
    
    return "Not connected"
}

function Get-NetworkAdapter {
    try {
        $adapter = Get-NetAdapter -Physical -ErrorAction SilentlyContinue | Where-Object { $_.Status -eq "Up" } | Select-Object -First 1
        if ($adapter) {
            $adapterName = $adapter.Name
            if ($adapterName.Length -gt 35) { $adapterName = $adapterName.Substring(0, 32) + "..." }
            return $adapterName
        }
        return "No active adapter"
    } catch {
        return "Unable to retrieve"
    }
}

function Show-SystemInfo {
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                         SYSTEM INFORMATION DASHBOARD" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""

    # Computer Name
    $computerName = $env:COMPUTERNAME
    Write-Host "  🖥️  Computer Name        : " -NoNewline -ForegroundColor Yellow
    Write-Host "$computerName" -ForegroundColor White

    # Username
    $userName = $env:USERNAME
    Write-Host "  👤  Current User         : " -NoNewline -ForegroundColor Yellow
    Write-Host "$userName" -ForegroundColor White

    # Windows Version
    $winInfo = Get-CorrectWindowsVersion
    Write-Host "  🪟  Windows Version      : " -NoNewline -ForegroundColor Yellow
    Write-Host "$($winInfo.FullName) (Build $($winInfo.Build))" -ForegroundColor White
    if ($winInfo.VersionFriendly) {
        Write-Host "                         : " -NoNewline -ForegroundColor Yellow
        Write-Host "Version $($winInfo.VersionFriendly)" -ForegroundColor Gray
    }

    # Windows Edition
    $winEdition = (Get-ItemProperty "HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name EditionID -ErrorAction SilentlyContinue).EditionID
    if (-not $winEdition) {
        $winEdition = (Get-ItemProperty "HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name CompositionEditionID -ErrorAction SilentlyContinue).CompositionEditionID
    }
    Write-Host "  📀  Windows Edition      : " -NoNewline -ForegroundColor Yellow
    Write-Host "$winEdition" -ForegroundColor White

    # System Architecture
    $arch = $env:PROCESSOR_ARCHITECTURE
    Write-Host "  🔧  System Architecture  : " -NoNewline -ForegroundColor Yellow
    Write-Host "$arch" -ForegroundColor White

    # Processor
    $cpu = (Get-CimInstance -ClassName Win32_Processor -ErrorAction SilentlyContinue).Name
    if ($cpu) {
        if ($cpu.Length -gt 50) { $cpu = $cpu.Substring(0, 47) + "..." }
        Write-Host "  ⚡  Processor           : " -NoNewline -ForegroundColor Yellow
        Write-Host "$cpu" -ForegroundColor White
    } else {
        Write-Host "  ⚡  Processor           : " -NoNewline -ForegroundColor Yellow
        Write-Host "Unable to retrieve" -ForegroundColor Gray
    }

    # RAM
    $ram = (Get-CimInstance -ClassName Win32_ComputerSystem -ErrorAction SilentlyContinue).TotalPhysicalMemory
    if ($ram) {
        $ramGB = [math]::Round($ram / 1GB, 2)
        Write-Host "  💾  RAM                 : " -NoNewline -ForegroundColor Yellow
        Write-Host "$ramGB GB" -ForegroundColor White
    } else {
        Write-Host "  💾  RAM                 : " -NoNewline -ForegroundColor Yellow
        Write-Host "Unable to retrieve" -ForegroundColor Gray
    }

    # Disk Space
    try {
        $drive = Get-PSDrive -Name C -ErrorAction Stop
        $freeSpace = [math]::Round($drive.Free / 1GB, 2)
        $totalSpace = [math]::Round(($drive.Used + $drive.Free) / 1GB, 2)
        $freePercent = [math]::Round(($drive.Free / ($drive.Used + $drive.Free)) * 100, 2)
        Write-Host "  💿  Disk (C:)           : " -NoNewline -ForegroundColor Yellow
        Write-Host "$freeSpace GB free / $totalSpace GB total ($freePercent% free)" -ForegroundColor White
    } catch {
        Write-Host "  💿  Disk (C:)           : " -NoNewline -ForegroundColor Yellow
        Write-Host "Unable to retrieve" -ForegroundColor Gray
    }

    # Windows Activation Status
    try {
        $activation = (Get-CimInstance -ClassName SoftwareLicensingProduct -ErrorAction SilentlyContinue | 
                       Where-Object { $_.PartialProductKey -and $_.ApplicationID -eq "55c92734-d682-4d71-983e-d6ec3f16059f" }).LicenseStatus
        if ($activation -eq 1) {
            Write-Host "  🔑  Activation Status   : " -NoNewline -ForegroundColor Yellow
            Write-Host "ACTIVATED" -ForegroundColor Green
        } else {
            Write-Host "  🔑  Activation Status   : " -NoNewline -ForegroundColor Yellow
            Write-Host "NOT ACTIVATED" -ForegroundColor Red
        }
    } catch {
        Write-Host "  🔑  Activation Status   : " -NoNewline -ForegroundColor Yellow
        Write-Host "Unable to determine" -ForegroundColor Gray
    }

    Write-Host ""
    Write-Host "────────────────────────────────────────────────────────────────────────────────" -ForegroundColor DarkGray

    # Internet Connection
    $internetConnected = $false
    try {
        $test = Test-Connection -ComputerName "8.8.8.8" -Count 1 -Quiet -ErrorAction Stop -TimeoutSeconds 2
        $internetConnected = $test
        Write-Host "  🌐  Internet Connection : " -NoNewline -ForegroundColor Yellow
        if ($test) {
            Write-Host "CONNECTED" -ForegroundColor Green
        } else {
            Write-Host "DISCONNECTED" -ForegroundColor Red
        }
    } catch {
        Write-Host "  🌐  Internet Connection : " -NoNewline -ForegroundColor Yellow
        Write-Host "DISCONNECTED" -ForegroundColor Red
    }

    # Local IP Address
    $localIP = Get-LocalIP
    Write-Host "  🏠  Local IP Address    : " -NoNewline -ForegroundColor Yellow
    Write-Host "$localIP" -ForegroundColor White

    # Public IP Address (if connected)
    if ($internetConnected) {
        $publicIP = Get-PublicIP
        Write-Host "  🌍  Public IP Address   : " -NoNewline -ForegroundColor Yellow
        if ($publicIP -eq "Not connected") {
            Write-Host "$publicIP" -ForegroundColor Gray
        } else {
            Write-Host "$publicIP" -ForegroundColor White
        }
    } else {
        Write-Host "  🌍  Public IP Address   : " -NoNewline -ForegroundColor Yellow
        Write-Host "Not connected" -ForegroundColor Gray
    }

    # Network Adapter
    $adapterName = Get-NetworkAdapter
    Write-Host "  🔌  Network Adapter     : " -NoNewline -ForegroundColor Yellow
    Write-Host "$adapterName" -ForegroundColor White

    # Gateway IP
    try {
        $gateway = (Get-NetRoute -DestinationPrefix "0.0.0.0/0" -ErrorAction SilentlyContinue | 
                    Select-Object -First 1).NextHop
        if ($gateway) {
            Write-Host "  🚪  Default Gateway     : " -NoNewline -ForegroundColor Yellow
            Write-Host "$gateway" -ForegroundColor White
        }
    } catch {}

    Write-Host ""
    Write-Host "────────────────────────────────────────────────────────────────────────────────" -ForegroundColor DarkGray

    # Last Boot Time
    $lastBoot = (Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction SilentlyContinue).LastBootUpTime
    if ($lastBoot) {
        $uptime = (Get-Date) - $lastBoot
        $days = $uptime.Days
        $hours = $uptime.Hours
        $minutes = $uptime.Minutes
        Write-Host "  ⏰  Last Boot          : " -NoNewline -ForegroundColor Yellow
        Write-Host "$lastBoot" -ForegroundColor White
        Write-Host "  🕐  System Uptime      : " -NoNewline -ForegroundColor Yellow
        Write-Host "$days days, $hours hours, $minutes minutes" -ForegroundColor White
    } else {
        Write-Host "  ⏰  Last Boot          : " -NoNewline -ForegroundColor Yellow
        Write-Host "Unable to retrieve" -ForegroundColor Gray
    }

    Write-Host ""
    Write-Host "────────────────────────────────────────────────────────────────────────────────" -ForegroundColor DarkGray

    # Winget Version
    $wingetVer = winget --version 2>$null
    if ($wingetVer) {
        Write-Host "  📦  Winget Version     : " -NoNewline -ForegroundColor Yellow
        Write-Host "$wingetVer" -ForegroundColor White
    } else {
        Write-Host "  📦  Winget Version     : " -NoNewline -ForegroundColor Yellow
        Write-Host "NOT INSTALLED (Install from Microsoft Store)" -ForegroundColor Red
    }

    # PowerShell Version
    $psVer = $PSVersionTable.PSVersion.ToString()
    Write-Host "  ⚙️   PowerShell Version : " -NoNewline -ForegroundColor Yellow
    Write-Host "$psVer" -ForegroundColor White

    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
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
    @{Num=68; Name="AnyDesk";                Id="AnyDesk.AnyDesk";                        Type="winget"}
    @{Num=69; Name="CCleaner";               Id="Piriform.CCleaner";                      Type="winget"}
    @{Num=70; Name="Avast Free Antivirus";   Id="AvastSoftware.AvastAntivirus";           Type="winget"}
    @{Num=71; Name="Avira Antivirus";        Id="Avira.Avira";                            Type="winget"}
    @{Num=72; Name="ESET NOD32";             Id="ESET.ESETSmartSecurity";                 Type="winget"}
    @{Num=73; Name="AVG Antivirus";          Id="AVG.AntivirusFree";                      Type="winget"}
    @{Num=74; Name="CutePDF Writer";         Id="CutePDF.CutePDFWriter";                  Type="winget"}
    @{Num=75; Name="Apache OpenOffice";      Id="Apache.OpenOffice";                      Type="winget"}
    @{Num=76; Name="PeaZip";                 Id="PeaZip.PeaZip";                          Type="winget"}
    @{Num=77; Name="Winshot";                Id="custom"; Type="custom";
               Url="https://github.com/mrgoonie/winshot/releases/download/v1.6.0/winshot.exe"; SilentArg="/S"}
    @{Num=78; Name="Neat Download Manager";  Id="custom"; Type="custom";
               Url="https://neatdownloadmanager.com/file/NeatDM_setup.exe"; SilentArg="/S"}
    @{Num=79; Name="Screenpresso";           Id="custom"; Type="custom";
               Url="https://www.screenpresso.com/binaries/releases/stable/dotnet47/Screenpresso.exe"; SilentArg="/S"}
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
    Clear-Host
    Show-Signature
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
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                   Selective Winget Update Manager" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""; Write-Host "Checking for updates..." -ForegroundColor Yellow; Write-Host ""

    $upgradeOutput = winget upgrade --accept-source-agreements 2>$null
    $lines = $upgradeOutput -split "`n"
    
    # البحث عن بداية الجدول
    $startRecording = $false
    $validApps = @()
    
    foreach ($line in $lines) {
        # تخطي حتى نصل إلى الخط الفاصل
        if ($line -match "^-+---") {
            $startRecording = $true
            continue
        }
        
        if ($startRecording -and $line.Trim() -ne "") {
            $parts = $line -split '\s{2,}'
            # يجب أن يحتوي السطر على 4 أجزاء على الأقل
            if ($parts.Count -ge 4) {
                $id = $parts[0].Trim()
                $name = $parts[1].Trim()
                $currentVer = $parts[2].Trim()
                $availableVer = $parts[3].Trim()
                
                # التحقق من صحة التطبيق
                $isValid = $true
                
                # تجاهل التطبيقات غير الصالحة
                if ($id -eq "Id" -or $name -eq "Id") { $isValid = $false }
                if ($name -match "^(Version|Available|Source|Name)$") { $isValid = $false }
                if ($id -match "^(Version|Available|Source|Name)$") { $isValid = $false }
                if ([string]::IsNullOrWhiteSpace($name)) { $isValid = $false }
                if ($name.Length -lt 2) { $isValid = $false }
                if ($availableVer -eq "Available" -or $availableVer -eq "Source") { $isValid = $false }
                
                if ($isValid) {
                    $validApps += [PSCustomObject]@{
                        Id = $id
                        Name = $name
                        Current = $currentVer
                        Available = $availableVer
                    }
                }
            }
        }
    }

    if ($validApps.Count -eq 0) {
        Write-Host "No updates available!" -ForegroundColor Green
        Write-Host ""; Read-Host "Press Enter to return"; return
    }

    Write-Host "Available updates:" -ForegroundColor Green; Write-Host ""
    for ($i=0; $i -lt $validApps.Count; $i++) {
        Write-Host "[$($i+1)] " -NoNewline -ForegroundColor Cyan
        Write-Host "$($validApps[$i].Name) " -NoNewline -ForegroundColor White
        Write-Host "($($validApps[$i].Current) -> $($validApps[$i].Available))" -ForegroundColor Yellow
    }

    Write-Host ""
    Write-Host "Options: numbers 1,2,3  |  'all'  |  '0' to go back" -ForegroundColor Gray
    Write-Host ""
    $userInput = Read-Host "Your choice"
    if ($userInput -eq "0") { return }

    $toUpdate = @()
    if ($userInput -eq "all") { $toUpdate = $validApps }
    else {
        foreach ($n in ($userInput -split ",")) {
            $n = $n.Trim()
            if ($n -match "^\d+$") {
                $idx = [int]$n - 1
                if ($idx -ge 0 -and $idx -lt $validApps.Count) { 
                    $toUpdate += $validApps[$idx] 
                }
            }
        }
    }

    if ($toUpdate.Count -eq 0) { 
        Write-Host "No valid selection!" -ForegroundColor Red
        Write-Host ""; Read-Host "Press Enter to return"; 
        return 
    }

    Write-Host ""; Write-Host "Selected:" -ForegroundColor Green
    foreach ($app in $toUpdate) { 
        Write-Host "  - $($app.Name)" -ForegroundColor White 
    }
    Write-Host ""
    $confirm = Read-Host "Proceed? (y/n)"
    if ($confirm -ne "y" -and $confirm -ne "Y") { 
        Write-Host "Cancelled!" -ForegroundColor Red
        Write-Host ""; Read-Host "Press Enter to return"; 
        return 
    }

    Write-Host ""; Write-Host "Starting updates..." -ForegroundColor Yellow; Write-Host ""
    
    $successCount = 0
    $failCount = 0
    
    foreach ($app in $toUpdate) {
        Write-Host ">>> Updating $($app.Name)..." -ForegroundColor Cyan
        winget upgrade $app.Id --accept-package-agreements --accept-source-agreements --silent 2>&1
        
        if ($LASTEXITCODE -eq 0) { 
            Write-Host "[OK] $($app.Name) updated successfully!" -ForegroundColor Green
            $successCount++
        } elseif ($LASTEXITCODE -eq 1 -or $LASTEXITCODE -eq -1978335189) {
            Write-Host "[INFO] $($app.Name) is already up to date" -ForegroundColor Yellow
            $successCount++
        } else {
            Write-Host "[FAIL] Failed to update $($app.Name) (Error: $LASTEXITCODE)" -ForegroundColor Red
            $failCount++
        }
        Write-Host ""
    }

    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "Update process completed! (Success: $successCount, Failed: $failCount)" -ForegroundColor Green
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""; Read-Host "Press Enter to return"
}

#===============================================================================
# MODULE 2 — APP SCANNER + DIRECT INSTALLER
#===============================================================================
function Show-AppsList {
    Clear-Host
    Show-Signature
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
    Clear-Host
    Show-Signature
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
            if ($app.Name -eq "Screenpresso") {
                $p = "$env:ProgramFiles\Screenpresso\Screenpresso.exe"
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

    Clear-Host
    Show-Signature
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
            if ($LASTEXITCODE -in 0,1,-1978335189) {
                Write-Host "[OK] $($app.Name) installed!" -ForegroundColor Green
            } else {
                Write-Host "[FAIL] $($app.Name) (Error: $LASTEXITCODE)" -ForegroundColor Red
                Write-Host "       Try installing manually from official website" -ForegroundColor Gray
            }
        }
        Write-Host ""
    }
}

#===============================================================================
# MODULE 3 — IDM ACTIVATION
#===============================================================================
function Run-IDMActivation {
    Clear-Host
    Show-Signature
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
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "              All-in-One Windows Manager v5.9 - by KARIM ABU RIDA" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "   ── WINGET MANAGER ─────────────────────────────────────────────" -ForegroundColor DarkGray
    Write-Host "   [1] Show all installed system apps with versions" -ForegroundColor Green
    Write-Host "   [2] Check for updates and update selectively" -ForegroundColor Green
    Write-Host ""
    Write-Host "   ── APP SCANNER & INSTALLER ──────────────────────────────────" -ForegroundColor DarkGray
    Write-Host "   [3] Show available apps list (79 apps)" -ForegroundColor Cyan
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
# INITIAL SYSTEM INFO DISPLAY (Once at startup)
#===============================================================================
Show-Signature
Show-SystemInfo
Write-Host ""
Write-Host "Press any key to continue to main menu..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

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
                foreach ($n in ($raw -split ",")) { 
                    $n = $n.Trim()
                    if ($n -match "^\d+$") { $nums += [int]$n }
                }
                if ($nums.Count -gt 0) { Install-ByNumbers -Numbers $nums }
                else { Write-Host "No valid numbers!" -ForegroundColor Red }
                Read-Host "`nPress Enter to continue"
            }
        }
        "6" { Run-IDMActivation }
        "7" {
            Clear-Host
            Show-Signature
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
