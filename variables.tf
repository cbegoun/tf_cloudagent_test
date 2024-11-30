variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "westcentralus"
}

variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  default     = "cloudagent"
}

variable "subscription_id" {
  description = "The subscription id in which all resources in this example should be created."
}

variable "ADMIN_USERNAME" {
  description = "Linux VM admin username"
  type        = string
}

variable "ADMIN_PASSWORD" {
  description = "Linux VM admin password"
  type        = string
  sensitive   = true
}