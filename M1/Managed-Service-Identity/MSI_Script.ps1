<#
This script if for testing the Managed Service Identity feature and requires below activities before running the script.
Some of the values are hardcoded in the script for demo purposes.

1) Create a container named 'test' in the storage account 'm1diagaccount'
2) Assign the MSI enabled VM ('m1-VM1' is enabled for this example) the role 'Storage Account Contributor' to the storage account 'm1diagaccount'
3) Provide values for the subscription-id in script below
#>


$subscriptionId = ""


Install-Module Azure.Storage


## Get the token to access the Azure Resource Manager using the MSI extension local hosted endpoint

$response = Invoke-WebRequest -Uri http://localhost:50342/oauth2/token -Method GET -Body @{resource="https://management.azure.com/"} -Headers @{Metadata="true"}


Write-Output $response


$content = $response.Content | ConvertFrom-Json

$ArmToken = $content.access_token

Write-Output $ArmToken


## Get the SAS token for the storage accout using the token generated for the Azure Resource Manager

$params = @{canonicalizedResource="/blob/m1diagaccount/test";
            signedResource="c";
            signedPermission="rcw";
            signedProtocol="https";
            signedExpiry="2018-12-23T00:00:00Z"}

$jsonParams = $params | ConvertTo-Json

Write-Output $jsonParams

$storageAccountUriWithPlaceHolder = "https://management.azure.com/subscriptions/<subscription-id>/resourceGroups/m1-AzureIaaSEssentials/providers/Microsoft.Storage/storageAccounts/m1diagaccount/listServiceSas/?api-version=2017-06-01"

$storageAccountUri = $storageAccountUriWithPlaceHolder.Replace("<subscription-id>",$subscriptionId)

$sasResponse = Invoke-WebRequest -Uri $storageAccountUri -Method POST -Body $jsonParams -Headers @{Authorization="Bearer $ArmToken"}

$sasContent = $sasResponse.Content | ConvertFrom-Json
$sasCred = $sasContent.serviceSasToken

Write-Output $sasCred

##Use the SAS Credential to access the Storage account


#create Sample file
echo "This is a test text file." > test.txt


#upload sample file to storage

$ctx = New-AzureStorageContext -StorageAccountName m1diagaccount -SasToken $sasCred
Set-AzureStorageBlobContent -File test.txt -Container test -Blob testblob -Context $ctx

#download sample file from storage

Get-AzureStorageBlobContent -Blob testblob -Container test -Destination test2.txt -Context $ctx

