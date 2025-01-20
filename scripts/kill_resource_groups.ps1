$resource_groups = az group list --query "[].name" -o tsv

Write-Host "Resource Groups Detected: " -fore yellow

$resource_groups

Write-Output "----------------------"

foreach ($group in $resource_groups) {
    Write-Host "Deleting...$group" -fore red
    az group delete --name $group --yes --no-wait
}

Write-Output "----------------------"
Write-Host "All resource-groups are deleted." -fore green