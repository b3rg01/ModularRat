
function title {
    Write-Host "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" -ForegroundColor Yellow
    Write-Host "
     _ __ ___   ___   __| |_   _| | __ _ _ __   _ __ __ _| |_
    | '_ ` _ \ / _ \ / _` | | | | |/ _` | '__| | '__/ _` | __|
    | | | | | | (_) | (_| | |_| | | (_| | |    | | | (_| | |_
    |_| |_| |_|\___/ \__,_|\__,_|_|\__,_|_|    |_|  \__,_|\__|
    " -ForegroundColor Yellow
    Write-Host "
                        Module : File Handler
    " -ForegroundColor Blue
    Write-Host "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" -ForegroundColor Yellow
    Write-Host ""
 }

function menu {
    Write-Host "start : start a job" -ForegroundColor DarkGray
    Write-Host "stop : stop a job" -ForegroundColor DarkGray
    Write-Host "get : get list jobs" -ForegroundColor DarkGray
    Write-Host "remove : remove a job" -ForegroundColor DarkGray
    Write-Host "q : quit" -ForegroundColor Red
    Write-Host ""
}

function startJob {
    $scriptBlock = Read-Host "Enter your scriptBlock with the '{}'"
    try {
        
        Start-Job -ScriptBlock $scriptBlock -ErrorAction Continue
    }
    catch {
        Write-Host "Error while trying to run command..." -ForegroundColor Red
    }
}

function stopJob {
    $name = Read-Host "Enter the name of the job you want to stop"
    try {
    
        Stop-Job $name
    }
    catch {
        Write-Host "Error while trying to run command, make sure you have the right name..." -ForegroundColor Red
    }
}

function removeJob {
    $name = Read-Host "Enter the name of the job you want to remove"
    try {

        Remove-Job $name
    }
    catch {
        Write-Host "Error while trying to run command, make sure you have the right name..." -ForegroundColor Red
    }
}


function run() {
    do {
        title
        menu
        $option = Read-Host "Choose an option"
        switch ($option) {
            "start" { startJob }
            "stop" { stopJob }
            "remove" { removeJob }
            "get" { Get-Job }
        }
        Start-Sleep -Milliseconds 40
    }while ($option -ne "q") 
}

run