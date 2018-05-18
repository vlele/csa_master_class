# Cloud Service Instructions

1) Run the script CloudService_Initial_AzureContext_Login.ps1 (This will set the initial AzureRM Context)
2) Run the script CloudService_Initial_DataSetup.ps1 (This script does the initial set-up for the data required inside of the cloud service)
3) Verify that the storage account is created and it has a blob container, azure table
4) Run the script CloudService_CreationAndDeployment.ps1 (This script will deploy the Cloud Service)
5) Verify the cloud service is deployed and update the config in cloud service to test the same
	Config Updates: (Cloud Service --> Configuration)
	- Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString (This value is the connection string of the storage account created in the CloudService_Initial_DataSetup.ps1 script )
	- StorageAccount.ConnectionString (This value is the connection string of the storage account created in the CloudService_Initial_DataSetup.ps1 script )
	- CloudServiceIP (This is the Public IP address of the cloud service)
6) Test the cloud Service


Once all above steps are complete, remove the setup by running the script CloudService_Cleanupscript.ps1














