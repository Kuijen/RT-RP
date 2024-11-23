REM Kills Virtual Desktop when the script starts or resets
:start
@echo off
 tasklist | findstr "Virtual Desktop Streamer" 
 taskkill /F /IM VirtualDesktop.Streamer.exe
 cls
)
REM Displays the Logo
 @echo on
 @echo Repack By KUIJEN - Gnirehtet By Genymobile - Java By Oracle - ADB By Google
 @echo[
 @echo[
 @echo[
 @echo off & Title RT-RP V2.5 Beta 3
 echo/  /$$$$$$$  /$$$$$$$$      /$$$$$$$  /$$$$$$$ 
 echo/ ^| $$__  $$^|__  $$__/     ^| $$__  $$^| $$__  $$
 echo/ ^| $$  \ $$   ^| $$        ^| $$  \ $$^| $$  \ $$
 echo/ ^| $$$$$$$/   ^| $$ /$$$$$$^| $$$$$$$/^| $$$$$$$/
 echo/ ^| $$__  $$   ^| $$^|______/^| $$__  $$^| $$____/ 
 echo/ ^| $$  \ $$   ^| $$        ^| $$  \ $$^| $$      
 echo/ ^| $$  ^| $$   ^| $$        ^| $$  ^| $$^| $$      
 echo/ ^|__/  ^|__/   ^|__/  V2.5  ^|__/  ^|__/^|__/      
 echo/                                              
 echo/          Copyright 2024 By KUIJEN                                            
 echo/                                              
 echo/ 
 echo/ 
 @echo off
)

set "config=config.txt"

REM Checks if the config file exists
if not exist "%config%" (
    echo Confic file not found: %config%
    pause
)

REM Reads and processes each line in config.txt
for /f "usebackq tokens=1,2 delims==" %%A in ("%config%") do (
    REM Convert true/false to 1/0
    if /i "%%B"=="true" (
        set "%%A=1"
    ) else if /i "%%B"=="false" (
        set "%%A=0"
    ) else (
        set "%%A=%%B"
    )
)



REM Define the path to check for vrmonitor.exe (SteamVR)
set "steamvrpath=C:\Program Files (x86)\Steam\steamapps\common\SteamVR\bin\win64\vrmonitor.exe"

REM Check if vrmonitor.exe (SteamVR) is running
tasklist /FI "IMAGENAME eq vrmonitor.exe" 2>NUL | find /I "vrmonitor.exe" >NUL
IF %ERRORLEVEL% EQU 0 (
    echo SteamVR is [92mAlready Running![0m
    goto :res1
)

REM Check if SteamVR should launch
if "%LaunchSteamVR%"=="1" (
    REM Check if vrmonitor.exe exists at the specified path
    IF EXIST "%steamvrpath%" (
        start "" "%steamvrpath%"
        echo SteamVR [92mStarted![0m
    ) ELSE (
        (echo SteamVR Was [33mNot[0m Found!) && pause & rundll32 url.dll,FileProtocolHandler https://store.steampowered.com/app/250820/SteamVR/ & exit
    )
) ELSE (
    goto :res1
)

:res1

REM Define the path to check for Amethyst.exe
set "amethystPath=C:\Program Files\WindowsApps\11835K2VRTeam.Amethyst-OpenSourceBodyTracking_1.2.14.0_x64__g2vc4cfdbyb66\Amethyst.exe"

REM Check if Amethyst.exe is running
tasklist /FI "IMAGENAME eq Amethyst.exe" 2>NUL | find /I "Amethyst.exe" >NUL
IF %ERRORLEVEL% EQU 0 (
    echo Amethyst is [92mAlready Running![0m
    goto :res2
)

REM Check if Amethyst should launch
if "%LaunchAmethyst%"=="1" (
    REM Check if Amethyst.exe exists at the specified path
    IF EXIST "%amethystPath%" (
        start "" "%amethystPath%"
        echo Amethyst [92mStarted![0m
    ) ELSE (
        echo Amethyst Was [33mNot[0m Found!
    )
) ELSE (
    goto :res2
)

:res2

REM Define the path to check for slimevr.exe
set "slimevrPath=C:\Program Files (x86)\SlimeVR Server\slimevr.exe"

REM Check if slimevr.exe is running
tasklist /FI "IMAGENAME eq slimevr.exe" 2>NUL | find /I "slimevr.exe" >NUL
IF %ERRORLEVEL% EQU 0 (
    echo SlimeVR Server is [92mAlready Running![0m
    goto :res3
)

REM Check if SlimeVR should launch
if "%LaunchSlimeVR%"=="1" (
    REM Check if slimevr.exe exists at the specified path
    IF EXIST "%slimevrPath%" (
        start "" "%slimevrPath%"
        echo SlimeVR Server [92mStarted![0m
    ) ELSE (
        echo SlimeVR Server Was [33mNot[0m Found!
    )
) ELSE (
    goto :res3
)

:res3

REM Define the path to check for VRCFaceTracking.exe
set "VRCFTPath=C:\Program Files\WindowsApps\96ba052f-0948-44d8-86c4-a0212e4ae047_5.2.3.0_x64__4s4k90pjvq32p\VRCFaceTracking.exe"

REM Check if VRCFaceTracking.exe is running
tasklist /FI "IMAGENAME eq VRCFaceTracking.exe" 2>NUL | find /I "VRCFaceTracking.exe" >NUL
IF %ERRORLEVEL% EQU 0 (
    echo VRCFT is [92mAlready Running![0m
    goto :res4
)

REM Check if VRCFT should launch
if "%LaunchVRCFT%"=="1" (
    REM Check if VRCFaceTracking.exe exists at the specified path
    IF EXIST "%VRCFTPath%" (
        start "" "%VRCFTPath%"
        echo VRCFT [92mStarted![0m
    ) ELSE (
        echo VRCFT Was [33mNot[0m Found!
    )
) ELSE (
    goto :res4
)

:res4

REM Define the path to check for VirtualDesktop.Streamer.exe
set "VDPath=C:\Program Files\Virtual Desktop Streamer\VirtualDesktop.Streamer.exe"

REM Check if VirtualDesktop.Streamer.exe is running
tasklist /FI "IMAGENAME eq VirtualDesktop.Streamer.exe" 2>NUL | find /I "VirtualDesktop.Streamer.exe" >NUL
IF %ERRORLEVEL% EQU 0 (
    echo Virtual Desktop Streamer is [92mAlready Running![0m
    goto :res5
)

REM Check if Virtual Desktop should launch
if "%LaunchVirtualDesktop%"=="1" (
    REM Check if VirtualDesktop.Streamer.exe exists at the specified path
    IF EXIST "%VDPath%" (
        start "" "%VDPath%"
        echo Virtual Desktop Streamer [92mStarted![0m
    ) ELSE (
        echo Virtual Desktop Streamer Was [33mNot[0m Found!
    )
) ELSE (
    goto :res5
)

:res5

REM Define the path to check for ALVR Dashboard.exe
REM MAKE PATH CONFIGURABLE IN CONFIG FILE!!! User should put file path here for now.
set "ALVRPath="

REM Check if ALVR Dashboard.exe is running
tasklist /FI "IMAGENAME eq ALVR Dashboard.exe" 2>NUL | find /I "ALVR Dashboard" >NUL
IF %ERRORLEVEL% EQU 0 (
    echo alvr is [92mAlready Running![0m
    goto :res6
)

REM Check if ALVR should launch
if "%LaunchALVR%"=="1" (
    REM Check if ALVR Dashboard.exe exists at the specified path
    IF EXIST "%ALVRPath%" (
        start "" "%ALVRPath%"
        echo ALVR [92mStarted![0m
    ) ELSE (
        echo ALVR Was [33mNot[0m Found!
    )
) ELSE (
    goto :res6
)

:res6

@echo[
@echo[

REM Starts gnirehtet, the program responsible for the reverse tether.
gnirehtet.exe start
@echo off 

REM Throws an error if gnirehtet fails to run and prompts the user to reset the script
if errorlevel 1 (echo [4;91mPlease connect your headset and restart RT-RP[0m) & (echo Press Any Key To Restart. . .) & start "" "%~dp0cmdmp3win.exe" "%~dp0\stm\error.mp3" & pause >nul & cls && goto :start

start "" "%~dp0cmdmp3win.exe" "%~dp0\stm\start.mp3"

@java -jar gnirehtet.jar relay
@pause


:: START.cmd Copyright 2024 by KUIJEN is licensed under GNU General Public Licence Version 3.0 https://www.gnu.org/licenses/gpl-3.0.txt