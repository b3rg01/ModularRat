$file_name = $args[0]

function upload($file_location) {

}

function findFile {
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
      Write-Host "$location"
      Remove-Item "$location"
   }
}


function run() {
   findFile
}

run