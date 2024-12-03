variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "westcentralus"
}

variable "app_env" {
  type        = string
  nullable    = false
  description = "The env name: dev, qa, test, or prod"
}
variable "app_prefix" {
  type        = string
  nullable    = false
  description = "3 or 4 character mnemonic for application"
}

variable "sub_prefix" {
  type        = string
  nullable    = false
  description = "The 3 or 4 character mnemonic for this subscription"
}
variable "tags" {
  description = "tags to be applied to resources"
  type        = map(string)
  default     = {}
}

#variable "subnet_ids" {
#  type        = map(string)
#  nullable    = true
#  description = "Subnet IDs"
#}

variable "container_image" {
  type        = string
  nullable    = false
  description = "the image to use for the container"
}

variable "TFC_AGENT_NAME" {
  type        = string
  nullable    = false
  description = "name of TFC agent"
}

variable "TFC_AGENT_TOKEN" {
  type        = string
  nullable    = false
  description = "The token for the TFC agent"
}

variable "subscription_ids" {
  type        = map(string)
  nullable    = false
  description = "the subscription ids"
}