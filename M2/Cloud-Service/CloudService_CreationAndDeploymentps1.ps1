<#
-------------
Description:
-------------

This powershell script is for setting up the environment for CSA Master Class and creating a resource group for deploying resources. 
This script should be run after the user has run this script for setting the environment.

This script will  create a cloud-service and deploy using the cspkg and cscfg file present in the storage account.

--------------
Inputs Needed:
--------------

1) Subscription Id --> Select the subscription Id from the subscriptions pane in the Azure portal. 
                        (This is mainly done in environments where users have multiple subscriptions)

2) pathToCloudServiceConfiguration --> Path from where the .cscfg files should be uploaded for the cloud service. 
                                    (This can be downloaded from the github repository to the local computer)

#>


$subscriptionId = 'SUBSCRIPTION ID'


$pathToCloudServiceConfiguration = 'PATH to .CSCFG File'

Add-AzureAccount 


Select-AzureSubscription -SubscriptionId $subscriptionId  -Default 


#Set-AzureSubscription -SubscriptionId $subscriptionId



#create the cloud service

$cloudServiceName = 'm2cloudservice'

New-AzureService -ServiceName $cloudServiceName -Location 'East US' -Label $cloudServiceName



New-AzureDeployment -ServiceName 'm2cloudservice' -Slot 'Production' -Package 'https://m2cloudservice.blob.core.windows.net/cloudservicedeployables/CloudSample.cspkg' `
-Configuration $pathToCloudServiceConfiguration   -label 'initialdeploy' 



 