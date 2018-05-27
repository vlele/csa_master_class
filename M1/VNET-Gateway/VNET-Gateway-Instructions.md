# Network Gateway Instructions

1) Run the script VNET-Gateway.ps1(This will create the VNET Gateway)
2) Either run the script Creation of Self Signed Certificates.ps1 (This will create root certficate and client certificate)
											(OR)
   Self signed certificates are present as part of this repository also (rootcertificate.cer and clientcert.pfx)
						
3) Run the VNET-Gateway-Configuration.ps1 script for the Gateway configuration

4) Verify that the resources are actually provisioned in the Azure Portal
    
5) Goto Azure portal and get the VPN client
	Azure portal --> VNET Gateway --> Point-to-Site Configuration --> Download VPN Client

6) Install the VPN Client downloaded based on the instructions in the link (https://docs.microsoft.com/en-us/azure/vpn-gateway/point-to-site-vpn-client-configuration-azure-cert)

7) To Connect to a Azure VNET from windows machine 
		VPN Connections --> Name of VNET --> Connect

8) Do a ipconfig on the machine to check that the machine has the IP address assigned from the Client Address Pool
		

Once all above steps are complete, leave the resources as it is.
The resources will be deleted at the end of M1 module with script 'Iaas_Essentials_Cleanupscript.ps1'
