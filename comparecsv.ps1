#Importing CSV
$File1 = Import-Csv -Path "C:\Users\$env:username\Desktop\Files\Users 2018-02-01 12.55.02.csv"
 
#Importing CSV 
$File2 = Import-Csv -Path "C:\Users\$env:username\Desktop\Files\Users 2018-02-03 07.55.00.csv"
 
#Compare both CSV files - column SamAccountName
$Results = Compare-Object  $File1 $File2 -Property SamAccountName -IncludeEqual
 
$Array = @()       
Foreach($R in $Results)
{
    If( $R.sideindicator -eq "==" )
    {
        $Object = [pscustomobject][ordered] @{
 
            Username = $R.SamAccountName
            "Compare indicator" = $R.sideindicator
 
        }
        $Array += $Object
    }
}
 
#Count users in both files
($Array | sort-object username | Select-Object * -Unique).count
 
#Display results in console
$Array