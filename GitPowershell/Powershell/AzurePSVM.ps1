Login-AzureRmAccount

New-AzureRmResourceGroup -Name "Azure-PowerShell" -Location "centralUs"

$rg = Get-AzureRmResourceGroup -Name "Azure-Powershell"

$rg

$subnetConfig = New-AzureRmVirtualNetworkSubnetConfig -Name "subnet-win" -AddressPrefix "10.1.2.0/24" 

$vnet = New-AzureRmVirtualNetwork -Name "vnet-win" -ResourceGroupName $rg.ResourceGroupName -Location $rg.Location -AddressPrefix "10.1.0.0/16" -Subnet $subnetConfig

$vnet

$pip = New-AzureRmPublicIpAddress -Name "pip-win" -ResourceGroupName $rg.ResourceGroupName -Location $rg.Location -AllocationMethod Static

$pip

$rule1 = New-AzureRmNetworkSecurityRuleConfig -Name "nsg-rdp" -Protocol Tcp -SourcePortRange "*" -SourceAddressPrefix "*" -DestinationPortRange "3389" -DestinationAddressPrefix "*" -Direction Inbound -Priority 1000 -Access Allow

$rule2 = New-AzureRmNetworkSecurityRuleConfig -Name "nsg-http" -Protocol Tcp -SourcePortRange "*" -SourceAddressPrefix "*" -DestinationPortRange "80" -DestinationAddressPrefix "*" -Direction Inbound -Priority 1001 -Access Allow

$nsg = New-AzureRmNetworkSecurityGroup -Name "nsg-win" -ResourceGroupName $rg.ResourceGroupName -Location $rg.Location -SecurityRules $rule1, $rule2

$subnet = $vnet.Subnets | Where-Object {$_.Name -eq "subnet-win"}

$subnet

$nic = New-AzureRmNetworkInterface -Name "nic-win" -ResourceGroupName $rg.ResourceGroupName -Location $rg.Location -Subnet $subnet -PublicIpAddress $pip -NetworkSecurityGroup $nsg

$pwd = ConvertTo-SecureString "January@2017" -AsPlainText -Force

$cred = New-Object System.Management.Automation.PSCredential ("mwalia",$pwd)

$VM = New-AzureRmVMConfig -VMName "vm-win" -VMSize "Standard_D3" 
$vm = Set-AzureRmVMOperatingSystem -VM $VM -Windows -ComputerName "vm-win" -Credential $cred -ProvisionVMAgent -EnableAutoUpdate
$vm = Add-AzureRmVMNetworkInterface -VM $VM -Id $nic.Id
$vm = Set-AzureRmVMSourceImage -VM $VM -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus "2012-R2-Datacenter" -Version "latest"
New-AzureRmVM -ResourceGroupName $rg.ResourceGroupName -Location $rg.Location -VM $vm