$conf = import-csv ".\parameters_storage_acc.csv"
$ResourceGroup='myXResourceGroup'
$Location=$conf.location
# Create a Resource Group
New-AzResourceGroup -Name $ResourceGroup -Location $Location -Force

# Create Storage Account
$Random=(New-Guid).ToString().Substring(0,8)
$StorageName=$conf.storageName
$PricingTier=$conf.pricingTier
$SkuName = $conf.SkuName
New-AzStorageAccount -Name $StorageName -ResourceGroupName $ResourceGroup -Location $Location -AccessTier $PricingTier -SkuName $SkuName