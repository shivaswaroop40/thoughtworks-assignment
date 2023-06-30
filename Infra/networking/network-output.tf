######################
## Network - Output ##
######################

output "media_vnet_id" {
  value = azurerm_virtual_network.media-vnet.id
}

output "host_subnet_id" {
  value = azurerm_subnet.host-subnet.id
}

output "target_subnet_id" {
  value = azurerm_subnet.target-subnet.id
}

