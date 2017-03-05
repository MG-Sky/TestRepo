function remove-numbers($folferPath){

$files = Get-ChildItem $folferPath -File  | ? {($_.Extension -eq '.flac') -or ($_.Extension -eq '.mp3') -or ($_.Extension -eq '.wav') -or ($_.Extension -eq '.m4a')}

foreach ($file in $files) {

$regexed = ($file.name -replace '^\d{4}\s','').TrimStart()
"zmieniam nazwe na: $regexed tak"

Rename-Item -Path $file.fullName -NewName $regexed -ErrorAction Inquire



}


}

remove-numbers F:\



