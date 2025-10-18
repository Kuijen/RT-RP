REM Kills Virtual Desktop when the script starts or resets
:start
@echo off
 tasklist >NUL | findstr "Virtual Desktop Streamer" 
 taskkill >NUL /F /IM VirtualDesktop.Streamer.exe
 cls
)
REM Displays the Logo
 @echo on
 @echo Repack By KUIJEN - Gnirehtet By Genymobile - Java By Oracle - ADB By Google
 @echo[
 @echo[
 @echo[
 @echo off & Title RT-RP V2.6.0
 echo/  /$$$$$$$  /$$$$$$$$      /$$$$$$$  /$$$$$$$ 
 echo/ ^| $$__  $$^|__  $$__/     ^| $$__  $$^| $$__  $$
 echo/ ^| $$  \ $$   ^| $$        ^| $$  \ $$^| $$  \ $$
 echo/ ^| $$$$$$$/   ^| $$ /$$$$$$^| $$$$$$$/^| $$$$$$$/
 echo/ ^| $$__  $$   ^| $$^|______/^| $$__  $$^| $$____/ 
 echo/ ^| $$  \ $$   ^| $$        ^| $$  \ $$^| $$      
 echo/ ^| $$  ^| $$   ^| $$        ^| $$  ^| $$^| $$      
 echo/ ^|__/  ^|__/   ^|__/ V2.6.0 ^|__/  ^|__/^|__/      
 echo/                                        
 echo/                        
 echo/                                              
 echo/ 
 echo/ 
 @echo off
)

setlocal enabledelayedexpansion

REM Defines the Backup Config location as "cfgbk"
set "cfgbk=Text Files\Backup Config.txt"

REM Defines the Config file location as "config"
set "config=%userprofile%\Documents\RT-RP Config.ini"

REM Checks if the config file exists and puts it in it's correct place if it isn't
if not exist "%config%" (
    copy >NUL "%cfgbk%" "%config%"
    echo [4;43;30mConfig File Not Found, Copied New Config To Documents.[0m
    echo.
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


IF not EXIST "%steamvrpath%" (
 echo SteamVR Is [33mNot[0m Installed!
)


REM Check if vrmonitor.exe (SteamVR) is running
tasklist /FI "IMAGENAME eq vrmonitor.exe" 2>NUL | find /I "vrmonitor.exe" >NUL
IF %ERRORLEVEL% EQU 0 (
    echo SteamVR is [92mAlready Running![0m
    goto :res1

)

REM Check if SteamVR should launch
if "%Launch_SteamVR%"=="1" (
    REM Check if vrmonitor.exe exists at the specified path
    IF EXIST "%steamvrpath%" (
        start "" "%steamvrpath%"
        echo SteamVR [92mStarted![0m
    ) ELSE (
        (echo SteamVR Was [33mNot[0m Found!) && pause & rundll32 url.dll,FileProtocolHandler https://store.steampowered.com/app/250820/SteamVR/
    )
) ELSE (
    goto :res1
)

:res1

REM Define the path to check for Amethyst.exe
set "amethystPath=%Amethyst%"

REM Check if Amethyst.exe is running
tasklist /FI "IMAGENAME eq Amethyst.exe" 2>NUL | find /I "Amethyst.exe" >NUL
IF %ERRORLEVEL% EQU 0 (
    echo Amethyst is [92mAlready Running![0m
    goto :res2
)

REM Check if Amethyst should launch
if "%Launch_Amethyst%"=="1" (
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
set "slimevrPath=%SlimeVR%"

REM Check if slimevr.exe is running
tasklist /FI "IMAGENAME eq slimevr.exe" 2>NUL | find /I "slimevr.exe" >NUL
IF %ERRORLEVEL% EQU 0 (
    echo SlimeVR Server is [92mAlready Running![0m
    goto :res3
)

REM Check if SlimeVR should launch
if "%Launch_SlimeVR%"=="1" (
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
set "VRCFTPath=%VRCFT%"

REM Check if VRCFaceTracking.exe is running
tasklist /FI "IMAGENAME eq VRCFaceTracking.exe" 2>NUL | find /I "VRCFaceTracking.exe" >NUL
IF %ERRORLEVEL% EQU 0 (
    echo VRCFT is [92mAlready Running![0m
    goto :res4
)

REM Check if VRCFT should launch
if "%Launch_VRCFT%"=="1" (
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
set "VDPath=%Virtual_Desktop%"

REM Check if VirtualDesktop.Streamer.exe is running
tasklist /FI "IMAGENAME eq VirtualDesktop.Streamer.exe" 2>NUL | find /I "VirtualDesktop.Streamer.exe" >NUL
IF %ERRORLEVEL% EQU 0 (
    echo Virtual Desktop Streamer is [92mAlready Running![0m
    goto :res5
)

REM Check if Virtual Desktop should launch
if "%Launch_Virtual_Desktop%"=="1" (
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

REM Define the path to check for VHConsole.exe (Vive Hub)
set "VIVEpath=%Vive_Hub%"

REM Check if VHConsole.exe is running
tasklist /FI "IMAGENAME eq VHConsole.exe" 2>NUL | find /I "VHConsole.exe" >NUL
IF %ERRORLEVEL% EQU 0 (
    echo Vive Hub is [92mAlready Running![0m
    goto :res6
)

REM Check if Vive Hub should launch
if "%Launch_VIVE_HUB%"=="1" (
    REM Check if VHConsole.exe exists at the specified path
    IF EXIST "%VIVEpath%" (
        start "" "%VIVEpath%"
        echo Vive Hub [92mStarted![0m
    ) ELSE (
        echo Vive Hub Was [33mNot[0m Found!
    )
) ELSE (
    goto :res6
)

:res6

REM Define the path to check for ALVR Dashboard.exe
set "ALVRpath=%ALVR%"

REM Check if ALVR Dashboard.exe is running
tasklist /FI "IMAGENAME eq ALVR Dashboard.exe" 2>NUL | find /I "ALVR Dashboard.exe" >NUL
IF %ERRORLEVEL% EQU 0 (
    echo ALVR is [92mAlready Running![0m
    goto :res7
)

REM Check if ALVR should launch
if "%Launch_ALVR%"=="1" (
    REM Check if ALVR Dashboard.exe exists at the specified path
    IF EXIST "%ALVRpath%" (
        start "" "%ALVRpath%"
        echo ALVR [92mStarted![0m
    ) ELSE (
        echo ALVR Was [33mNot[0m Found!
    )
) ELSE (
    goto :res7
)

:res7

REM Define the path to check for VRCX.exe
set "VRCXpath=%VRCX%"

REM Check if VRCX.exe is running
tasklist /FI "IMAGENAME eq VRCX.exe" 2>NUL | find /I "VRCX.exe" >NUL
if %ERRORLEVEL% EQU 0 (
    echo VRCX is [92mAlready Running![0m
    goto :res8
)

REM Check if VRCX should launch
if "%Launch_VRCX%"=="1" (
    REM Check if VRCX.exe exists at the specified path
    if exist "%VRCXpath%" (
        start "" "%VRCXpath%"
        echo VRCX [92mStarted![0m
    ) else (
        echo VRCX Was [33mNot[0m Found!
    )
) else (
    goto :res8
)

:res8


::if "%Launch_APP1%"=="1" 
::    if defined APP1_path (
::    if exist "!APP1_path!" (
::        start "" "!APP1_path!"
::            echo !APP1! started
::        ) else (
::              echo no !APP1! found )
::                ) else ( echo no path specified !APP1!
::)

REM Custom app launch stuff
::if "!Launch_APP1!"=="1" (
:    if defined APP1_path (
:        if exist "!APP1_path!" (
:            start "" "!APP1_path!"
:            echo !APP1! started
:        ) else (
:            echo No !APP1! found
:        )
:    ) else (
:        echo !APP1! not installed
:    )
::)




REM Custom app launch stuff
if "!Launch_APP1!"=="1" (
        if exist "!APP1_path!" (
            start "" "!APP1_path!"
            echo !APP1! [92mStarted![0m
        ) else (
            echo !APP1! Was [33mNot[0m Found!
        )
)

echo.
echo.

REM Starts gnirehtet, the program responsible for the reverse tether.
gnirehtet.exe start > NUL

REM Checks if High priority is set to true or false and responds accordingly.
if "%High_Prioriority%"=="1" start /MIN "" "High Priority.CMD" && echo Launching In [4;33mHigh[0m Priority!

REM Throws an error if gnirehtet fails to run and prompts the user to reset the script and plays the error sound
if errorlevel 1 (
 if %Enable_Sound%==1 (
    start "" "cmdmp3win.exe" "STM\error.mp3")
 echo [4;91mPlease connect your headset and restart RT-RP[0m
 echo Press Any Key To Restart. . .
 pause >nul
 cls
 goto :start
)

REM Plays sound on RT start when set to true in config
if %Enable_Sound%==1 (
 start "" "cmdmp3win.exe" "STM\start.mp3"
)

REM Launches steam link on the headset
:: Couldn't get it running properly due to steam link complaining about not being on local network, to enable paste "Launch_Steam_Link_Client=true" in conf.
if %Launch_Steam_Link_Client%==1 (
 start "" adb.exe shell monkey -p com.valvesoftware.steamlinkvr -c android.intent.category.LAUNCHER 1

)

REM Launches the Virtual Desktop client on the headset.
if %Launch_VD_Client%==1 (
    start "" adb.exe shell monkey -p VirtualDesktop.Android -c android.intent.category.LAUNCHER 1
)

echo [4;92mRT Started Successfully!![0m

@java -jar gnirehtet.jar relay > NUL 2>&1

echo [1;97;41mAnother Instance of RT-RP Is Already Running!!![0m

:: START.cmd Copyright 2025 by KUIJEN is licensed under GNU General Public Licence Version 3.0 https://www.gnu.org/licenses/gpl-3.0.txt

::                          *@@@@@@@@@@#######@@@@@@@@@@                          
::                     %@@@@@                          ,@@@@@(                    
::                 @@@@&                                     @@@@.                
::              @@@@                                            ,@@@%             
::           ,@@@                                                   @@@           
::         &@@                                                        @@@.        
::       %@@.                                                           @@@       
::      @@@      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                    @@@     
::     @@       @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                   %@@    
::   ,@@        #@@@@@@@@@@@@@@@@@@    &@@@@@@@@@@@@@@@@&                   .@@   
::  /@@           @@@@@@@@@@@@@@/      @@@@@@@@@@@@@@@@@@%                   ,@@  
::  @@                               #@@@@@@@@@@@@@@@@@@@@/                   @@@ 
:: %@%                              @@@@@@@@@@@@@@@@@@@@@@@,                   @@ 
:: @@                              @@@@@@@      @@@@@@@@@@@@                   %@@
:: @@                            @@@@@@@@@@      @@@@@@@@@@@@                   @@
:: @@                           @@@@@@@@@@@        @@@@@@@@@@@                  @@
:: @@                         *@@@@@@@@@@@          &@@@@@@@@@@                 @@
:: @@                        @@@@@@@#                 @@@@@@@@@@               %@@
:: %@@                      @@@@@@&                    #@@@@@@@@@              @@ 
::  @@                    @@@@@@,                        @@@@@@@@%            @@@ 
::   @@                  @@@@@.                           @@@@@@@@&          ,@@  
::   ,@@                                                    @@@@@@@,        /@@   
::     @@/                                                   (@@@@@@       @@@    
::      @@@                                                    @@@@@      @@/     
::       .@@#                                                           @@@       
::         .@@@                                                       @@@         
::            @@@                                                  %@@@           
::              %@@@,                                           %@@@,             
::                  @@@@                                    /@@@@                 
::                      @@@@@&                        ,@@@@@&                     
::                           *@@@@@@@@@@@@@@@@@@@@@@@@@*                          
 