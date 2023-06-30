##########################
## Azure Linux - Output ##
##########################

output "host_vm_name" {
  description = "Virtual Machine name"
  value       = azurerm_linux_virtual_machine.host-vm.name
}

output "target_vm_name" {
  description = "Virtual Machine name"
  value       = azurerm_linux_virtual_machine.target-vm.name
}

output "host_vm_ip_address" {
  description = "Virtual Machine name IP Address"
  value       = azurerm_public_ip.host-vm-ip.ip_address
}

output "target_vm_ip_address" {
  description = "Virtual Machine name IP Address"
  value       = azurerm_public_ip.target-vm-ip.ip_address
}

output "linux_vm_admin_username" {
  description = "Username password for the Virtual Machine"
  value       = var.linux_admin_username
}

# output "linux_vm_admin_password" {
#   description = "Administrator password for the Virtual Machine"
#   value       = random_password.linux-vm-password.result
#   sensitive   = true
# }

output "secret_value" {
  value = "${data.azurerm_key_vault_secret.public-key.value}"
}

