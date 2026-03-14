# RT-RP V2.6.0 - START.ps1 (Rust Edition)
# Repack By KUIJEN - Gnirehtet By Genymobile - Java By Oracle - ADB By Google

$ErrorActionPreference = 'SilentlyContinue'
$host.UI.RawUI.WindowTitle = 'RT-RP V2.6.0'

# ---- Paths ----
$scriptDir  = Split-Path -Parent $MyInvocation.MyCommand.Path
$cfgBk      = Join-Path $scriptDir "Text Files\Backup Config.txt"
$configPath = "$env:USERPROFILE\Documents\RT-RP Config.ini"
$logDir     = "$env:APPDATA\rtrp"
$logFile    = "$logDir\debug.log"
$adb        = Join-Path $scriptDir "adb.exe"
$gni        = Join-Path $scriptDir "gnirehtet-g7.exe"
$mp3        = Join-Path $scriptDir "cmdmp3win.exe"

if (-not (Test-Path $logDir)) { New-Item -ItemType Directory -Path $logDir | Out-Null }

# ---- Log / display helpers ----
function Log  { param($m) Add-Content $logFile "[DBG] $(Get-Date -f HH:mm:ss) $m" }
function LErr { param($m) Write-Host $m -ForegroundColor Red;    Add-Content $logFile "ERR  $(Get-Date -f HH:mm:ss) $m" }
function LWrn { param($m) Write-Host $m -ForegroundColor Yellow; Add-Content $logFile "WARN $(Get-Date -f HH:mm:ss) $m" }

function Write-NotFound { param($name)
    Write-Host "$name Was " -NoNewline
    Write-Host "Not" -ForegroundColor Yellow -NoNewline
    Write-Host " Found!"
}

# ---- Config reader ----
function Read-Config {
    param($path)
    $out = @{}
    if (-not (Test-Path $path)) { return $out }
    foreach ($line in Get-Content $path) {
        if ($line -match '^\s*([^=\s#;]+)\s*=\s*(.+)$') {
            $k = $matches[1].Trim()
            $v = $matches[2].Trim()
            if     ($v -ieq 'true')  { $out[$k] = $true  }
            elseif ($v -ieq 'false') { $out[$k] = $false }
            else                     { $out[$k] = $v     }
        }
    }
    return $out
}

function G { param($key, $default = $false) if ($cfg.ContainsKey($key)) { $cfg[$key] } else { $default } }

# ---- App launcher ----
function Launch-App {
    param($name, $path)
    if (-not $path) {
        Write-NotFound $name
        Log "$name - path not configured"
        return
    }
    $procName = [System.IO.Path]::GetFileNameWithoutExtension($path)
    if (Get-Process -Name $procName -EA SilentlyContinue) {
        Write-Host "$name is " -NoNewline
        Write-Host "Already Running!" -ForegroundColor Green
        return
    }
    if (Test-Path $path) {
        Start-Process $path
        Write-Host "$name " -NoNewline
        Write-Host "Started!" -ForegroundColor Green
        Log "$name started: $path"
    } else {
        Write-NotFound $name
        Log "$name Was Not Found - path: $path"
    }
}

