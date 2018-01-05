<#
------------
Description
------------

This script is used to create a Key Vault and store secret values in it.
The script will prompt for password which will be stored in Key vault and later retrived directly from the Keyvault while provisioning VMs 
The template and the parameters are being referred from the repository as mentioned in the below variables templateUri & templateParameterUri

-------------
Dependencies
-------------

N/A

#>


$resourceGroupName = 'm1-AzureIaaSEssentials'

$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName

$githubHandle = 'https://raw.githubusercontent.com/vlele/'

$templateUri = $githubHandle + 'csa_master_class/master/IaaS%20Essentials/KeyVault/KeyVault.json'

$templateParameterUri = $githubHandle + 'csa_master_class/master/IaaS%20Essentials/KeyVault/KeyVault.parameters.json'


$adminpassword = Read-Host -assecurestring "Enter local admin password for VMs"

$aadUser = Get-AzureRmADUser -Mail (Get-AzureRmContext).Account.Id

 New-AzureRmResourceGroupDeployment -Name "KeyVault-Deployment" -ResourceGroupName $resourceGroupName -Mode Incremental `
 -TemplateUri $templateUri  -user-object-id $aadUser.Id -adminpassword $adminpassword -Verbose


 <#

 ---------------------------------------------------------------------------------------------------------------------------
 Usage of the below commands is for scenarios where user wants to download the template and parameter file onto their 
 local machine and initiate template deployment from the local template source.

 This would work only in cases of the main template or stand alone templates
 ---------------------------------------------------------------------------------------------------------------------------

 $adminpassword = Read-Host -assecurestring "Enter local admin password for VMs"

 $aadUser = Get-AzureRmADUser -Mail (Get-AzureRmContext).Account.Id

 New-AzureRmResourceGroupDeployment -Name "KeyVault-Deployment"  -ResourceGroupName 'm1-AzureIaaSEssentials' -Mode Incremental `
 -TemplateFile "C:\Users\aisadmin\Source\Repos\csa_master_class\IaaS Essentials\KeyVault\KeyVault.json" `
 -TemplateParameterFile "C:\Users\aisadmin\Source\Repos\csa_master_class\IaaS Essentials\KeyVault\KeyVault.parameters.json"  `
 -user-object-id $aadUser.Id -adminpassword $adminpassword -Verbose
 #>