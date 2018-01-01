<#
------------
Description
------------

This script is used to create an Availability Set resource.
Flag is set to ensure the resource allowed managed resources 
The template and the parameters are being referred from the repository as mentioned in the below variables templateUri & templateParameterUri

-------------
Dependencies
-------------

N/A

#>


$resourceGroupName = 'm1-AzureIaaSEssentials'

$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName

$githubHandle = 'https://raw.githubusercontent.com/manishkumar-agarwal/'

$templateUri = $githubHandle + 'csa_master_class/master/IaaS%20Essentials/Availability-Set/Availability-Set.json'

$templateParameterUri = $githubHandle + 'csa_master_class/master/IaaS%20Essentials/Availability-Set/Availability-Set.parameters.json'


 New-AzureRmResourceGroupDeployment -Name "Availability-Set-Deployment" -ResourceGroupName $resourceGroupName -Mode Incremental `
 -TemplateUri $templateUri -TemplateParameterUri $templateParameterUri -Verbose


 <#

 ---------------------------------------------------------------------------------------------------------------------------
 Usage of the below commands is for scenarios where user wants to download the template and parameter file onto their 
 local machine and initiate template deployment from the local template source.

 This would work only in cases of the main template or stand alone templates
 ---------------------------------------------------------------------------------------------------------------------------


 New-AzureRmResourceGroupDeployment -Name "Availability-Set-Deployment"  -ResourceGroupName 'm1-AzureIaaSEssentials' -Mode Incremental `
 -TemplateFile "C:\Users\aisadmin\Source\Repos\csa_master_class\IaaS Essentials\Availability-Set\Availability-Set.json" `
 -TemplateParameterFile "C:\Users\aisadmin\Source\Repos\csa_master_class\IaaS Essentials\Availability-Set\Availability-Set.parameters.json" -Verbose
 #>