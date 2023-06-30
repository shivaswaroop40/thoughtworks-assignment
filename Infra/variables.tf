variable "app_name" {
  type        = string
  description = "This variable defines the application name used to build resources"
}

# environment
variable "environment" {
  type        = string
  description = "This variable defines the environment to be built"
}

# azure region
variable "location" {
  type        = string
  description = "Azure region where the resource group will be created"
}

variable "media-vnet-cidr" {
  type        = string
  description = "The CIDR of the mediawiki VNET"
}

variable "host-subnet-cidr" {
  type        = string
  description = "The CIDR for the host subnet"
}

variable "target-subnet-cidr" {
  type        = string
  description = "The CIDR for the network subnet"
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
  default     = "49.205.129.17"
}