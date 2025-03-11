# Run order

1. Sign in: `Connect-AzAccount`, pick the right subscription with `Set-AzContext`.
2. Network: run `New-LabNetwork.ps1` once per environment.
3. VM: run `Deploy-LabVM.ps1` and store credentials somewhere safe (password manager, not the repo).
4. Audit: run `Audit-NSGRules.ps1` after any rule change; tighten rules called out by the script.

# Notes

- Tear down the RG when the lab is done to avoid leftover cost: `Remove-AzResourceGroup -Name rg-netsec-lab -Force`.
