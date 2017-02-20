$script_mg ={
param([object]$disk)

$fso = new-object -com Scripting.FileSystemObject
$random = (Get-Random -Minimum 1 -Maximum 10)
Start-Sleep -Seconds $random
return [pscustomobject]@{
process = $disk.name
Handles = $disk.handles
SI = $disk.SI
Random  = $random
}
}



[void][runspacefactory]::CreateRunspacePool()

$SessionState = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()
$RunspacePool = [runspacefactory]::CreateRunspacePool(1,5)
$RunspacePool.CleanupInterval = '00:03:00'

$PowerShell = [powershell]::Create()
$PowerShell.RunspacePool  = $RunspacePool
[void]$RunspacePool.Open()



$jobs = new-object system.collections.arraylist

(Get-Process *).count

Get-Process *| select name,handles,si | ForEach {

    $PowerShell = [powershell]::Create() 

    $PowerShell.RunspacePool = $RunspacePool   

    [void]$PowerShell.AddScript($script_mg)

    [void]$PowerShell.AddArgument($_)

    $Handle = $PowerShell.BeginInvoke()

    $temp ='' | Select PowerShell,Handle

    $temp.PowerShell = $PowerShell

    $temp.handle = $Handle

    [void]$jobs.Add($temp)   
}

   
   do {cls; "wating, remaining jobs: $(($jobs.handle.iscompleted).count)"}
   while (!($jobs.count)) 


$return = $jobs | ForEach {

    $_.powershell.EndInvoke($_.handle)

    $_.PowerShell.Dispose()

}

#$jobs.clear()

$return | ft -a 



