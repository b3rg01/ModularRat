function title() {
    Write-Host "
     _ __ ___   ___   __| |_   _| | __ _ _ __   _ __ __ _| |_
    | '_ ` _ \ / _ \ / _` | | | | |/ _` | '__| | '__/ _` | __|
    | | | | | | (_) | (_| | |_| | | (_| | |    | | | (_| | |_
    |_| |_| |_|\___/ \__,_|\__,_|_|\__,_|_|    |_|  \__,_|\__|
    "
    Write-Host "
                        Module : Scanner
    "
    Write-Host "==========================================================="
    Write-Host ""
}

function menu() {
    Write-Host "v : show ps version table"
    Write-Host "e : show execution list policy"
    Write-Host "p : show process running"
    Write-Host "n : show net ip address information"
    Write-Host "f : show hot fixes"
    Write-Host "c : show command history"
    Write-Host "s : show services"
    Write-Host "w : show windows defender details"
    Write-Host "q : quit"
    Write-Host ""
}

function ouputFile($data) {
    $answer = Read-Host "Do you want to output a file as csv?(y/n)"
                
    if ($answer -eq "y") {
        $fileName = Read-Host "Specify the name of the file without the extension"
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
            "w" { ouputFile(Get-Service Windefend, SecurityHealthService, wscsvc | Select-Object Name, DisplayName, Status) }
        }
    }while ($option -ne "q") 
}

run
