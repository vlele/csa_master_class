<#
------------
Description
------------

This script is used to deploy the VNETS and Subnet resources.
There will be 2 VNETS created and corresponding subnets created in each of those.
Updation of the DNS server for one VNET and using of a NSG is done for demonstraton purpose 
The template and the parameters are being referred from the repository as mentioned in the below variables templateUri & templateParameterUri

-------------
Dependencies
-------------

1) The NSG script should be run before this script. The subnet uses the NSG for setup
2) The design details for the Virtual Network and Subnet should be present

#>


$resourceGroupName = 'm1-AzureIaaSEssentials'

$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName

$githubHandle = 'https://raw.githubusercontent.com/vlele/'

$templateUri = $githubHandle + 'csa_master_class/master/M1/VNET-and-Subnet/VNET-and-Subnet.json'

$templateParameterUri = $githubHandle + 'csa_master_class/master/M1/VNET-and-Subnet/VNET-and-Subnet.parameters.json'


 New-AzureRmResourceGroupDeployment -Name "VNET-Subnet-Deployment" -ResourceGroupName $resourceGroupName -Mode Incremental `
 -TemplateUri $templateUri -TemplateParameterUri $templateParameterUri -Verbose


 <#

 ---------------------------------------------------------------------------------------------------------------------------
 Usage of the below commands is for scenarios where user wants to download the template and parameter file onto their 
 local machine and initiate template deployment from the local template source.

 This would work only in cases of the main template or stand alone templates
 ---------------------------------------------------------------------------------------------------------------------------


 New-AzureRmResourceGroupDeployment -Name "VNET-Subnet-Deployment"  -ResourceGroupName 'm1-AzureIaaSEssentials' -Mode Incremental `
 -TemplateFile "C:\Users\aisadmin\Source\Repos\csa_master_class\M1\VNET-and-Subnet\VNET-and-Subnet.json" `
 -TemplateParameterFile "C:\Users\aisadmin\Source\Repos\csa_master_class\M1\VNET-and-Subnet\VNET-and-Subnet.parameters.json" -Verbose
 #>