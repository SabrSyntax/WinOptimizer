@echo off
title 🚀 Windows CPU & Performance Optimizer - by Gumnaami
color 0a
echo =====================================================
echo       OPTIMIZING WINDOWS PERFORMANCE (SAFE MODE)
echo =====================================================
echo.

:: Require admin permission
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ⚠️ Please run this file as Administrator.
    pause
    exit /b
)

:: Step 1: Stop unnecessary services safely
echo [1/6] Disabling unnecessary background services...
for %%S in (
    SysMain
    DiagTrack
    WSearch
    MapsBroker
    RetailDemo
) do (
    sc stop %%S >nul 2>&1
    sc config %%S start= disabled >nul 2>&1
)
echo ✅ Services optimized.

:: Step 2: Set power plan to High Performance
echo [2/6] Setting Power Plan to High Performance...
powercfg -setactive SCHEME_MIN >nul
echo ✅ Done.

:: Step 3: Clear temporary files
echo [3/6] Cleaning temporary files...
del /f /s /q "%temp%\*" >nul 2>&1
del /f /s /q "C:\Windows\Temp\*" >nul 2>&1
echo ✅ Temporary files cleared.

:: Step 4: Flush DNS & cache
echo [4/6] Flushing DNS and cache...
ipconfig /flushdns >nul
echo ✅ DNS cache cleared.

:: Step 5: Optional registry optimizations (safe)
echo [5/6] Applying registry performance tweaks...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /t REG_DWORD /d 0 /f >nul
echo ✅ Registry tweaks applied.

:: Step 6: Finish
echo [6/6] Optimization Complete!
echo =====================================================
echo ✅ Your system is now optimized for performance.
echo 💡 Restart your PC to apply all changes.
echo =====================================================

echo.
choice /m "Do you want to restart now?"
if errorlevel 1 shutdown /r /t 5

exit
