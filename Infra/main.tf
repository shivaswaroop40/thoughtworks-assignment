terraform {
  required_version = "~> 1.0"
}

# Configure the Azure provider
provider "azurerm" { 
  features {}  
  environment     = "public"
}


module "core" {
  source = "./core"
  location = var.location
  app_name = var.app_name
  environment = var.environment
}


module "networking" {
  source = "./networking"
  mediawiki-rg-name = module.core.mediawiki-rg-name
  location = var.location
  app_name = var.app_name
  environment = var.environment
  media-vnet-cidr = var.media-vnet-cidr
  host-subnet-cidr = var.host-subnet-cidr
  target-subnet-cidr = var.target-subnet-cidr
}


module "virtual-machine" {
  source = "./virtual machine"
  mediawiki-rg-name = module.core.mediawiki-rg-name
  location = var.location
  app_name = var.app_name
  environment = var.environment
  host_subnet_id = module.networking.host_subnet_id
  target_subnet_id = module.networking.target_subnet_id
  linux_vm_size = var.linux_vm_size
  linux_admin_username = var.linux_admin_username
  my-ip-address = var.my-ip-address
}