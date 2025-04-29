# Azure Cloud Infrastructure & Network Security Lab

January 2025 – April 2025

Small Azure networking lab: a VNet and subnet, a network security group (NSG) with a deny-RDP-from-Internet rule, PowerShell to deploy those pieces plus a Windows Server VM, and a helper script to spot inbound rules that are too open.

**Repo layout**

| Path | Purpose |
|------|---------|
| `scripts/New-LabNetwork.ps1` | Creates the resource group, VNet, app subnet, and NSG. Run this first. |
| `scripts/Deploy-LabVM.ps1` | Creates a NIC (with the NSG) and a Windows Server 2022 VM in the subnet. Run after the network exists. |
| `scripts/Audit-NSGRules.ps1` | Prints warnings for inbound “Allow” rules with very broad sources. Run anytime after resources exist. |
| `docs/architecture.md` | Sketch of how the pieces fit together. |
| `docs/procedures.md` | Same run order and teardown notes in short form. |

---

## Prerequisites

- Windows PowerShell 5.1 or PowerShell 7+, or Azure Cloud Shell.
- An Azure subscription where you can create VMs (charges apply).
- [Azure Az modules](https://learn.microsoft.com/powershell/azure/install-azure-powershell) installed locally:

```powershell
Install-Module Az -Scope CurrentUser -Repository PSGallery -Force
```

If scripts won’t run, allow them for the session:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

---

## How to run

1. **Sign in** and pick the subscription you want to use:

```powershell
Connect-AzAccount
Get-AzSubscription
Set-AzContext -SubscriptionId "<your-subscription-id>"
```

2. **From this repo’s folder**, create the network stack (defaults: RG `rg-netsec-lab`, region `eastus`):

```powershell
.\scripts\New-LabNetwork.ps1
```

Optional overrides:

```powershell
.\scripts\New-LabNetwork.ps1 -ResourceGroupName "rg-netsec-lab" -Location "eastus"
```

3. **Deploy the VM** (expects RG name `rg-netsec-lab`, VNet `vnet-lab`, subnet `subnet-app`, NSG `nsg-app` from step 2):

```powershell
.\scripts\Deploy-LabVM.ps1
```

You’ll be prompted for the VM’s local admin password. Optional overrides:

```powershell
.\scripts\Deploy-LabVM.ps1 -VmName "vm-lab-app01" -AdminUser "labadmin" -Location "eastus"
```

4. **Audit NSGs** in that resource group:

```powershell
.\scripts\Audit-NSGRules.ps1
```

---

## Cleanup

When you’re done to avoid ongoing cost:

```powershell
Remove-AzResourceGroup -Name "rg-netsec-lab" -Force -AsJob
```

(Adjust the name if you used a different `-ResourceGroupName`.)

---

## Lab highlights

- Deployed Microsoft Azure resources including VMs, NSGs, and firewall rules for a secure lab environment
- Automated infrastructure provisioning and configuration management using PowerShell scripts
- Audited firewall configurations and network security policies to identify and remediate vulnerabilities
- Created technical documentation covering system architecture, procedures, and monitoring dashboards
