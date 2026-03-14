@echo off
Title RT-RP V2.6.0
powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0START.ps1"
if %errorlevel% neq 0 pause
