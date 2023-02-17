[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

function title() {
    Write-Host "
     _ __ ___   ___   __| |_   _| | __ _ _ __   _ __ __ _| |_
    | '_ ` _ \ / _ \ / _` | | | | |/ _` | '__| | '__/ _` | __|
    | | | | | | (_) | (_| | |_| | | (_| | |    | | | (_| | |_
    |_| |_| |_|\___/ \__,_|\__,_|_|\__,_|_|    |_|  \__,_|\__|
    "
    Write-Host "
                        Module : Screenshot
    "
    Write-Host "==========================================================="
    Write-Host ""
}

function menu() {
    Write-Host "t : take screenshot"
    Write-Host "q : quit"
    Write-Host ""
}
function  takeScreenShot {
    begin {
        Add-Type -AssemblyName System.Drawing
        $drawing = [Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.FormatDescription -eq "JPEG" }
    }
    process { 
        Start-Sleep -Milliseconds 250

        [Windows.Forms.Sendkeys]::SendWait("{PrtSc}")

        # get image from clipboard
        Start-Sleep -Milliseconds 250
        $clipboard = [Windows.Forms.Clipboard]::GetImage()

        # create image to jpeg
        $drawingEncoded = New-Object Drawing.Imaging.EncoderParameters
        $drawingEncoded.Param[0] = New-Object Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]100)

        # save image
    }
    end {
        $fileName = Read-Host "Specify the name of the screenshot file without the extension"
        $clipboard.Save("$(Get-Location)\$filename.jpg")
    }
}

function run() {
    do {
        title
        menu
        $option = Read-Host "Choose an option"
        switch ($option) {
            "t" { takeScreenShot }
        }
    }while ($option -ne "q")
}

run