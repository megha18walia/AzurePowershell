Login-AzureRmAccount

Get-AzureRmVm -ResourceGroupName "Azure-Powershell" -Status

$rg = Get-AzureRmResourceGroup -Name "Azure-Powershell"

$rg

$vm = Get-Azurermvm -Name "vm-win" -ResourceGroupName $rg.ResourceGroupName

$vm


Stop-AzureRmVM -Name $vm.Name -ResourceGroupName $rg.ResourceGroupName

get-azurermvm -ResourceGroupName "Azure-Powershell" -name "vm-win" -Status

set-azurermvm -ResourceGroupName "Azure-Powershell" -name "vm-win" -Generalized

$imageconfig = New-AzureRmImageConfig -Location $rg.Location -SourceVirtualMachineId $vm.Id

New-AzureRmImage -ResourceGroupName "Azure-Powershell" -Image $imageconfig -ImageName "Image-Powershell"

Get-AzureRmImage -ResourceGroupName "Azure-Powershell"

$password = ConvertTo-SecureString "January@2017" -AsPlainText -Force

$cred = New-Object System.Management.Automation.PSCredential("mwalia", $password)

New-AzureRmVm -ResourceGroupName $rg.ResourceGroupName -Location $rg.Location -Name "Image-VM-PS" -Image "Image-Powershell" -VirtualNetworkName "vnet-PS" -SubnetName "Sunbet-ps" -SecurityGroupName "NSG" -OpenPorts 3389 -Credential $cred 
