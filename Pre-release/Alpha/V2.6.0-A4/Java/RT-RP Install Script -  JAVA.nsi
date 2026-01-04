; RTRP
;
; This script is based on example1.nsi but it remembers the directory, 
; has uninstall support and (optionally) installs start menu shortcuts.
;
; It will install RTRP into a directory that the user selects.
;
; See install-shared.nsi for a more robust way of checking for administrator rights.
; See install-per-user.nsi for a file association example.

;--------------------------------

; The name of the installer
Name "Reverse Tethering RePack"

; The file to write
OutFile "C:\Users\$PROFILE\Desktop\RT-RP Installer (Java).exe"

; Request application privileges for Windows Vista and higher
RequestExecutionLevel admin

; Build Unicode installer
Unicode True

; The default installation directory
InstallDir $PROGRAMFILES\RTRP

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\RTRP" "Install_Dir"

;--------------------------------

; Pages

Page components
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

;--------------------------------

; The stuff to install
Section "Java Runtime & Core Files (required)"

  SectionIn RO
  
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  
  File /r "C:\Users\KUIJEN\Desktop\Source\"
  
  Execwait "$INSTDIR\Support\Java Runtime Installer.exe"
  
  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\RTRP "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\RTRP" "DisplayName" "RT-RP"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\RTRP" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\RTRP" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\RTRP" "NoRepair" 1
  WriteUninstaller "$INSTDIR\uninstall.exe"
  
SectionEnd

; Optional section (can be disabled by the user)
Section "Start Menu Shortcuts"

  CreateDirectory "$SMPROGRAMS\RTRP"
  CreateShortcut "$SMPROGRAMS\RTRP\Uninstall RT-RP.lnk" "$INSTDIR\uninstall.exe"
  CreateShortcut "$SMPROGRAMS\RTRP\RT-RP.lnk" "$INSTDIR\START.cmd"

SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"

 ExecWait 'taskkill /F /IM adb.exe'

  ; Safety check: Don't allow empty or root INSTDIR
  StrCmp $INSTDIR "" done
  StrCmp $INSTDIR "$PROGRAMFILES" done
  StrCmp $INSTDIR "$PROGRAMFILES64" done
  StrCmp $INSTDIR "$PROGRAMFILES32" done

  ; Remove registry keys (ignore errors if they don’t exist)
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\RTRP"
  DeleteRegKey HKLM "Software\RTRP"

  ; Remove shortcuts, if they exist
  Delete "$DESKTOP\RT-RP.lnk"
  Delete "$SMPROGRAMS\RTRP\*.lnk"

  ; Remove folders
  RMDir /r "$SMPROGRAMS\RTRP"
  RMDir /r "$INSTDIR"

done:
SectionEnd


Section "Desktop Shortcut" SectionX
    SetShellVarContext current
    CreateShortCut "$DESKTOP\RT-RP.lnk" "$INSTDIR\START.cmd"

SectionEnd

Function .onInstSuccess
    IfFileExists "$INSTDIR\Text Files\README.txt" openReadMe
    

    ; Delete regardless of whether readme exists or not
    Delete "$DOCUMENTS\RT-RP Config.txt"
    Return

openReadMe:
    ExecShell "open" "$INSTDIR\Text Files\README.txt"
    Delete "$DOCUMENTS\RT-RP Config.txt"
    Delete "$DOCUMENTS\RT-RP Config.ini"
    Return
FunctionEnd
