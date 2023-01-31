#Parameters
$Path = "C:\Temp" # Path where the file is located
$Days = "30" # Number of days before current date
 
#Calculate Cutoff date
$CutoffDate = (Get-Date).AddDays(-$Days)
 
#Get All Files modified more than the last 30 days
Get-ChildItem -Path $Path -Recurse -File | Where-Object { $_.LastWriteTime -lt $CutoffDate } | Remove-Item –Force -Verbose


#Read more: https://www.sharepointdiary.com/2020/12/delete-all-files-older-than-x-days-using-powershell.html#ixzz7ryPcfWiO
#font: https://www.sharepointdiary.com/2020/12/delete-all-files-older-than-x-days-using-powershell.html#:~:text=a%20specific%20directory.-,To%20delete%20all%20files%20that%20are%20older%20than%20a%20certain,to%20delete%20the%20filtered%20files.
