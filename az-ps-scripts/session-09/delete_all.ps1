$RG_NAME='testing'

get-AZresource -ResourceGroupName $RG_NAME | Remove-AzResource -Force