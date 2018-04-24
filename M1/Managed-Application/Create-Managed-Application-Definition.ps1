<#
------------
Description
------------

This script is used to create an Managed Application Definition. 
Once the Managed Appliction Definition is created, it is present in the Service Catalog of the subscription

The Managed Application being deployed is referred from the repository as mentioned in the below variables managedApplicationUri

The script creates a new resource group and creates the Managed Application Definition in this resource group.

Based on the user specified in the search string the managed application definition will add details so the user is added as owner when application instances are created

-------------
Dependencies
-------------

N/A

#>

$userEmail = Read-Host -Prompt "Input the email of the user for Role Assignment"

# Get Azure Active Directory user Id to manage the application
$userId=(Get-AzureRmADUser -Mail ($userEmail)).Id

if(!$userId){

    Write-Host "Entered Email does not exists in AAD. Please retry with a valid id"

}

else
{

    $resourceGroupName = 'm1-ManagedApplicationDefinition'

    $resourceGroup = New-AzureRmResourceGroup -Name $resourceGroupName -Location "EastUS" -Force -Verbose

    $githubHandle = 'https://raw.githubusercontent.com/vlele/'

    $managedApplicationUri = $githubHandle + 'csa_master_class/master/M1/Managed-Application/ManagedApplication.zip'


    # Get role
    $roleId=(Get-AzureRmRoleDefinition -Name Owner).Id


    # Create the definition for a managed application
    New-AzureRmManagedApplicationDefinition `
      -Name "m1ManagedApplication" `
      -Location $resourceGroup.Location `
      -ResourceGroupName $resourceGroupName `
      -LockLevel ReadOnly `
      -DisplayName "m1 Managed Application" `
      -Description "This is a test Managed Application to create Azure Storage Account" `
      -Authorization "${userId}:$roleId" `
      -PackageFileUri $managedApplicationUri

  }

