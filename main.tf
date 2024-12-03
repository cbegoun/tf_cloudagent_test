resource "azurerm_resource_group" "tf_agent_rg" {
  name     = "rg-${sub.prefix}-${var.app_prefix}-${var.app_env}-${var.location}"
  location = var.location
  tags     = var.tags
}
