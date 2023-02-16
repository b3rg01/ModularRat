function title() {
    Write-Host "=========================================================="
    Write-Host 
    "
     _ __ ___   ___   __| |_   _| | __ _ _ __   _ __ __ _| |_
    | '_ ` _ \ / _ \ / _` | | | | |/ _` | '__| | '__/ _` | __|
    | | | | | | (_) | (_| | |_| | | (_| | |    | | | (_| | |_
    |_| |_| |_|\___/ \__,_|\__,_|_|\__,_|_|    |_|  \__,_|\__|
    "
    Write-Host "Module : Scanner"
    Write-Host "==========================================================="
    Write-Host ""
}

function menu() {
    Write-Host "Press v and enter to show ps version table"
    Write-Host "Press e and enter to show execution list policy"
    Write-Host "Press p and enter to show process running"
    Write-Host "Press n and enter to show net ip address information"
    Write-Host "Press f and enter to show hot fixes"
    Write-Host "Press s and enter to show services"
    Write-Host "Press w and enter to show windows defender details"
    Write-Host "Press q and enter to quit"
}

function ouputFile($data) {
    $answer = Read-Host "Do you want to output a file as html?(y/n)"
                
    if ($answer -eq "y") {
        $fileName = Read-Host "Specify the name of the file without the extension"
        $data | ConvertTo-Html | Out-File "$fileName.html"
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
            "p" { ouputFile(Get-Process) }
            "n" { ouputFile(Get-NetIPAddress) }
            "f" { ouputFile(Get-HoxFix) }
            "s" { ouputFile(Get-Service) }
            "w" { ouputFile(Get-Service Windefend, SecurityHealthService, wscsvc | Select-Object Name, DisplayName, Status) }
        }
    }while ($option -ne "q") 
}
