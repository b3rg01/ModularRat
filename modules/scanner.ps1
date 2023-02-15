function getVersionTable() {
    $PSVersionTable | ConvertTo-Html | Out-File versionTable.html
}

function getExecutionPolicy() {
    Get-ExecutionPolicy -List | ConvertTo-Html | Out-File executionPolicy.html
}
function getProcessRunning() {
    Get-Process | ConvertTo-Html | Out-File reportProcess.html
}

function getNetIPAddress() {
    Get-NetIPAddress | ConvertTo-Html | Out-File reportNetIp.html
}

function getNetIPAddress() {
    Get-HoxFix | ConvertTo-Html | Out-File reportHotFixes.html
}

function getServices() {
    Get-Service | ConvertTo-Html | Out-File reportServices.html
}
function checkIfWindowsDefenderIsRunning() {
    Get-Service Windefend, SecurityHealthService, wscsvc | Select-Object Name, DisplayName, Status | ConvertTo-Html | Out-File reportWinDefender.html
}

getExecutionPolicy
checkIfWindowsDefenderIsRunning