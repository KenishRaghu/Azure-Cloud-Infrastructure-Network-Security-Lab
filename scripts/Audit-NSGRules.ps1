# Lists NSGs in the lab RG and flags overly permissive inbound rules (Any source, Allow).
param(
    [string]$ResourceGroupName = "rg-netsec-lab"
)

Get-AzNetworkSecurityGroup -ResourceGroupName $ResourceGroupName | ForEach-Object {
    $nsg = $_
    foreach ($rule in $_.SecurityRules | Where-Object { $_.Direction -eq "Inbound" -and $_.Access -eq "Allow" }) {
        if ($rule.SourceAddressPrefix -match '^\*|Any|Internet|0\.0\.0\.0/0$') {
            Write-Warning "[$($nsg.Name)] $($rule.Name): broad source $($rule.SourceAddressPrefix) on port(s) $($rule.DestinationPortRange)"
        }
    }
}
