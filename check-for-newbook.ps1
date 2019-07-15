Add-Type –assemblyName PresentationFramework
Add-Type –AssemblyName PresentationCore
Add-Type –AssemblyName WindowsBase
$csv = import-csv "c:\users\%username%\documents\audible-search.csv"

$csv | ForEach-Object {
$Title = $_.Title
$Url = $_.Url
#"Searching for $Title"
$BookCheck = Invoke-WebRequest -Uri $Url -UseBasicParsing
$CheckBookExists = $BookCheck.Content.Contains("$Title")
if ($CheckBookExists -eq "True"){

[System.Windows.MessageBox]::Show('New Book Released: '+$Title,'New Book!')
    }
}
