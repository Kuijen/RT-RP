@Echo off

echo [4;43;30mRT-RP Child process, no worries it's not a virus![0m

REM Waits a bit before executing commands in order to make sure that everything is properly launched.
TIMEOUT /T 3 /nobreak

REM Sets the process priority of Java and ADB to high
powershell "Get-Process java | ForEach-Object { $_.PriorityClass = 'High' }"
powershell "Get-Process adb | ForEach-Object { $_.PriorityClass = 'High' }"

exit