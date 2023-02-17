$file_name = $args[0]

function upload($file_location) {

}

function findFile() {
   $location = ""
   try {
      $location = Get-Item "$file_name" -ErrorAction Stop
   }
   catch {
      # find file if not saved in current directory
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