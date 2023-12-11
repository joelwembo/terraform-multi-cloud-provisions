variable "resource_group_name" {
  description = "The name of the resource group the Private Link Service is located in."
  default     = "example-private-link-service"
}

variable "location" {
  description = "The Azure location where all resources in this example should be created."
  default     = "WestUS"
}
