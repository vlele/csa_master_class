# Service Fabric Demo Instructions

1) Unzip the solution file from the folder VS2015 or VS2017 based on Visual Studio version. 
   This demo has been originally extracted from the github repo (https://github.com/Azure-Samples/service-fabric-dotnet-getting-started)
2) Build the solution in Visual Studio
3) Right-Click on the GettingStartedApplication which is the Service Fabric project to publish the project
4) Deploying to the Local Cluster
	- Make sure the Service Fabric Local Cluster Manager is running
	- Point to the Local Cluster and publish based on configuration 
	- Verify the publish and local cluster set-up state at http://localhost:19080/Explorer/index.html#/
	- Test the application on localhost:8081  (8081 is the port exposed by the WebService from the Service Cluster)
											(OR)
5) Deploying to the Azure Service Fabric Cluster
	- Make sure the Service Fabric Cluster is Created
		~ To create a new cluster in publish there is an option <<Create new Cluster>> or <<Existing Cluster>>
	- Point to the Local Cluster and publish based on configuration 
	- Verify the publish and local cluster set-up state at <<Clusterurl>>:19080/Explorer/index.html#/
	- Test the application on <<ClusterUrl>>:8081  (8081 is the port exposed by the WebService from the Service Cluster)



Once all above steps are complete, remove the setup by running the script CloudService_Cleanupscript.ps1














