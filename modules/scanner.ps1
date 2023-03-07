function title {
    Write-Host "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" -ForegroundColor Yellow
    Write-Host "
     _ __ ___   ___   __| |_   _| | __ _ _ __   _ __ __ _| |_
    | '_ ` _ \ / _ \ / _` | | | | |/ _` | '__| | '__/ _` | __|
    | | | | | | (_) | (_| | |_| | | (_| | |    | | | (_| | |_
    |_| |_| |_|\___/ \__,_|\__,_|_|\__,_|_|    |_|  \__,_|\__|
    " -ForegroundColor Yellow
    Write-Host "
                        Module : Scanner
    " -ForegroundColor Blue
    Write-Host "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" -ForegroundColor Yellow
    Write-Host ""
 }

function menu() {
    Write-Host "v : show ps version table" -ForegroundColor Yellow
    Write-Host "e : show execution list policy" -ForegroundColor Yellow
    Write-Host "p : show process running" -ForegroundColor Yellow
    Write-Host "n : show net ip address information" -ForegroundColor Yellow
    Write-Host "f : show hot fixes" -ForegroundColor Yellow
    Write-Host "c : show command history" -ForegroundColor Yellow
    Write-Host "s : show services" -ForegroundColor Yellow
    Write-Host "j : show jobs" -ForegroundColor Yellow
    Write-Host "w : show windows defender details" -ForegroundColor Yellow
    Write-Host "q : quit" -ForegroundColor Red
    Write-Host ""
}

function ouputFile($data) {
    $answer = Read-Host "Do you want to output a file as csv?(y/n)" -ForegroundColor DarkGray
                
    if ($answer -eq "y") {
        $fileName = Read-Host "Specify the name of the file without the extension" -ForegroundColor DarkGray
        $data | ConvertTo-Csv | Out-File "$fileName.csv"
    }
    Write-Host "$data" 
}

function run() {
    do {
        title
        menu
        $option = Read-Host "Choose an option"

        switch ($option) {
            "v" { ouputFile($PSVersionTable) }
            "e" { ouputFile(Get-ExecutionPolicy -List) }
            "c" { ouputFile(Get-History) }
            "p" { ouputFile(Get-Process) }
            "n" { ouputFile(Get-NetIPAddress) }
            "f" { ouputFile(Get-HotFix) }
            "s" { ouputFile(Get-Service) }
            "s" { ouputFile(Get-Job) }
            "w" { ouputFile(Get-Service Windefend, SecurityHealthService, wscsvc | Select-Object Name, DisplayName, Status) }
        }
    }while ($option -ne "q") 
}

run