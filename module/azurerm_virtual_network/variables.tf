variable "virtual_network_name" {
  description = "The name of the Virtual Network"
  type        = string
}
variable "address_space" {
  description = "The address space that is used by the Virtual Network"
  type        = list(string)
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "virtual_network_location" {
  description = "The Azure location where the resource group is created"
  type        = string
}