<#
------------
Description
------------

This script is used to deploy the Public-IP resources. 
The template and the parameters are being referred from the repository as mentioned in the below variables templateUri & templateParameterUri

-------------
Dependencies
-------------

N/A

#>


$resourceGroupName = 'm1-AzureIaaSEssentials'

$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName

$githubHandle = 'https://raw.githubusercontent.com/vlele/'

$templateUri = $githubHandle + 'csa_master_class/master/IaaS%20Essentials/Public-IP/Public-IP.json'

$templateParameterUri = $githubHandle + 'csa_master_class/master/IaaS%20Essentials/Public-IP/Public-IP.parameters.json'


 New-AzureRmResourceGroupDeployment -Name "PublicIPDeployment" -ResourceGroupName $resourceGroupName -Mode Incremental `
 -TemplateUri $templateUri -TemplateParameterUri $templateParameterUri -Verbose


 <#

 ---------------------------------------------------------------------------------------------------------------------------
 Usage of the below commands is for scenarios where user wants to download the template and parameter file onto their 
 local machine and initiate template deployment from the local template source.

 This would work only in cases of the main template or stand alone templates
 ---------------------------------------------------------------------------------------------------------------------------


 New-AzureRmResourceGroupDeployment -Name "PublicIpDeployment"  -ResourceGroupName 'm1-AzureIaaSEssentials' -Mode Incremental `
 -TemplateFile "C:\Users\aisadmin\Source\Repos\csa_master_class\IaaS Essentials\Public-IP\Public-IP.json" `
 -TemplateParameterFile "C:\Users\aisadmin\Source\Repos\csa_master_class\IaaS Essentials\Public-IP\Public-IP.parameters.json" -Verbose
 #>