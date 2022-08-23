# https://docs.microsoft.com/en-us/powershell/module/az.websites/new-azwebapp?view=azps-8.2.0
# https://docs.microsoft.com/en-us/powershell/module/az.websites/?view=azps-8.2.0#app-service

$RG='Default-Web-WestEU'
$aspName='myASP'
$loc='westeurope'
$price_tier='Basic'
$appName='myRareNameWebApp'
New-AzAppServicePlan -ResourceGroupName $RG -Name $aspName -Location $loc -Tier $price_tier -NumberofWorkers 2  -Linux
New-AzWebApp -ResourceGroupName $RG -Name $appName -Location $loc -AppServicePlan $aspName -ContainerImageName mcr.microsoft.com/dotnet/samples:aspnetapp 