@echo off

set app=gta5
set load=
set loadnum=1
set installspeed=2

SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do     rem"') do (
  set "DEL=%%a"
)

IF EXIST %appdata%\PSTools\ goto suspend

cd %appdata%
mkdir PSTools
cd PSTools
curl -o PSTools.zip https://download.sysinternals.com/files/PSTools.zip
tar -xf PSTools.zip
del PSTools.zip
cd %~dp0
SET "PATH=%appdata%\PSTools\;%PATH%"
pslist
pssuspend
call :colorEcho 0a "Installation completed"
echo.
pause
cls


:suspend
SET "PATH=%appdata%\PSTools\;%PATH%"
pslist %app% > NUL
IF ERRORLEVEL 1 goto suspenderror
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
set load=%load%���
cls
echo.
echo.
echo.
echo  SUSPENDED
echo ������������������������������ͻ
echo  %load%
echo ������������������������������ͼ
ping localhost -n %installspeed% >nul
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
echo ������������������������������ͻ
echo  ������������������������������
echo ������������������������������ͼ
echo.
ping localhost -n 4 >nul
cls
exit

:colorEcho
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1i