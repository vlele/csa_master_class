<#
------------
Description
------------

This script is used to create network interface cards.
Different variations have been created as part of this demonstration.
(i) Nic with public Ip and NSG
(ii) Nic with internal IP

The template and the parameters are being referred from the repository as mentioned in the below variables templateUri & templateParameterUri

-------------
Dependencies
-------------

1) The VNET-and-Subnet script should be run before this script. The Nic is added to an existing subnet
2) The Public IP address script should be run before this script
3) The NSG should be run before this script

#>


$resourceGroupName = 'm1-AzureIaaSEssentials'

$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName

$githubHandle = 'https://raw.githubusercontent.com/vlele/'

$templateUri = $githubHandle + 'csa_master_class/master/M1/Nics/Nics.json'

$templateParameterUri = $githubHandle + 'csa_master_class/master/M1/Nics/Nics.parameters.json'


 New-AzureRmResourceGroupDeployment -Name "Nics-Deployment" -ResourceGroupName $resourceGroupName -Mode Incremental `
 -TemplateUri $templateUri -TemplateParameterUri $templateParameterUri -Verbose


 <#

 ---------------------------------------------------------------------------------------------------------------------------
 Usage of the below commands is for scenarios where user wants to download the template and parameter file onto their 
 local machine and initiate template deployment from the local template source.

 This would work only in cases of the main template or stand alone templates
 ---------------------------------------------------------------------------------------------------------------------------


 New-AzureRmResourceGroupDeployment -Name "Nics-Deployment"  -ResourceGroupName 'm1-AzureIaaSEssentials' -Mode Incremental `
 -TemplateFile "C:\Users\aisadmin\Source\Repos\csa_master_class\M1\Nics\Nics.json" `
 -TemplateParameterFile "C:\Users\aisadmin\Source\Repos\csa_master_class\M1\Nics\Nics.parameters.json" -Verbose
 #>