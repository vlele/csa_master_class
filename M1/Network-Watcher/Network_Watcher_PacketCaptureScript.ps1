<#
------------
Description
------------

This script is used to set-up of the Traffic Capture feature of the Azure Network Watcher.
The script will do the below
	- Get the Azure VM (The AzureNetworkWatcherExtension extension is already set-up as part of the VM set-up)
	- Get the Network Watcher in the "East US" region
	- Enable packet capture for one of the VM's (The extension is already set-up as part of the VM set-up)

-------------
Dependencies
-------------

1) The Virtal-Machines.ps1 should be run before this script
2) The Network_Watcher_Setupscript.ps1 should be run before this script

#>

# Get the Network Watcher for the East US region

$nw = Get-AzurermResource | Where {$_.ResourceType -eq "Microsoft.Network/networkWatchers" -and $_.Location -eq "eastus" }

$networkWatcher = Get-AzureRmNetworkWatcher -Name $nw.Name -ResourceGroupName $nw.ResourceGroupName

# Create a resource group and storage account for this account

$resourceGroup = New-AzureRmResourceGroup -Name 'm1-NewtworkWatcher' -Location "EastUS" -Force -Verbose

$storageAccount = New-AzureRmStorageAccount -ResourceGroupName 'm1-NewtworkWatcher' -Name 'm1networkwatcher' `
					-Location $resourceGroup.Location  -SkuName Standard_LRS   -Kind Storage 


# Get the VM details

$vmName = 'm1-VM1'
$vmResourceGroup = 'm1-AzureIaaSEssentials'

$VM = Get-AzureRmVM -ResourceGroupName $vmResourceGroup -Name $vmName

# Create the Network Traffic Capture

$filter1 = New-AzureRmPacketCaptureFilterConfig -Protocol TCP
$filter2 = New-AzureRmPacketCaptureFilterConfig -Protocol UDP

# Below example shows additional values which can be configured
# $filter3 = New-AzureRmPacketCaptureFilterConfig -Protocol TCP -RemoteIPAddress "1.1.1.1-255.255.255" -LocalIPAddress "10.0.0.3" -LocalPort "1-65535" -RemotePort "20;80;443"


New-AzureRmNetworkWatcherPacketCapture -NetworkWatcher $networkWatcher -TargetVirtualMachineId $VM.Id -PacketCaptureName "PacketCaptureTest" -StorageAccountId $storageAccount.id -TimeLimitInSeconds 60 -Filter $filter1, $filter2



