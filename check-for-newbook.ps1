#Allow for a custom -Location to be set
[cmdletbinding()]
Param (
[Parameter(Mandatory=$False)][String]$Location
)
#This is what allows us to make popups outside of ISE
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")


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
   #change these for yourself
   $csv = import-csv "c:\users\murbano\documents\audible-search.csv"
   $csvLocation =  "c:\users\murbano\documents\audible-search.csv"

}
$csv | ForEach-Object {
    $Title = $_.Title
    $Url = $_.Url
    $ProgressPreference = "SilentlyContinue"
    $BookCheck = Invoke-WebRequest -Uri $Url -UseBasicParsing
    $CheckBookExists = $BookCheck.Content.Contains("$Title")
    if ($CheckBookExists -eq "True")
        {
          if ($csvLocation -eq “Web”){
          [System.Windows.MessageBox]::Show('New Book Released: '+$Title,'New Book!')
              }
          else{
               $UserResponse= [System.Windows.Forms.MessageBox]::Show(“New Book Released: “+$Title+”`nWould You Like To View The Webpage And Delete The Entry?”,'New Book!', "YesNo")
               if ($UserResponse -eq "YES" ) 
                   {
                    #change location to variable
                    Start "$url"
                    Get-Content c:\users\murbano\documents\audible-search.csv | Where{$_ -notmatch "$url"} | Out-File c:\users\murbano\documents\audible-search.csv
                    #import-csv $csvLocation | where Url -NotLike "$Url" | export-csv "c:\users\murbano\documents\audible-search.csv" -NoTypeInformation
                   } 
               else 
                   { 
                     #No activity
                   }
              }
   }
   }
 $series = $csv | Measure-Object
 write-host "Number of Book Series Checked: "$Series.count 
 sleep 2
