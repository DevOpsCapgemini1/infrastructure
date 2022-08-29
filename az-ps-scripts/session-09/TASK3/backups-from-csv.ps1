Connect-AzAccount

$conf = import-csv ".\parameters_backups.csv"
# Variables
$ResourceGroup=$conf.ResourceGroup
$AppName=$conf.AppName
$StorageName=$conf.StorageName
$Location=$conf.Location
$container=$conf.container
$PlanName=$conf.PlanName
$pricingTier=$conf.pricingTier
$SkuName = $conf.SkuName
# Create a Resource Group
New-AzResourceGroup -Name $ResourceGroup -Location $Location

# Create an App Service Plan
New-AzAppservicePlan -Name $PlanName -ResourceGroupName $ResourceGroup -Location $Location -Tier $pricingTier 

# Create a Web App in the App Service Plan
New-AzWebApp -Name $AppName -ResourceGroupName $ResourceGroup -Location $Location -AppServicePlan $PlanName

# Create Storage Account
$storage = New-AzStorageAccount -Name $StorageName -ResourceGroupName $ResourceGroup -Location $Location -SkuName $SkuName

# Get Connection String for Storage Account
$StorageKey=(Get-AzStorageAccountKey -ResourceGroupName $ResourceGroup -Name $StorageName).Value[0]

# Assign Connection String to App Setting 
Set-AzWebApp -ConnectionStrings @{ MyStorageConnStr = @{ Type="Custom"; Value="DefaultEndpointsProtocol=https;AccountName=$StorageName;AccountKey=$StorageKey;" } } -Name $AppName -ResourceGroupName $ResourceGroup

# Create a storage container.
New-AzStorageContainer -Name $container -Context $storage.Context

# Generates an SAS token for the storage container, valid for 1 year.
$sasUrl = New-AzStorageContainerSASToken -Name $container -Permission rwdl `
-Context $storage.Context -ExpiryTime (Get-Date).AddYears(1) -FullUri

# Schedule a backup every day, beginning in one hour, and retain for 10 days
Edit-AzWebAppBackupConfiguration -ResourceGroupName $ResourceGroup -Name $AppName `
-StorageAccountUrl $sasUrl -FrequencyInterval 1 -FrequencyUnit Day -KeepAtLeastOneBackup `
-StartTime (Get-Date).AddHours(1) -RetentionPeriodInDays 10