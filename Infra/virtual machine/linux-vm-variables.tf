################################
## Azure Linux VM - Variables ##
################################
variable "mediawiki-rg-name" {
  type        = string
  description = "This variable defines the resource group name used to build resources" 
}

variable "linux_vm_size" {
  type        = string
  description = "Size (SKU) of the virtual machine to create"
}

variable "linux_admin_username" {
  type        = string
  description = "Username for Virtual Machine administrator account"
  default     = ""
}

# variable "linux_admin_password" {
#   type        = string
#   description = "Password for Virtual Machine administrator account"
#   default     = ""
# }

variable "my-ip-address" {
  type        = string
  description = "Host system IP address to connect to VM"
  default     = ""
}

# azure region
variable "location" {
  type        = string
  description = "Azure region where the resource group will be created"
}


variable "environment" {
  type        = string
  description = "This variable defines the environment to be built"
}

variable "app_name" {
  type        = string
  description = "This variable defines the application name used to build resources"
}

variable "host_subnet_id" {
  type        = string
  description = "This variable defines the host subnet id"
}

variable "target_subnet_id" {
  type        = string
  description = "This variable defines the target subnet id"
}
