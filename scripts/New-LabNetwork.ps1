# Requires Az.Network module. Creates a resource group, VNet, subnets, and baseline NSGs for the lab.
param(
    [string]$ResourceGroupName = "rg-netsec-lab",
    [string]$Location = "eastus"
)

New-AzResourceGroup -Name $ResourceGroupName -Location $Location -Force | Out-Null

$subnetConfig = New-AzVirtualNetworkSubnetConfig -Name "subnet-app" -AddressPrefix "10.0.1.0/24"
$vnet = New-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Location $Location `
    -Name "vnet-lab" -AddressPrefix "10.0.0.0/16" -Subnet $subnetConfig

$ruleRdp = New-AzNetworkSecurityRuleConfig -Name "Deny-RDP-Internet" -Description "Block RDP from Internet" `
    -Access Deny -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet `
    -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389

$nsg = New-AzNetworkSecurityGroup -ResourceGroupName $ResourceGroupName -Location $Location -Name "nsg-app" `
    -SecurityRules $ruleRdp

Write-Host "VNet $($vnet.Name) and NSG $($nsg.Name) ready in $ResourceGroupName."
