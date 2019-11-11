clear
Invoke-Command -Computer "hsstdb23" -ScriptBlock {Remove-Item -Path C:\2012.ps1 -force -recurse}
Invoke-Command -Computer "hsstdb23" -ScriptBlock {Remove-Item -Path C:\Explorer-11-for-Windows-Server-2012R2-KB4522007.msu -force -recurse}
echo "$_ file deleted"

