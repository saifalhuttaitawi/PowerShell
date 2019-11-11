clear
#Get Server List
$ComputerName = Cat C:\update\Computers.txt
foreach ($computer in $ComputerName)
    {
   #write-host("Now we check : "+ $computer)

    #Get Updates List
    $hotfix= Get-Hotfix -cn $computer
    
    # Loop to check if the update was already installed before.
    foreach ($element in $hotfix.HotFixID)
        {
        if ($element -eq "KB4522007")
           {
           $answer=1
           write-host("The Update in  "+ $computer +" is found!")
           break
           }
           else
           {
           $answer=0
           }
        }

        if ($answer -eq 0)
            {
           #write-host("The Update in  "+ $computer +" is not found!")
            $Syntax = GWMI win32_operatingsystem -cn $computer
            $CheckOSVersion = $Syntax.Caption


            write-host("The OS on  "+ $computer +" is : "+$CheckOSVersion)


             if ($CheckOSVersion -match "2016")
                {
                write-host(" Copying update file..")
                Copy-Item –Path C:\update\2016.ps1 –Destination 'C:\' –ToSession (New-PSSession –ComputerName $computer)
                Copy-Item –Path C:\update\Explorer-11-for-Windows-Server-2016-KB4522007.msu –Destination 'C:\' –ToSession (New-PSSession –ComputerName $computer)
                write-host("Installing ... ")
                Invoke-Command –ComputerName $computer –ScriptBlock{c:\2016.ps1}
                write-host("Cleaning")
                Invoke-Command -Computer $computer -ScriptBlock {Remove-Item -Path C:\2016.ps1 -force -recurse}
                Invoke-Command -Computer $computer -ScriptBlock {Remove-Item -Path C:\Explorer-11-for-Windows-Server-2016-KB4522007.msu -force -recurse}
                write-host("DONE!")
                }




             if ($CheckOSVersion -match "2012 R2")
                {
                Copy-Item –Path C:\update\2012.ps1 –Destination 'C:\' –ToSession (New-PSSession –ComputerName $computer)
                write-host(" Copying update file..")
                Copy-Item –Path C:\update\Explorer-11-for-Windows-Server-2012R2-KB4522007.msu –Destination 'C:\' –ToSession (New-PSSession –ComputerName $computer)
                write-host("Check connection")
                If (Test-Connection -ComputerName $computer -Quiet)
                    {
                write-host("Installing ... ")
                Invoke-Command –ComputerName $computer –ScriptBlock{c:\2012.ps1}
                    }
                write-host("Cleaning")
                #Invoke-Command -Computer $computer -ScriptBlock {Remove-Item -Path C:\2012.ps1 -force -recurse}
                #Invoke-Command -Computer $computer -ScriptBlock {Remove-Item -Path C:\Explorer-11-for-Windows-Server-2012R2-KB4522007.msu -force -recurse}
                write-host("DONE!")
                }




             if ($CheckOSVersion -match "2008 R2")
                {
                Copy-Item –Path C:\update\2008.ps1 –Destination 'C:\' –ToSession (New-PSSession –ComputerName $computer)
                write-host(" Copying update file..")
                Copy-Item –Path C:\update\Explorer-11-for-Windows-Server-2008R2-KB4522007.msu –Destination 'C:\' –ToSession (New-PSSession –ComputerName $computer)
                write-host("Installing ... ")
                Invoke-Command –ComputerName $computer –ScriptBlock{c:\2008.ps1}
                write-host("Cleaning")
                Invoke-Command -Computer $computer -ScriptBlock {Remove-Item -Path C:\2008.ps1 -force -recurse}
                Invoke-Command -Computer $computer -ScriptBlock {Remove-Item -Path C:\Explorer-11-for-Windows-Server-2008R2-KB4522007.msu -force -recurse}
                write-host("DONE!")
                }

            }
    }
