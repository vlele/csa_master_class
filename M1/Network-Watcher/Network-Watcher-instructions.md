# Network Watcher Instructions

1) Run the script Network_Watcher_Setupscript.ps1 (This will enable the Network Watcher in the region)
2) Go to the Azure portal(portal.azure.com) and Search for Network Watcher
3) In Network Watcher --> Select Topology
   Select Azure Subscription, Resource Group, Virtual Network 
   
   This displays the network layout for the selected Virtal Network in a pictorial form 
4) To Demo the Packet Capture scenario, run the script 'Network_Watcher_PacketCaptureScript.ps1'
5) Verify that the resources are actually provisioned in the Azure Portal


Once all above steps are complete, remove the setup by running the script Network_Watcher_Cleanupscript.ps1














