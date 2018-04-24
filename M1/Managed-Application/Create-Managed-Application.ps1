<#
------------
Description
------------

This script is used to create an Managed Application. 
Once the Managed Appliction instance is created, it has two resource groups

a) Application Resource Group (Contains managed application instance)
b) Managed Resource Group (Contains actual resources and has RBAC assigned as per Managed Application definition)

The Managed Application being deployed is referred from the already deployed Managed Application Definition

-------------
Dependencies
-------------

1) The Create-Managed-Application-Definition.ps1 script should be run before this script. This Managed Application is created from the same


#>

$resourceGroupName = 'm1-ManagedApplication'

$managedResourceGroupName = $resourceGroupName + '-Managed'

$resourceGroup = New-AzureRmResourceGroup -Name $resourceGroupName -Location "EastUS" -Force -Verbose

# Get ID of managed application definition
$managedAppDefinitionId=(Get-AzureRmManagedApplicationDefinition -ResourceGroupName m1-ManagedApplicationDefinition -Name m1ManagedApplication).ManagedApplicationDefinitionId


    
# Create the managed application
New-AzureRmManagedApplication `
  -Name m1storageApp `
  -Location $resourceGroup.Location  `
  -Kind ServiceCatalog `
  -ResourceGroupName $resourceGroupName `
  -ManagedApplicationDefinitionId $managedAppDefinitionId `
  -ManagedResourceGroupName $managedResourceGroupName `
  -Parameter "{`"storageAccountNamePrefix`": {`"value`": `"m1demo`"}, `"storageAccountType`": {`"value`": `"Standard_LRS`"}}" `
  -Verbose

