[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

# takes screenshot
function  TakeScreenShot {

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
        $clipboard.Save("$(Get-Location)\screenshot.jpg")
    }
}

TakeScreenShot