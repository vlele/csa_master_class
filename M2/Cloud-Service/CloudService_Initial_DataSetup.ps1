<#
-------------
Description:
-------------

This powershell script is for setting up the environment for CSA Master Class and creating a resource group for deploying resources. 
This script should be run after the user has run this script for setting the environment.

This script will  create a storage account, containers and a table loaded with sample data in it for the cloud-service demo.

--------------
Inputs Needed:
--------------


1) pathToDownloadImages --> Path from where the images must be uploaded to storage account. 
                            (This can be downloaded from the github repository to the local computer)


2) pathToCloudServiceDeployables --> Path from where the cspkg and the cscfg files should be uploaded for the cloud service. 
                                    (This can be downloaded from the github repository to the local computer or 
                                    Users can compile the solution and generate these files)

#>


$pathToDownloadImages = 'C:\Users\aisadmin\Source\Repos\csa_master_class\M2\Cloud-Service\Images'
$pathToCloudServiceDeployables = 'C:\Users\aisadmin\Source\Repos\csa_master_class\M2\Cloud-Service\CloudServiceDeployables'


$resourceGroupName = "m2-CloudService"

$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName



#Create the storage account

$storageAccountName = "m2cloudservice"

$storageAccount = New-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName `
                   -Location $resourceGroup.Location  -SkuName Standard_LRS   -Kind Storage

$storageAccount = Get-AzureRmStorageAccount -Name $storageAccountName -ResourceGroupName $resourceGroupName

$ctx = $storageAccount.Context

$tableName = "author"

$authorTable = New-AzureStorageTable -Name $tableName -Context $ctx -Verbose

##Inserting seed data into the "author" table

Add-StorageTableRow  -table $authorTable -partitionKey "OdeToCode" -rowKey (New-Guid) `
     -property @{Firstname = "Scott"; Lastname = "Allen"; Phone = "8790000801"; Email = "OdeToCode@psmail.com"}

Add-StorageTableRow  -table $authorTable -partitionKey "troyhunt" -rowKey (New-Guid) `
     -property @{Firstname = "Troy"; Lastname = "Hunt"; Phone = "8790000802"; Email = "troyhunt@psmail.com"}

Add-StorageTableRow  -table $authorTable -partitionKey "danwahlin" -rowKey (New-Guid) `
     -property @{Firstname = "Dan"; Lastname = "Wahlin"; Phone = "8790000803"; Email = "danwahlin@psmail.com"}


Add-StorageTableRow  -table $authorTable -partitionKey "shawnwildermuth" -rowKey (New-Guid) `
     -property @{Firstname = "Shawn"; Lastname = "Wildermuth"; Phone = "8790000804"; Email = "shawnwildermuth@psmail.com" }

Add-StorageTableRow  -table $authorTable -partitionKey "housecor" -rowKey (New-Guid) `
     -property @{Firstname = "Cory"; Lastname = "House"; Phone = "8790000805"; Email = "housecor@psmail.com" }

Add-StorageTableRow  -table $authorTable -partitionKey "jeremybytes" -rowKey (New-Guid) `
     -property @{Firstname = "Jeremy"; Lastname = "Clark"; Phone = "8790000806"; Email = "jeremybytes@psmail.com" }

Add-StorageTableRow  -table $authorTable -partitionKey "john_papa" -rowKey (New-Guid) `
     -property @{Firstname = "John"; Lastname = "Papa"; Phone = "8790000807"; Email = "john_papa@psmail.com" }

Add-StorageTableRow  -table $authorTable -partitionKey "skonnard" -rowKey (New-Guid) `
     -property @{Firstname = "Aaron"; Lastname = "Skonnard"; Phone = "8790000808"; Email = "skonnard@psmail.com" }

Add-StorageTableRow  -table $authorTable -partitionKey "robertsjason" -rowKey (New-Guid) `
     -property @{Firstname = "Jason"; Lastname = "Roberts"; Phone = "8790000809"; Email = "robertsjason@psmail.com" }


Add-StorageTableRow  -table $authorTable -partitionKey "mcwoodring" -rowKey (New-Guid) `
     -property @{Firstname = "Mike"; Lastname = "Woodring"; Phone = "8790000810"; Email = "mcwoodring@psmail.com" }

Add-StorageTableRow  -table $authorTable -partitionKey "julielerman" -rowKey (New-Guid) `
     -property @{Firstname = "Julie"; Lastname = "Lerman"; Phone = "8790000811"; Email = "julielerman@psmail.com" }

Add-StorageTableRow  -table $authorTable -partitionKey "TheLoudSteve" -rowKey (New-Guid) `
     -property @{Firstname = "Steve"; Lastname = "Evans"; Phone = "8790000812"; Email = "TheLoudSteve@psmail.com" }





## Uploading the image files into storage account container

$containerName = "images"
New-AzureStorageContainer -Name $containerName -Context $ctx -Permission blob


Get-ChildItem -path $pathToDownloadImages -recurse | ?{$_.Extension -eq ".jpg"} |%{   `

Write-Host "Uploading  from " $_.FullName;  `

Set-AzureStorageBlobContent -File $_.FullName  -Container $containerName -Blob $_.Name -Context $ctx }


## Uploading the cloud service deployable files into storage account container

$containerName = "cloudservicedeployables"
New-AzureStorageContainer -Name $containerName -Context $ctx -Permission blob


Get-ChildItem -path $pathToCloudServiceDeployables -recurse | ?{$_.Extension -in (".cspkg",".cscfg")} |%{   `

Write-Host "Uploading  from " $_.FullName;  `

Set-AzureStorageBlobContent -File $_.FullName  -Container $containerName -Blob $_.Name -Context $ctx }




<#

#Create the storage account using ARM Template

$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName

$githubHandle = 'https://raw.githubusercontent.com/vlele/'

$templateUri = $githubHandle + 'csa_master_class/master/M1/Storage-Acct/Storage-Acct.json'

$templateParameterUri = $githubHandle + 'csa_master_class/master/M2/Cloud-Service/Storage-Acct.parameters.json'


 New-AzureRmResourceGroupDeployment -Name "Storage-Acct-Deployment" -ResourceGroupName $resourceGroupName -Mode Incremental `
 -TemplateUri $templateUri -TemplateParameterUri $templateParameterUri -Verbose
#>