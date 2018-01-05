<#
------------
Description
------------

This script is used to create Virtual Machines.
Windows Server 2012 R2 Data center VM's are created as part of this demonstration.
The VM's will use managed disks for the VM's and a storage account for the diagnostics

The template and the parameters are being referred from the repository as mentioned in the below variables templateUri & templateParameterUri

-------------
Dependencies
-------------

1) The VNET-and-Subnet script should be run before this script. 
2) The Public IP address script should be run before this script
3) The NSG should be run before this script
4) The Nic should be run before this script
5) The Keyvault should be run before this script. The local adminPassword is retrieved from the keyvault.
     
    (The Virtual-Machines.parameters.json file must be updated with the Resource-id of the key-vault.
     However for this demo, the secretValue is fetched in powershell and sent as parameter)

#>


$resourceGroupName = 'm1-AzureIaaSEssentials'

$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName

$githubHandle = 'https://raw.githubusercontent.com/vlele/'

$templateUri = $githubHandle + 'csa_master_class/master/IaaS%20Essentials/Virtual-Machines/Virtual-Machines.json'

$templateParameterUri = $githubHandle + 'csa_master_class/master/IaaS%20Essentials/Virtual-Machines/Virtual-Machines.parameters.json'

$adminpasswordSecret = Get-AzureKeyVaultSecret -VaultName 'm1-keyvault' -Name 'adminpassword'


 New-AzureRmResourceGroupDeployment -Name "Virtual-Machines-Deployment" -ResourceGroupName $resourceGroupName -Mode Incremental `
 -TemplateUri $templateUri  -adminPassword $adminpasswordSecret.SecretValue -Verbose


 <#

 ---------------------------------------------------------------------------------------------------------------------------
 Usage of the below commands is for scenarios where user wants to download the template and parameter file onto their 
 local machine and initiate template deployment from the local template source.

 This would work only in cases of the main template or stand alone templates
 ---------------------------------------------------------------------------------------------------------------------------

 $adminpasswordSecret = Get-AzureKeyVaultSecret -VaultName 'm1-keyvault' -Name 'adminpassword'

 New-AzureRmResourceGroupDeployment -Name "Virtual-Machines-Deployment"  -ResourceGroupName 'm1-AzureIaaSEssentials' -Mode Incremental `
 -TemplateFile "C:\Users\aisadmin\Source\Repos\csa_master_class\IaaS Essentials\Virtual-Machines\Virtual-Machines.json" `
 -TemplateParameterFile "C:\Users\aisadmin\Source\Repos\csa_master_class\IaaS Essentials\Virtual-Machines\Virtual-Machines.parameters.json" `
 -adminPassword $adminpasswordSecret.SecretValue -Verbose
 #>