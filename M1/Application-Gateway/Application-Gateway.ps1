<#
------------
Description
------------

This script is used to create an Application Gateway to existing VNET/subnet resources.
Creation of an Standard Application Gateway to an existing VNET and with incoming trffic as Http is done for demonstraton purpose 
The template and the parameters are being referred from the repository as mentioned in the below variables templateUri & templateParameterUri

-------------
Dependencies
-------------

1) The VNET-and-Subnet script should be run before this script. The Application Gateway is added to an existing subnet
2) The design details for the Virtual Network and Subnet, the IP address for the Application Gateway should be present and the back-end IP addresses are added 
   to the back-end pool

#>


$resourceGroupName = 'm1-AzureIaaSEssentials'

$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName

$githubHandle = 'https://raw.githubusercontent.com/vlele/'

$templateUri = $githubHandle + 'csa_master_class/master/M1/Application-Gateway/Application-Gateway.json'

$templateParameterUri = $githubHandle + 'csa_master_class/master/M1/Application-Gateway/Application-Gateway.parameters.json'


 New-AzureRmResourceGroupDeployment -Name "Application-Gateway-Deployment" -ResourceGroupName $resourceGroupName -Mode Incremental `
 -TemplateUri $templateUri -TemplateParameterUri $templateParameterUri -Verbose


 <#

 ---------------------------------------------------------------------------------------------------------------------------
 Usage of the below commands is for scenarios where user wants to download the template and parameter file onto their 
 local machine and initiate template deployment from the local template source.

 This would work only in cases of the main template or stand alone templates
 ---------------------------------------------------------------------------------------------------------------------------


 New-AzureRmResourceGroupDeployment -Name "Application-Gateway-Deployment"  -ResourceGroupName 'm1-AzureIaaSEssentials' -Mode Incremental `
 -TemplateFile "C:\Users\aisadmin\Source\Repos\csa_master_class\M1\Application-Gateway\Application-Gateway.json" `
 -TemplateParameterFile "C:\Users\aisadmin\Source\Repos\csa_master_class\M1\Application-Gateway\Application-Gateway.parameters.json" -Verbose
 #>