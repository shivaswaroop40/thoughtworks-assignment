#Core module with resource group
resource "azurerm_resource_group" "mediawiki-rg" {
  name     = "mediawiki-rg"
  location = var.location
  tags = {
    application = var.app_name
    environment = var.environment
  }
}
