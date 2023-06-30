##############################
## Core Network - Variables ##
##############################
variable "media-vnet-cidr" {
  type        = string
  description = "The CIDR of the media VNET"
}

variable "host-subnet-cidr" {
  type        = string
  description = "The CIDR for the host subnet"
}

variable "target-subnet-cidr" {
  type        = string
  description = "The CIDR for the target subnet"
}

variable "mediawiki-rg-name" {
  type        = string
  description = "This variable defines the resource group name used to build resources" 
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
