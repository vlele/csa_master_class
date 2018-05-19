<#
------------
Description
------------

This script is used to demo Azure Policies. As part of this script, we are testing the 'Deny' action when a Azure policy is set
The script will do the below
	- Create a new resource group
	- Create an unencrypted storage account
	- Apply the Azure policy to the resource group to deny creation of unencrypted storage account
	- Create an unencrypted storage account (This step fails because of Azure Policy applied)
The template and the parameters are being referred from the repository as mentioned in the below variables templateUri & templateParameterUri

-------------
Dependencies
-------------

N/A

#>

# Create the Resource Group

$resourceGroupName = 'm1-AzurePolicyAudit'

$resourceGroup = New-AzureRmResourceGroup -Name $resourceGroupName -Location "EastUS" -Force -Verbose

# Create the Storage Account

$storageAccountName = "m1azurepolicyaudit1"

$storageAccount = New-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName `
                   -Location $resourceGroup.Location  -SkuName Standard_LRS   -Kind Storage 

#Define the policy 

$policyDefinition = New-AzureRmPolicyDefinition `
    -Name 'storageAccountwithSKU' `
    -DisplayName 'Allowed storage account SKUs -Audit' `
    -Policy 'https://raw.githubusercontent.com/vlele/csa_master_class/master/M1/Policies/StorageAccountAuditPolicy.json'

# Get the Policy Defintion details

$policyStorageAccountSKUAudit = Get-AzureRmPolicyDefinition | Where-Object { $_.Properties.DisplayName -eq 'Allowed storage account SKUs -Audit' }

# Perform the policy assignment

New-AzureRmPolicyAssignment -Name 'Allow Storage accounts with selected SKUs audit' -Scope $resourceGroup.ResourceId -PolicyDefinition $policyStorageAccountSKUAudit


# Create storage account post restriction to show Azure policy denying creation of resource

$storageAccountName = "m1azurepolicyaudit2"

$storageAccount = New-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName `
                   -Location $resourceGroup.Location  -SkuName Standard_LRS   -Kind Storage 

