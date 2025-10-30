@echo off

sc start SharedAccess
timeout /t 3 /nobreak >nul
cls
sc query SharedAccess
echo.
timeout /t 10 