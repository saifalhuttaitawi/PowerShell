    #Get Updates List
    $hotfix= Get-Hotfix
    
    # Loop to check if the update was already installed before.
    foreach ($element in $hotfix.HotFixID)
        {
        if ($element -eq "KB4522007")
           {
           
           write-host("The Update in  "+ $computer +" is found!")
           break
           }
           else
           {
           write-host("0")
           }
        }