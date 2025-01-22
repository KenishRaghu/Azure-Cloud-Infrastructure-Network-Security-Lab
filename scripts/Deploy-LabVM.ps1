# Deploys a single Windows lab VM into the app subnet with the NSG attached.
param(
    [string]$ResourceGroupName = "rg-netsec-lab",
    [string]$Location = "eastus",
    [string]$VmName = "vm-lab-app01",
    [string]$AdminUser = "labadmin"
)

$vnet = Get-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Name "vnet-lab"
$subnet = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name "subnet-app"
$nsg = Get-AzNetworkSecurityGroup -ResourceGroupName $ResourceGroupName -Name "nsg-app"

$nic = New-AzNetworkInterface -ResourceGroupName $ResourceGroupName -Location $Location `
    -Name "$VmName-nic" -SubnetId $subnet.Id -NetworkSecurityGroupId $nsg.Id

$cred = Get-Credential -Message "Local admin password for $VmName"
$vmConfig = New-AzVMConfig -VMName $VmName -VMSize "Standard_B2s" | `
    Set-AzVMOperatingSystem -Windows -ComputerName $VmName -Credential $cred | `
    Set-AzVMSourceImage -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" `
    -Skus "2022-Datacenter" -Version "latest" | `
    Add-AzVMNetworkInterface -Id $nic.Id

New-AzVM -ResourceGroupName $ResourceGroupName -Location $Location -VM $vmConfig
