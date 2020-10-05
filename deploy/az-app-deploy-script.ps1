# script reference
# https://docs.microsoft.com/en-us/azure/service-fabric/scripts/service-fabric-powershell-deploy-application

$ClusterName= "sf-ug1-nt2.centralindia.cloudapp.azure.com:19000"
$Certthumprint = "C58C1042CC448BE67EB69A279245D02C2CC0B4D3"
$packagepath="D:\cases\120092726000230-Feng\SampleApp\DataLossCheckApp\pkg\Debug"

Connect-ServiceFabricCluster -ConnectionEndpoint $ClusterName -KeepAliveIntervalInSec 10 `
     -X509Credential `
     -ServerCertThumbprint $Certthumprint  `
     -FindType FindByThumbprint `
     -FindValue $Certthumprint `
     -StoreLocation CurrentUser `
     -StoreName My

# Copy the application package to the cluster image store.
Copy-ServiceFabricApplicationPackage $packagepath -ImageStoreConnectionString fabric:ImageStore -ApplicationPackagePathInImageStore DataLossCheckApp

# Register the application type.
Register-ServiceFabricApplicationType -ApplicationPathInImageStore DataLossCheckApp

# Create the application instance.
New-ServiceFabricApplication -ApplicationName fabric:/DataLossCheckApp -ApplicationTypeName DataLossCheckAppType -ApplicationTypeVersion 1.0.0

# Remove the application package to free system resources.
Remove-ServiceFabricApplicationPackage -ImageStoreConnectionString fabric:ImageStore -ApplicationPackagePathInImageStore DataLossCheckApp




