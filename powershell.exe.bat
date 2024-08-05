@echo off
set "_args=%*"
set "_cpth=%~dp0"

:main
shift
if /i "%~0"=="Start-Process" goto sp
if not "%~1"=="" goto main
call powershell %_args%
exit /b

:sp
shift
set "_file=%~1"
if "%_file:~0,1%"=="'" if "%_file:~-1%"=="'" set "_file=%_file:~1,-1%"
call :gp "%_file%" _path
if /i "%~0"=="-FilePath" (
	for /r "%_cpth%\..\" %%d in (.) do del /q "%%d\.LooseFiles.txt" 2>nul
	call "%_file%"
	if exist "%_path%\status" echo %ERRORLEVEL% > "%_path%\status"
) else if not "%~1"=="" goto sp
exit /b

:gp
set "%2=%~dp1"
exit /b