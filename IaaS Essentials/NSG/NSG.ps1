<#
------------
Description
------------

This script is used to deploy the Network Security Groups(NSG) resources. 

Example illusrates three flavors
(i)   Default
(ii)  RDP being allowed
(iii) Web traffic being allowed for both http/https
The template and the parameters are being referred from the repository as mentioned in the below variables templateUri & templateParameterUri

-------------
Dependencies
-------------

1) This template uses the ApplicationGateway Address space which is used to create the NSG. The Application gateway need not be created at this 
time but the design details should be present for specifying the ip address range. As an alternative the security rule could be modified later.

#>


$resourceGroupName = 'm1-AzureIaaSEssentials'

$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName

$githubHandle = 'https://raw.githubusercontent.com/vlele/'

$templateUri = $githubHandle + 'csa_master_class/master/IaaS%20Essentials/NSG/NSG.json'

$templateParameterUri = $githubHandle + 'csa_master_class/master/IaaS%20Essentials/NSG/NSG.parameters.json'


 New-AzureRmResourceGroupDeployment -Name "NSGDeployment" -ResourceGroupName $resourceGroupName -Mode Incremental `
 -TemplateUri $templateUri -TemplateParameterUri $templateParameterUri -Verbose


 <#

 ---------------------------------------------------------------------------------------------------------------------------
 Usage of the below commands is for scenarios where user wants to download the template and parameter file onto their 
 local machine and initiate template deployment from the local template source.

 This would work only in cases of the main template or stand alone templates
 ---------------------------------------------------------------------------------------------------------------------------


 New-AzureRmResourceGroupDeployment -Name "NSGDeployment"  -ResourceGroupName 'm1-AzureIaaSEssentials' -Mode Incremental `
 -TemplateFile "C:\Users\aisadmin\Source\Repos\csa_master_class\IaaS Essentials\NSG\NSG.json" `
 -TemplateParameterFile "C:\Users\aisadmin\Source\Repos\csa_master_class\IaaS Essentials\NSG\NSG.parameters.json" -Verbose
 #>