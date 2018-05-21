<#
------------
Description
------------

This script is used to set-up of Azure Network Watcher.
The script will do the below
	- Create a new resource group
	- Enable Network Watcher in the "East US" region

-------------
Dependencies
-------------

N/A

#>

# Create the Resource Group, At this time Network Watcher group must be below only

$resourceGroupName = 'NetworkWatcherRG'

$resourceGroup = New-AzureRmResourceGroup -Name $resourceGroupName -Location "EastUS" -Force -Verbose

# Enable the Network Watcher in East US region

$networkWatcher = New-AzureRmNetworkWatcher `
  -Name "NetworkWatcher_eastus" `
  -ResourceGroupName "NetworkWatcherRG" `
  -Location "East US"



