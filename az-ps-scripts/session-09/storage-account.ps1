$ResourceGroup='myXResourceGroup'
$Location="West Europe"
# Create a Resource Group
New-AzResourceGroup -Name $ResourceGroup -Location $Location

# Create Storage Account
$Random=(New-Guid).ToString().Substring(0,8)
$StorageName="webappstorage$Random"
$PricingTier='Hot'

New-AzStorageAccount -Name $StorageName -ResourceGroupName $ResourceGroup -Location $Location -AccessTier $PricingTier