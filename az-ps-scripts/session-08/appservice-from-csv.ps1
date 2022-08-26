$conf = import-csv ".\appserviceConf.csv"

# https://docs.microsoft.com/en-us/powershell/module/az.websites/new-azwebapp?view=azps-8.2.0
# https://docs.microsoft.com/en-us/powershell/module/az.websites/?view=azps-8.2.0#app-service

$RG=$conf.RG
$aspName=$conf.aspName
$loc=$conf.loc
$price_tier=$conf.price_tier
$appName=$conf.appName
$NumberofWorkers=$conf.NumberofWorkers
$dockerImage=$conf.dockerImage
# New-AzAppServicePlan -ResourceGroupName $RG -Name $aspName -Location $loc -Tier $price_tier -NumberofWorkers $NumberofWorkers  -Linux
# New-AzWebApp -ResourceGroupName $RG -Name $appName -Location $loc -AppServicePlan $aspName -ContainerImageName $dockerImage

foreach ($confs in $conf) {
    New-AzAppServicePlan -ResourceGroupName $RG -Name $aspName -Location $loc -Tier $price_tier -NumberofWorkers $NumberofWorkers  -Linux
    New-AzWebApp -ResourceGroupName $RG -Name $appName -Location $loc -AppServicePlan $aspName -ContainerImageName $dockerImage

}