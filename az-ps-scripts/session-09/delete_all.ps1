$RGNAME='MyResourceGroup921'
$resources = @( Get-AzResource -ResourceGroupName $RGNAME )

$len = $resources.Length

$resources = @( $resources.Id )

for (($i = 0); $i -lt $len; $i++)
{
    Remove-AzResource -ResourceId $resources[$i] -Force
}

$remaining_resources = @( Get-AzResource -ResourceGroupName $RGNAME )

$len = $remaining_resources.Length

$remaining_resources = @( $remaining_resources.Id )

for (($j = 0); $j -lt $len; $j++)
{
    Remove-AzResource -ResourceId $remaining_resources[$j] -Force
}
