[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")


function title {
    Write-Host "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" -ForegroundColor Yellow
    Write-Host "
     _ __ ___   ___   __| |_   _| | __ _ _ __   _ __ __ _| |_
    | '_ ` _ \ / _ \ / _` | | | | |/ _` | '__| | '__/ _` | __|
    | | | | | | (_) | (_| | |_| | | (_| | |    | | | (_| | |_
    |_| |_| |_|\___/ \__,_|\__,_|_|\__,_|_|    |_|  \__,_|\__|
    " -ForegroundColor Yellow
    Write-Host "
                        Module : Screenshot
    " -ForegroundColor Blue
    Write-Host "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" -ForegroundColor Yellow
    Write-Host ""
}

function  takeScreenShot($file_name) {
    begin {
        Start-Sleep -Milliseconds 250
        [Windows.Forms.Sendkeys]::SendWait("{PrtSc}")
    }
    process { 
        # get image from clipboard
        Start-Sleep -Milliseconds 250
        $clipboard = [Windows.Forms.Clipboard]::GetImage()
        
        # create image to jpeg
        $drawingEncoded = New-Object Drawing.Imaging.EncoderParameters
        $drawingEncoded.Param[0] = New-Object Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]100)
    }
    end {
        # save image
        $clipboard.Save("$(Get-Location)\$file_name.jpg")
    }
}

function run($arg) {
    title
    If ($arg) {
        takeScreenShot($arg)
    }else { Write-Error "Please specify the file name..." }
}

run($args[0])