# ---- Main loop (restarts on gnirehtet failure) ----
$restart = $true
while ($restart) {
    $restart = $false

    Stop-Process -Name "VirtualDesktop.Streamer" -Force -EA SilentlyContinue

    # Logo
    Clear-Host
    Write-Host "Repack By KUIJEN - Gnirehtet By Genymobile - Java By Oracle - ADB By Google"
    Write-Host ""
    Write-Host '  /$$$$$$$  /$$$$$$$$      /$$$$$$$  /$$$$$$$'
    Write-Host ' | $$__  $$|__  $$__/     | $$__  $$| $$__  $$'
    Write-Host ' | $$  \ $$   | $$        | $$  \ $$| $$  \ $$'
    Write-Host ' | $$$$$$$/   | $$ /$$$$$$| $$$$$$$/| $$$$$$$/`'
    Write-Host ' | $$__  $$   | $$|______/| $$__  $$| $$____/'
    Write-Host ' | $$  \ $$   | $$        | $$  \ $$| $$'
    Write-Host ' | $$  | $$   | $$        | $$  | $$| $$'
    Write-Host ' |__/  |__/   |__/ V2.6.0 |__/  |__/|__/'
    Write-Host ''
    Write-Host '               RUST EDITION'
    Write-Host ''
    Write-Host ''

    # New log session
    "=== RT-RP session $(Get-Date) ===" | Set-Content $logFile

    # ---- Config ----
    Log "scriptDir  : $scriptDir"
    Log "configPath : $configPath"
    Log "cfgBk      : $cfgBk"

    if (-not (Test-Path $configPath)) {
        if (-not (Test-Path $cfgBk)) {
            LErr "Config not found and backup is missing."
            LErr "Looked for backup at: $cfgBk"
            LErr "Is the script in the right folder?"
        } else {
            try {
                Copy-Item $cfgBk $configPath -ErrorAction Stop
                Write-Host "Config not found - copied fresh config to Documents." -ForegroundColor Black -BackgroundColor Yellow
                Log "Config copied from backup."
            } catch {
                LErr "Config copy failed: $_"
            }
        }
        Write-Host ""
    } else {
        Log "Config found OK."
    }

    $cfg = Read-Config $configPath
    Log "Config loaded - Enable_RT=$(G 'Enable_RT') Enable_ICS=$(G 'Enable_ICS') Enable_Sound=$(G 'Enable_Sound')"
    Log "Launch_Virtual_Desktop=$(G 'Launch_Virtual_Desktop') Virtual_Desktop=$(G 'Virtual_Desktop')"
    Log "Launch_VD_Client=$(G 'Launch_VD_Client') High_Prioriority=$(G 'High_Prioriority')"

    # ---- USB Selective Suspend ----
    Log "Disabling USB Selective Suspend..."
    $usbGuid   = '2a737441-1930-4402-8d77-b2bebba308a3'
    $usbSsGuid = '48e6b7a6-50f5-4782-a5d4-53bb8f07e226'
    & powercfg /SETACVALUEINDEX SCHEME_CURRENT $usbGuid $usbSsGuid 0 2>&1 | Out-Null
    & powercfg /SETDCVALUEINDEX SCHEME_CURRENT $usbGuid $usbSsGuid 0 2>&1 | Out-Null
    & powercfg /SETACTIVE SCHEME_CURRENT 2>&1 | Out-Null
    if ($LASTEXITCODE -eq 0) {
        Log "USB Selective Suspend disabled OK."
    } else {
        Log "USB Selective Suspend: powercfg returned $LASTEXITCODE (may need admin rights)"
        LWrn "USB Selective Suspend: could not disable - try running as admin"
    }

    # ---- ADB ----
    if (-not (Test-Path $adb)) {
        LErr "adb.exe not found in $scriptDir"
    } else {
        Log "ADB version:`n$(& $adb version 2>&1 | Out-String)"
        $devOut = & $adb devices 2>&1 | Out-String
        Log "ADB devices:`n$devOut"

        if ($devOut -match 'unauthorized') {
            LWrn "ADB: device unauthorized - tap Allow USB Debugging on the headset."
        }
        if ($devOut -match '\boffline\b') {
            LWrn "ADB: device offline - try replugging the USB cable."
        }

        # USB speed check - 480=USB2 (bad), 5000=USB3 (good)
        $usbSpeeds = & $adb shell "cat /sys/bus/usb/devices/*/speed 2>/dev/null" 2>&1
        $maxSpeed  = ($usbSpeeds | Where-Object { $_ -match '^\d+$' } | ForEach-Object { [int]$_ } | Measure-Object -Maximum).Maximum
        Log "USB connection speed: $maxSpeed Mbps (480=USB2, 5000=USB3)"
        if ($maxSpeed -and $maxSpeed -le 480) {
            LWrn "USB 2.0 detected ($maxSpeed Mbps) - connect to a USB 3.0 port for best tether performance."
        }

        $wifiOn = (& $adb shell settings get global wifi_on 2>&1).Trim()
        Log "Headset WiFi state: $wifiOn (1=on, 0=off)"
        if ($wifiOn -eq '1') {
            $wifiResult = & $adb shell svc wifi disable 2>&1
            Log "Headset WiFi was ON - disabled. Result: $wifiResult"
        }

        Log "Headset IP routes:`n$(& $adb shell ip route 2>&1 | Out-String)"
        Log "Headset interfaces:`n$(& $adb shell ip link show 2>&1 | Out-String)"
        Log "Headset DNS: $(& $adb shell getprop net.dns1 2>&1) / $(& $adb shell getprop net.dns2 2>&1)"
    }

    Write-Host ""

    # ---- SteamVR ----
    $steamvrPath = 'C:\Program Files (x86)\Steam\steamapps\common\SteamVR\bin\win64\vrmonitor.exe'
    if (-not (Test-Path $steamvrPath)) {
        Write-Host "SteamVR Is " -NoNewline
        Write-Host "Not" -ForegroundColor Yellow -NoNewline
        Write-Host " Installed!"
    }
    if (G 'Launch_SteamVR') {
        if (Get-Process vrmonitor -EA SilentlyContinue) {
            Write-Host "SteamVR is " -NoNewline
            Write-Host "Already Running!" -ForegroundColor Green
        } elseif (Test-Path $steamvrPath) {
            Start-Process $steamvrPath
            Write-Host "SteamVR " -NoNewline
            Write-Host "Started!" -ForegroundColor Green
        } else {
            Write-NotFound "SteamVR"
            Start-Process "https://store.steampowered.com/app/250820/SteamVR/"
        }
    }

    # ---- Apps ----
    if (G 'Launch_Amethyst') { Launch-App "Amethyst"      (G 'Amethyst') }
    if (G 'Launch_SlimeVR')  { Launch-App "SlimeVR Server" (G 'SlimeVR') }
    if (G 'Launch_VRCFT')    { Launch-App "VRCFT"          (G 'VRCFT')   }

    # Virtual Desktop - process name has a dot so handled separately
    $vdPath = G 'Virtual_Desktop'
    Log "VD Streamer path: $vdPath"
    if (G 'Launch_Virtual_Desktop') {
        if (Get-Process "VirtualDesktop.Streamer" -EA SilentlyContinue) {
            Write-Host "Virtual Desktop Streamer is " -NoNewline
            Write-Host "Already Running!" -ForegroundColor Green
        } elseif (-not $vdPath) {
            LErr "Virtual_Desktop path is empty in config."
        } elseif (Test-Path $vdPath) {
            Start-Process $vdPath
            Write-Host "Virtual Desktop Streamer " -NoNewline
            Write-Host "Started!" -ForegroundColor Green
            Log "VD Streamer started: $vdPath"
        } else {
            Write-NotFound "Virtual Desktop Streamer"
            Log "VD Streamer Not Found - path: $vdPath"
        }
    }

    if (G 'Launch_VIVE_HUB') { Launch-App "Vive Hub" (G 'Vive_Hub') }
    if (G 'Launch_ALVR')     { Launch-App "ALVR"      (G 'ALVR')     }
    if (G 'Launch_VRCX')     { Launch-App "VRCX"      (G 'VRCX')     }

    # Custom apps
    for ($i = 1; $i -le 9; $i++) {
        if (G "Launch_APP$i") {
            $appName = G "APP$i"
            $appPath = G "APP${i}_path"
            $label   = if ($appName) { $appName } else { "APP$i" }
            Launch-App $label $appPath
        }
    }

    Write-Host ""
    Write-Host ""

    # ---- Gnirehtet ----
    $gniOk = $true
    if (G 'Enable_RT') {
        Log "Gnirehtet enabled. Checking $gni..."
        if (-not (Test-Path $gni)) {
            LErr "gnirehtet-g7.exe not found in $scriptDir"
            $gniOk = $false
        } else {
            Log "Running gnirehtet start..."
            $gniOut  = & $gni start 2>&1
            $gniExit = $LASTEXITCODE
            $gniOut | ForEach-Object { Write-Host $_ }
            Log "gnirehtet start output:`n$($gniOut | Out-String)"
            Log "gnirehtet start exit: $gniExit"
            if ($gniExit -ne 0) { $gniOk = $false }
        }
    }

    # ---- High Priority ----
    if (G 'High_Prioriority') {
        $hp = Join-Path $scriptDir "High Priority.CMD"
        if (Test-Path $hp) {
            Start-Process $hp -WindowStyle Minimized
            Write-Host "Launching In " -NoNewline
            Write-Host "High" -ForegroundColor Yellow -NoNewline
            Write-Host " Priority!"
        }
    }


    # ---- VD network check ----
    if ($gniOk -and (G 'Enable_RT')) {
        $rndisLine = & $adb shell ip addr show rndis0 2>&1 | Where-Object { $_ -match 'inet ' }
        Log "rndis0: $rndisLine"
        if ($rndisLine -match 'inet\s+(\d+\.\d+\.\d+)\.\d+') {
            $headsetSubnet = $matches[1]
            $pcSubnets = Get-NetIPAddress -AddressFamily IPv4 |
                         Where-Object { $_.IPAddress -notmatch '^127\.' } |
                         ForEach-Object { $_.IPAddress -replace '\.\d+$', '' }
            Log "VD subnet check - headset: $headsetSubnet.x  PC: $($pcSubnets -join ', ').x"
            if ($pcSubnets -contains $headsetSubnet) {
                Log "VD network OK: subnet match ($headsetSubnet.x)"
            } else {
                LWrn "Virtual Desktop: subnet mismatch (headset $headsetSubnet.x vs PC). Bitrate may be capped to ~60 Mbps."
            }
        } else {
            Log "VD network check: rndis0 not found on headset"
        }
    }

    # ---- Gnirehtet failure handling ----
    if ((G 'Enable_RT') -and -not $gniOk) {
        Log "gnirehtet failed. ADB devices: $(& $adb devices 2>&1 | Out-String)"
        Log "WiFi at failure: $(& $adb shell settings get global wifi_on 2>&1)"
        Log "IP routes at failure: $(& $adb shell ip route 2>&1 | Out-String)"
        if (G 'Enable_Sound') { Start-Process $mp3 -ArgumentList "STM\error.mp3" }
        LErr "Please connect your headset and restart RT-RP"
        LErr "See $logFile for details."
        Read-Host "Press Enter to restart"
        $restart = $true
        continue
    }

    # ---- Sound ----
    if (G 'Enable_Sound') { Start-Process $mp3 -ArgumentList "STM\start.mp3" }

    # ---- ADB: Steam Link ----
    if (G 'Launch_Steam_Link_Client') {
        Log "Launching Steam Link via ADB..."
        $r = & $adb shell monkey -p com.valvesoftware.steamlinkvr -c android.intent.category.LAUNCHER 1 2>&1
        Log "ADB Steam Link result: $($r | Out-String)"
    }

    # ---- ADB: VD client ----
    if (G 'Launch_VD_Client') {
        Log "Launching VD client via ADB..."
        $r = & $adb shell monkey -p VirtualDesktop.Android -c android.intent.category.LAUNCHER 1 2>&1
        Log "ADB VD client result: $($r | Out-String)"
    }

    # ---- ICS ----
    if (G 'Enable_ICS') {
        $ics = Join-Path $scriptDir "ICS START.cmd"
        Start-Process $ics -Verb RunAs -WorkingDirectory $scriptDir
        Write-Host "ICS Started Successfully!!" -ForegroundColor Green
        Start-Sleep 4
        exit
    }

    Write-Host "RT Started Successfully!!" -ForegroundColor Green
    Write-Host "Log: $logFile"
    Add-Content $logFile "RT Started Successfully."

    # ---- Gnirehtet run (blocks - WARN/ERROR only go to log) ----
    if (G 'Enable_RT') {
        & $gni run 2>&1 | Where-Object { $_ -match '\b(WARN|ERROR)\b' } | Add-Content $logFile
        # Only reaches here if gnirehtet exits - usually means another instance was running
        Write-Host "Another Instance of RT-RP Is Already Running!!!" -ForegroundColor White -BackgroundColor Red
        Read-Host "Press Enter to exit"
        exit
    }

    # ---- RT and ICS both off - launched apps only ----
    if (-not (G 'Enable_RT') -and -not (G 'Enable_ICS')) {
        if (G 'Enable_Sound') { Start-Process $mp3 -ArgumentList "STM\start.mp3" }
        Write-Host "RT And ICS are OFF, Launching Selected Apps ONLY!!" -ForegroundColor Black -BackgroundColor Yellow
        Start-Sleep 4
        exit
    }
}
