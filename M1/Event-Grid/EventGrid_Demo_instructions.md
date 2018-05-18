# EventGrid Demo Instructions

1) For this demo, we will be routing the generated events to Hookbin. This will have a unique URL which will be used as subscriber for event grid
   - Goto the url 'https://hookbin.com/' and click "Create New Endpoint"
   - Note the endpoint and update in the EventGrid_Demo_Script.cli
							(or)
   Incase the Hookbin does not work, do the below
   - Create an Azure Function App
   - Create an Azure Function of type "Event Grid Trigger"
   - Go to the created function --> Integrate --> Event Grid Subscription URL
   - Note this URL and EventGrid_Demo_Script.cli
2) Update the variables <<Subscription-ID>> and <<End Point Url>> in the script file EventGrid_Demo_Script.cli
3) Run the script EventGrid_Demo_Script.cli using Azure CLI. 
4) Verify that the resources are created 
5) Verify that an event was triggered when file was uploaded.
   Incase of Webhook --> Refresh the link, the event should show up
   Incase of Azure Function --> The default implementation writes to Log. Event triggered can be checked there.
6) Verify the Event Grid setup in the Azure Blob Storage in the Azure Portal


Once all above steps are complete, remove the setup by running the script EventGrid_Cleanup_Script.cli














