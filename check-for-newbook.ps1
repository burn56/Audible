#Allow for a custom -Location to be set
[cmdletbinding()]
Param (
[Parameter(Mandatory=$False)][String]$Location
)
#This is what allows us to make popups outside of ISE
Add-Type assemblyName PresentationFramework
Add-Type AssemblyName PresentationCore
Add-Type assemblyName WindowsBase

if($Location)
   {
    #check to see if $Location is a url
    if ($Location -match ("http")) 
       {
        #Download the csv file
        $tempLocation = "c:\temp\temp-audible-search.csv"
        [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest $Location -OutFile $tempLocation
        $csv = import-csv $tempLocation
        Remove-Item $tempLocation
        $csvLocation = “Web”
       }
   
    else
       {
        $csv = import-csv $Location
        $csvLocation = $Location
       }
   }
else
{
   $csv = import-csv "c:\users\$username%\documents\audible-search.csv"
   $csvLocation =  "c:\users\%username%\documents\audible-search.csv"

}
$csv | ForEach-Object {
    $Title = $_.Title
    $Url = $_.Url
    $BookCheck = Invoke-WebRequest -Uri $Url -UseBasicParsing
    $CheckBookExists = $BookCheck.Content.Contains("$Title")
    if ($CheckBookExists -eq "True")
        {
          if ($csvLocation -eq “Web”){
          [System.Windows.MessageBox]::Show('New Book Released: '+$Title,'New Book!')
              }
          else{
               $UserResponse= [System.Windows.Forms.MessageBox]::Show(“New Book Released: “+$Title+”`nWould You Like To Delete The Entry?”,'New Book!', "YesNo")
               if ($UserResponse -eq "YES" ) 
                   {
                    import-csv $csvLocation |
                    where Url -NotLike "$Url" | export-csv "c:\users\Administrator\documents\audible-search.csv" -NoTypeInformation
                   } 
               else 
                   { 
                     #No activity
                   }
              }
   }
   }
