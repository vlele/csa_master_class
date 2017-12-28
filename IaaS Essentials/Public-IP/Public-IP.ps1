
$resourceGroupName = 'm1-AzureIaaSEssentials1'

$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName

$templateUri = ''
$templateParameterUri = ''


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