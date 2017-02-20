
$i = 1
$app = New-Object -ComObject internetexplorer.application
$app.navigate2(“http://www.google.com/search?&num=100&zluszczanie kwasami warszawa”)
while ($app.Busy) {Start-Sleep -Milliseconds 100}
$app.Visible = $false

$app.Document.all | ? classname -eq 'r' | foreach {


 $links = $_.childNodes | ? href -notlike '*kaspersky*' 
 
 $links |  select href, text*  | foreach {
 

 
        new-object psobject -Property @{
                                        Place = $i
                                        Href = $_.href
                                        dESC = $_.TEXTcONTENT
 }
 $i++
 }

 } 