###########################
## Azure Linux VM - Main ##
###########################

# # Generate random password
# resource "random_password" "linux-vm-password" {
#   length           = 16
#   min_upper        = 2
#   min_lower        = 2
#   min_special      = 2
#   numeric           = true
#   special          = true
#   override_special = "!@#$%&"
# }

# Create Security Group to access linux
resource "azurerm_network_security_group" "linux-vm-nsg" {
  depends_on=[var.mediawiki-rg-name]

  name                = "linux-nsg"
  location            = var.location
  resource_group_name = var.mediawiki-rg-name

  security_rule {
    name                       = "AllowHTTP"
    description                = "Allow HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = var.my-ip-address
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowSSH"
    description                = "Allow SSH"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.my-ip-address
    destination_address_prefix = "*"
  }
  # security_rule {
  #   name                       = "AllowHTTP"
  #   description                = "Jenkins Port"
  #   priority                   = 100
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_range     = "8080"
  #   source_address_prefix      = var.my-ip-address
  #   destination_address_prefix = "*"
  # }
  tags = {
    environment = var.environment
  }
}

# Associate the linux NSG with the subnet
resource "azurerm_subnet_network_security_group_association" "host-vm-nsg-association" {
  depends_on=[var.mediawiki-rg-name]

  subnet_id                 = var.host_subnet_id
  network_security_group_id = azurerm_network_security_group.linux-vm-nsg.id
}

resource "azurerm_subnet_network_security_group_association" "target-vm-nsg-association" {
  depends_on=[var.mediawiki-rg-name]

  subnet_id                 = var.target_subnet_id
  network_security_group_id = azurerm_network_security_group.linux-vm-nsg.id
}

# Get a Static Public IP for Host VM
resource "azurerm_public_ip" "host-vm-ip" {
  depends_on=[var.mediawiki-rg-name]

  name                = "host-public-ip"
  location            = var.location
  resource_group_name = var.mediawiki-rg-name
  allocation_method   = "Static"
  
  tags = { 
    environment = var.environment
  }
}

# Get a Static Public IP for Target VM
resource "azurerm_public_ip" "target-vm-ip" {
  depends_on=[var.mediawiki-rg-name]

  name                = "target-public-ip"
  location            = var.location
  resource_group_name = var.mediawiki-rg-name
  allocation_method   = "Static"
  
  tags = { 
    environment = var.environment
  }
}

# Create Network Card for Host VM
resource "azurerm_network_interface" "host-vm-nic" {
  depends_on=[var.mediawiki-rg-name]

  name                = "host-nic"
  location            = var.location
  resource_group_name = var.mediawiki-rg-name
  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.host_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.host-vm-ip.id
  }

  tags = { 
    environment = var.environment
  }
}

# Create Network Card for Target VM
resource "azurerm_network_interface" "target-vm-nic" {
  depends_on=[var.mediawiki-rg-name]

  name                = "target-nic"
  location            = var.location
  resource_group_name = var.mediawiki-rg-name
  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.target_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.target-vm-ip.id
  }

  tags = { 
    environment = var.environment
  }
}

# Access ssh key from key vault
data "azurerm_key_vault" "mediawiki-kv" {
  name                = "mediawiki-kv"
  resource_group_name = "budget-rg"
}

data "azurerm_key_vault_secret" "public-key" {
  name      = "vm-public-key"
  key_vault_id = data.azurerm_key_vault.mediawiki-kv.id

}


# Create Linux VM for host server
resource "azurerm_linux_virtual_machine" "host-vm" {
  depends_on=[azurerm_network_interface.host-vm-nic]

  location            = var.location
  resource_group_name = var.mediawiki-rg-name
  name                  = "host-vm"
  network_interface_ids = [azurerm_network_interface.host-vm-nic.id]
  size                  = var.linux_vm_size

  # source_image_reference {
  #   offer     = var.linux_vm_image_offer
  #   publisher = var.linux_vm_image_publisher
  #   sku       = var.centos_8_sku
  #   version   = "latest"
  # }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  os_disk {
    name                 = "host-vm-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  computer_name  = "host-linux-vm"
  admin_username = var.linux_admin_username

  admin_ssh_key {
    username   = "tfadmin"
    public_key = data.azurerm_key_vault_secret.public-key.value
  }
  //admin_password = random_password.linux-vm-password.result
  //custom_data    = base64encode(data.template_file.linux-vm-cloud-init.rendered)
  
  disable_password_authentication = true

  tags = {
    environment = var.environment
  }
}


# Create Linux VM for target server
resource "azurerm_linux_virtual_machine" "target-vm" {
  depends_on=[azurerm_network_interface.target-vm-nic]

  location            = var.location
  resource_group_name = var.mediawiki-rg-name
  name                  = "target-vm"
  network_interface_ids = [azurerm_network_interface.target-vm-nic.id]
  size                  = var.linux_vm_size

  # source_image_reference {
  #   offer     = var.linux_vm_image_offer
  #   publisher = var.linux_vm_image_publisher
  #   sku       = var.centos_8_sku
  #   version   = "latest"
  # }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  os_disk {
    name                 = "target-vm-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  computer_name  = "target-linux-vm"
  admin_username = var.linux_admin_username
  admin_ssh_key {
    username   = "tfadmin"
    public_key = data.azurerm_key_vault_secret.public-key.value
  }  
  //admin_password = random_password.linux-vm-password.result
  //custom_data    = base64encode(data.template_file.linux-vm-cloud-init.rendered)

  disable_password_authentication = true

  tags = {
    environment = var.environment
  }
}

#Template for bootstrapping
# data "template_file" "linux-vm-cloud-init" {
#   template = file("azure-user-data.sh")
# }
