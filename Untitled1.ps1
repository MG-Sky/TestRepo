
$FolderPath = '\\wwww345435345\fdsfsf$\sdfdgdg\sdfsdfsdf'

$splitted = ($FolderPath -split '\\').trim()
#Invoke-Expression -Command "rmtshare.exe $FolderPath"

Remove-Item $FolderPath -ErrorVariable blad -Recurse -ErrorAction SilentlyContinue

if (!$?)
{

if ($($blad.CategoryInfo.Category) -eq 'ObjectNotFound')
    {
   $blad.exception.Message | Write-Warning
    }

    if ($($blad.CategoryInfo.Category) -eq 'PermissionDenied')
    {

   " Manual action is required: $($blad.exception.Message)" | Write-Warning
    }
    else {$flase}

    if($($blad.CategoryInfo.reason) -eq 'PathTooLongException')
    {
    
    Get-ChildItem $blad.targetObject -Directory | 
    foreach {
          write-host "long path/name detected doing cleanup using alternative method"
          $obj = new-object  -ComObject scripting.filesystemobject
          $paths = $(Join-Path -Path $($blad.CategoryInfo.TargetName) -ChildPath $_)
          $obj.DeleteFolder($('\\?\'+$paths)) 
            }
    }

}


