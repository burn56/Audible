#Allow for a custom -Location to be set
[cmdletbinding()]
Param (
[Parameter(Mandatory=$False)][String]$Location
)
#This is what allows us to make popups outside of ISE
Add-Type –assemblyName PresentationFramework
Add-Type –AssemblyName PresentationCore
Add-Type –AssemblyName WindowsBase

if($Location)
   {
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
   }
else
{
   write-host "CSV Default Location" #testing only - TO BE REMOVED
   $csv = import-csv "c:\users\murbano\documents\audible-search.csv"
}
$csv | ForEach-Object {
    $Title = $_.Title
    $Url = $_.Url
    $BookCheck = Invoke-WebRequest -Uri $Url -UseBasicParsing
    $CheckBookExists = $BookCheck.Content.Contains("$Title")
    if ($CheckBookExists -eq "True")
        {
         [System.Windows.MessageBox]::Show('New Book Released: '+$Title,'New Book!')
        }
   }
