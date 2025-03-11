# Lab layout

- Resource group holds one VNet (`10.0.0.0/16`), an application subnet, and NSGs tied to the subnet/NIC.
- Windows Server VM sits in the app subnet; NSG blocks direct RDP from the Internet by default.
- Azure Firewall or extra NSG rules can be added the same way when you extend the lab.

# Monitoring

Use Azure Monitor network insights or NSG flow logs if you turn them on in the subscription—good for checking what traffic actually hits the NSGs.
