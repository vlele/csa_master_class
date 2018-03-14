<#
-------------
Description:
-------------

This powershell script is for setting up the environment for CSA Master Class and creating a resource group for deploying resources. 
All the next set of steps should be run after the user has run this script for setting the environment.

As part of this script, Users need to update the script variables subscriptionid and tenantid with the actual environments from the Azure Portal.

This script will also create a storage account and a table loaded with sample data in it.

--------------
Inputs Needed:
--------------

1) Subscription Id --> Select the subscription Id from the subscriptions pane in the Azure portal. 
                        (This is mainly done in environments where users have multiple subscriptions)


2) Tenant Id --> This is the id of the Azure Active Directory(AAD) and can be got from the properties inside the AAD

#>


$subscriptionId = 'SUBSCRIPTION ID'
$tenantId = 'TENANT ID OR AZURE ACTIVE DIRECTORY ID'

Login-AzureRmAccount


Set-AzureRmContext -SubscriptionId $subscriptionId -TenantId $tenantId

$resourceGroupName = "m2-CloudService"

New-AzureRmResourceGroup -Name $resourceGroupName  -Location "EastUS" -Force -Verbose



#Create the storage account

$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName

$githubHandle = 'https://raw.githubusercontent.com/vlele/'

$templateUri = $githubHandle + 'csa_master_class/master/M1/Storage-Acct/Storage-Acct.json'

$templateParameterUri = $githubHandle + 'csa_master_class/master/M2/Cloud-Service/Storage-Acct.parameters.json'


 New-AzureRmResourceGroupDeployment -Name "Storage-Acct-Deployment" -ResourceGroupName $resourceGroupName -Mode Incremental `
 -TemplateUri $templateUri -TemplateParameterUri $templateParameterUri -Verbose
