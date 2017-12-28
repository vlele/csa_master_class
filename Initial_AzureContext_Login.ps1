<#
-------------
Description:
-------------

This powershell script is for setting up the environment for CSA Master Class. 
All the nest set of steps should be run after the user has run this script for setting the environment.

As part of this script, Users need to update the script variables subscriptionid and tenantid with the actual environments from the Azure Portal.

--------------
Inputs Needed:
--------------

1) Subscription Id --> Select the subscription Id from the subscriptions pane in the Azure portal. 
                        (This is mainly done in environments where users have multiple subscriptions)


2) Tenant Id --> This is the id of the Azure Active Directory(AAD) and can be got from the properties inside the AAD

#>


$subscriptionId = 'SUBSCRIPTION ID'
$tenantId = 'TENANT ID OR AZURE ACTIVE DIRECTORY ID'

Login-AzureRmAccount


Set-AzureRmContext -SubscriptionId $subscriptionId -TenantId $tenantId