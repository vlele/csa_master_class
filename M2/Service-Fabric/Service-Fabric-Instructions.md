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


-------------------------------------------
Increaing the number of service replicas:
-------------------------------------------

6) To increase/decrease the number of replica instances, modify the xml configuration file in the ApplicationParameters folder of the service 'GettingStartedApplication'
	- In the demo we are changing the Local.1Node.xml file and increasing replica for 'StatelessBackendService_InstanceCount'
	- Republish the application
	- Check the number of counts in the CLuster Explorer

-------------------------------------------
Performing a Rolling Update:
-------------------------------------------

7) To perfrom a rolling update for the test purpose
	- Change the file Stateless.cshtml in 'WebService' project inside of the folder Views/Home
	- Right click on the 'GettingStartedApplication' service and perform 'Edit Manifest Versions'
	  Modify the versions for the 'WebServicePkg' and the 'GettingStartedApplicationType'
	- Rebuild the service application 'GettingStartedApplication'
	- To publish the application in the rolling upgrade, right click the service 'GettingStartedApplication' and publish
	  Make sure to select the 'Upgrade the Application' check-box while publishing (Not checking this box will result in a publish error)
	- Once the publish is successful, verify the new version upgrade in the CLuster Explorer
	- Check the application changed by accessing the url at localhost:8081 or <<ClusterUrl>>:8081 based on whether it is a local or Azure cluster
	  Verify the changes in the Stateless service
















