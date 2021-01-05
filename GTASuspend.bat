@echo off

set app=gta5
set load=
set loadnum=1

setlocal EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do     rem"') do (
  set "DEL=%%a"
)

if exist %appdata%\PSTools\ goto suspend

cd %appdata%
mkdir PSTools
cd PSTools
curl -o PSTools.zip https://download.sysinternals.com/files/PSTools.zip
tar -xf PSTools.zip
del PSTools.zip
cd %~dp0
set "PATH=%appdata%\PSTools\;%PATH%"
pslist
pssuspend
call :colorEcho 0a "Installation completed"
echo.
pause
cls


:suspend
set "PATH=%appdata%\PSTools\;%PATH%"
pslist %app% > NUL
if errorlevel 1 goto suspenderror
pssuspend %app%
goto progresssuspend

:progressresume
pssuspend %app% -r
goto installcomplete

:suspenderror
cls
call :colorEcho 0c "%app% not found"
echo.
pause
exit

:progresssuspend
set load=%load%ÛÛÛ
cls
echo.
echo.
echo.
echo  SUSPENDED
echo ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo  %load%
echo ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo Press 'c' to resume process
choice /c cg /t 1 /d g /n > nul
if "%errorlevel%" == "1" goto progressresume
set/a loadnum=%loadnum% +1
if %loadnum% == 10 goto progressresume & set load=
goto progresssuspend

:installcomplete
color 0a
cls
echo.
echo.
echo.
echo  RESUMED
echo ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo  ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
echo ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
ping localhost -n 4 >nul
cls
exit

:colorEcho
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1i
