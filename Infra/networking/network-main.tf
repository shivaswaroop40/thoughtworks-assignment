####################
## Network - Main ##
####################

# Create the main VNET
resource "azurerm_virtual_network" "media-vnet" {
  name                = "mediawiki-vnet"
  address_space       = [var.media-vnet-cidr]
  resource_group_name = var.mediawiki-rg-name
  location            = var.location
  tags = {
    application = var.app_name
    environment = var.environment
  }
}

# Create a subnet for Host and Target Servers
resource "azurerm_subnet" "host-subnet" {
  name                 = "host-subnet"
  address_prefixes     = [var.host-subnet-cidr]
  virtual_network_name = azurerm_virtual_network.media-vnet.name
  resource_group_name  = var.mediawiki-rg-name
}

resource "azurerm_subnet" "target-subnet" {
  name                 = "target-subnet"
  address_prefixes     = [var.target-subnet-cidr]
  virtual_network_name = azurerm_virtual_network.media-vnet.name
  resource_group_name  = var.mediawiki-rg-name
}

