#Allow for a custom -Location to be set
[cmdletbinding()]
Param (
[String]$Location
)
#This is what allows us to make popups outside of ISE
Add-Type –assemblyName PresentationFramework
Add-Type –AssemblyName PresentationCore
Add-Type –AssemblyName WindowsBase

if ($Location -eq $null)
   {
    $csv = import-csv "c:\users\%username%\documents\audible-search.csv"
   }
#check to see if $Location is a url
if ($Location -match ("http")) 
   {
    #Download the csv file
    $tempLocation = "c:\temp\temp-audible-search.csv"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest $Location -OutFile $tempLocation
    $csv = import-csv $tempLocation
    Remove-Item $tempLocation
   }
else
   {
    $csv = import-csv $Location
   }

$csv | ForEach-Object 
   {
    $Title = $_.Title
    $Url = $_.Url
    $BookCheck = Invoke-WebRequest -Uri $Url -UseBasicParsing
    $CheckBookExists = $BookCheck.Content.Contains("$Title")
    if ($CheckBookExists -eq "True")
        {
         [System.Windows.MessageBox]::Show('New Book Released: '+$Title,'New Book!')
        }
   }
