# Terraform script Instructions

1) Create a new empty folder and Download the Terraform executable from the link https://www.terraform.io/downloads.html 
2) Follow the 'Install Terraform' section from the link https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure
3) Run the script service_principal_creation.ps1. 
   This can also be run from the Azure Portal if Azure CLI is not installed locally
4) Update the testscript-vmcreation.tf with Subscription ID, Application ID, Application Password and Tenant ID
   These values are output from step 3 
5) Open a powershell ISE and change the directory to where the testscript-cmcreation.tf file resides
6) Initiate the terraform process using below commands
    
	terraform init  --> Initiates and gets the required libraries for the provider(in this case 'azurerm')
	terraform plan  --> Generates a plan based on the terrafrom script in the file (testscript-vmcreation.tf)
	terraform apply --> Deploys the actual resources on Azure
	                   (or)
	Terraform apply -auto-approve --> Deploys the actual resoruces on Azure but does not prompt for confirmation

7) Verify that the resources are actually provisioned in the Azure Portal


Once all above steps are complete, remove the setup by running the script Terraform_Cleanupscript.ps1














