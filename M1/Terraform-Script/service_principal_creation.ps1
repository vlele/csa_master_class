#The below command is for the creation of service principal
#To create a service principal, replace <<Subscription ID>> with the scope of the subscription
#Run the same using Azure CLI


    az ad sp create-for-rbac --role Contributor --scopes /subscriptions/<<Subscription ID>>


#This command will output the Subscription ID, Application ID, Application Password and Tenant ID.
#Note these and use in the other scripts