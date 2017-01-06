#
# PowerShell script to delete all resource groups created by the "deploy" testing script
#

$resourceGroupsToDelete = Find-AzureRmResourceGroup -Tag @{disposable=$true} -ErrorAction SilentlyContinue
if ($resourceGroupsToDelete.Count -eq 0)
{
    Write-Host "No resources groups found for cleanup"
}
else
{
    $warningMessage = " This script will delete the following resource groups and all resources within those resource groups. "
    Write-Host
    Write-Host ('*' * $warningMessage.Length) -BackgroundColor Red -ForegroundColor White
    Write-Host $warningMessage -BackgroundColor Red -ForegroundColor White
    Write-Host ('*' * $warningMessage.Length) -BackgroundColor Red -ForegroundColor White
    Write-Host
    ForEach($resourceGroup in $resourceGroupsToDelete)
    {
        Write-Host "- " $resourceGroup.Name -ForegroundColor Green
    }
    Write-Host
    $confirm = ""
    while ($confirm.ToLower() -ne "y" -and $confirm.ToLower() -ne "n") {
        $confirm = Read-Host "Do you wish to proceed? (Y)es or (N)o"
    }

    if ($confirm -eq "y")
    {
        ForEach($resourceGroup in $resourceGroupsToDelete)
        {
            Write-Progress -Activity "Removing Resource Groups" -PercentComplete ((100/$resourceGroupsToDelete.Count)*$iterator) -Status $resourceGroup.Name
            Remove-AzureRmResourceGroup -Force -Name $resourceGroup.Name
            $iterator ++
        }
    }
    else 
    {
        Write-Host "Script terminated. No resource groups were deleted."
    }
}