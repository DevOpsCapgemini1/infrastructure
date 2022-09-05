Connect-AzAccount -TenantId 5d26cd72-b7b5-410d-969c-0b980709fdf6

$conf = import-csv ".\parameters_backups.csv"
$schedule = import-csv ".\backup_schedule.csv"

$ResourceGroup=$conf.ResourceGroup
$AppName=$conf.AppName
$StorageName=$conf.StorageName
$Location=$conf.Location
$container=$conf.container
$PlanName=$conf.PlanName
$pricingTier=$conf.pricingTier
$SkuName = $conf.SkuName
$FrequencyInterval = $schedule.FrequencyInterval
$RetentionPeriodInDays = $schedule.RetentionPeriodInDays
$FrequencyUnit = $schedule.FrequencyUnit
# Create a Resource Group
New-AzResourceGroup -Name $ResourceGroup -Location $Location


New-AzAppservicePlan -Name $PlanName -ResourceGroupName $ResourceGroup -Location $Location -Tier $pricingTier 


New-AzWebApp -Name $AppName -ResourceGroupName $ResourceGroup -Location $Location -AppServicePlan $PlanName


$storage = New-AzStorageAccount -Name $StorageName -ResourceGroupName $ResourceGroup -Location $Location -SkuName $SkuName


$StorageKey=(Get-AzStorageAccountKey -ResourceGroupName $ResourceGroup -Name $StorageName).Value[0]


Set-AzWebApp -ConnectionStrings @{ MyStorageConnStr = @{ Type="Custom"; Value="DefaultEndpointsProtocol=https;AccountName=$StorageName;AccountKey=$StorageKey;" } } -Name $AppName -ResourceGroupName $ResourceGroup


New-AzStorageContainer -Name $container -Context $storage.Context


$sasUrl = New-AzStorageContainerSASToken -Name $container -Permission rwdl `
-Context $storage.Context -ExpiryTime (Get-Date).AddYears(1) -FullUri


Edit-AzWebAppBackupConfiguration -ResourceGroupName $ResourceGroup -Name $AppName `
-StorageAccountUrl $sasUrl -FrequencyInterval $FrequencyInterval -FrequencyUnit $FrequencyUnit -KeepAtLeastOneBackup `
-StartTime (Get-Date).AddHours(1) -RetentionPeriodInDays $RetentionPeriodInDays
