<#
------------
Description
------------

This script is used to perform the configuration for the Virtual Network Gateway
Setting-up of the VPN Client Address Pool and Root Cerificate is all done in this script 
The template and the parameters are being referred from the repository as mentioned in the below variables templateUri & templateParameterUri

-------------
Dependencies
-------------

1) The VNET-Gateway.ps1 script should be run before this script. This is the VNET Gateway which is configured

--------------
Inputs Needed:
--------------

1) filePathForCert --> Provide the place where the RootCertificate resides. A Self Signed certificate is also present in the github folder


#>



$filePathForCert = "C:\cert\P2SRootCert.cer"


$resourceGroupName = 'm1-AzureIaaSEssentials'

$GWName = 'm1-VNETGW'

# Adding VPN Client Address pool

$VPNClientAddressPool = "172.16.201.0/24"

$Gateway = Get-AzureRmVirtualNetworkGateway -ResourceGroupName $resourceGroupName -Name $GWName

Set-AzureRmVirtualNetworkGateway -VirtualNetworkGateway $Gateway -VpnClientAddressPool $VPNClientAddressPool

#Adding the public key of the root certificate to VNET Gateway

$P2SRootCertName = "P2SRootCert.cer"

$cert = new-object System.Security.Cryptography.X509Certificates.X509Certificate2($filePathForCert)
$CertBase64 = [system.convert]::ToBase64String($cert.RawData)
$p2srootcert = New-AzureRmVpnClientRootCertificate -Name $P2SRootCertName -PublicCertData $CertBase64


Add-AzureRmVpnClientRootCertificate -VpnClientRootCertificateName $P2SRootCertName -VirtualNetworkGatewayname $GWName -ResourceGroupName $resourceGroupName -PublicCertData $CertBase64