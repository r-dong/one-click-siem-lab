# Outputs the name of the deployed virtual machine
output "vm_name" {
  description = "Name of the deployed virtual machine"
  value       = azurerm_windows_virtual_machine.vm.name
}

# Outputs the public IP address to access the honeypot VM externally (RDP, etc.)
output "public_ip_address" {
  description = "Public IP address of the VM"
  value       = azurerm_public_ip.public_ip.ip_address
}

# Outputs the private IP address assigned within the virtual network
output "private_ip_address" {
  description = "Private IP address of the VM (NIC)"
  value       = azurerm_network_interface.nic.private_ip_address
}

# Outputs the name of the resource group (useful for scripting and teardown)
output "resource_group_name" {
  description = "Name of the resource group created for the lab"
  value       = azurerm_resource_group.rg.name
}
