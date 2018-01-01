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

#>


$resourceGroupName = 'm1-AzureIaaSEssentials'

$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName

$githubHandle = 'https://raw.githubusercontent.com/manishkumar-agarwal/'

$templateUri = $githubHandle + 'csa_master_class/master/IaaS%20Essentials/Virtual-Machines/Virtual-Machines.json'

$templateParameterUri = $githubHandle + 'csa_master_class/master/IaaS%20Essentials/Virtual-Machines/Virtual-Machines.parameters.json'


 New-AzureRmResourceGroupDeployment -Name "Virtual-Machines-Deployment" -ResourceGroupName $resourceGroupName -Mode Incremental `
 -TemplateUri $templateUri -TemplateParameterUri $templateParameterUri -Verbose


 <#

 ---------------------------------------------------------------------------------------------------------------------------
 Usage of the below commands is for scenarios where user wants to download the template and parameter file onto their 
 local machine and initiate template deployment from the local template source.

 This would work only in cases of the main template or stand alone templates
 ---------------------------------------------------------------------------------------------------------------------------


 New-AzureRmResourceGroupDeployment -Name "Virtual-Machines-Deployment"  -ResourceGroupName 'm1-AzureIaaSEssentials' -Mode Incremental `
 -TemplateFile "C:\Users\aisadmin\Source\Repos\csa_master_class\IaaS Essentials\Virtual-Machines\Virtual-Machines.json" `
 -TemplateParameterFile "C:\Users\aisadmin\Source\Repos\csa_master_class\IaaS Essentials\Virtual-Machines\Virtual-Machines.parameters.json" -Verbose
 #>