#
# Deploy an ARM template to a uniquely named resource group
#
# This script is primarily used for testing of new ARM templates
# to allow repeated deployment of the template to a new resource
# group to test for correct operation of the new template.
#
#Login-AzureRmAccount

$iterator = 1
$resourceGroupCreated = $false
$resourcegroupName = ""
$projectName = ""
$locationCode = "eun"
$location = "North Europe"

while (!$resourceGroupCreated) {
    $projectName = (Get-Date -Format FileDate).Substring(2) + "-" + ('0' * (2 - $iterator.ToString().length)) + $iterator
    $resourceGroupName = "t-rgp-eun-" + $projectName
    $resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
    if ($resourceGroup -eq $null)
    {
        Write-Host "Creating resource group $resourceGroupName"
        New-AzureRmResourceGroup -Location $location -Name $resourceGroupName -Tag @{disposable=$true;projectName=$projectName;environment="test"}
        $resourceGroupCreated = $true
    }
    $iterator ++;
}

New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile st-parameters.json -location $locationCode -projectName $projectName -Name ("deployment-" + $resourceGroupName)