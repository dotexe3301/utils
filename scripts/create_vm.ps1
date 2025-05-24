$vmType = Read-Host "Enter VM type (linux/windows)"
$vmType = $vmType.ToLower()

$resourceGroup = "rg-$vmType-vm"
$location = "centralindia"
$adminUsername = "azureuser"
$randomId = Get-Random -Maximum 99

$adminPassword = ([char[]]([char[]]'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%') | Get-Random -Count 12) -join ''

if ($vmType -eq "linux") {
    $sku = "Standard_B1s"
    $image = "Ubuntu2404"
    $vmName = "linuxVM$randomId"
} elseif ($vmType -eq "windows") {
    $sku = "Standard_B2s"
    $image = "Win2019Datacenter"
    $vmName = "windowsVM$randomId"
} else {
    Write-Host "Invalid VM type. Please enter 'linux' or 'windows'."
    exit
}

$rgExists = az group exists --name $resourceGroup | ConvertFrom-Json
if (-not $rgExists) {
    az group create --name $resourceGroup --location $location | Out-Null
} else {
    Write-Host "Resource group '$resourceGroup' already exists." -fore Gray
}

$vmCreateOutput = az vm create `
  --resource-group $resourceGroup `
  --name $vmName `
  --image $image `
  --admin-username $adminUsername `
  --admin-password $adminPassword `
  --authentication-type password `
  --size $sku `
  --location $location `
  --output json

$vmInfo = $vmCreateOutput | ConvertFrom-Json
$publicIp = $vmInfo.publicIpAddress

Write-Host "`nResource Group Name: $resourceGroup" -fore Cyan
Write-Host "VM Name: $vmName" -fore Green
Write-Host "VM IP Address: $publicIp"-fore Green
Write-Host "VM Username: $adminUsername"
Write-Host "VM Password: $adminPassword"
