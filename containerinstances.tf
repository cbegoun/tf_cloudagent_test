resource "azurerm_container_group" "tf_agent_cg" {
  name                = "cg-${var.sub_prefix}-${var.app_prefix}-${var.app_env}-${var.location}"
  location            = var.location
  resource_group_name = azurerm_resource_group.tf_agent_rg.name
  os_type             = "Linux"


  container {
    name   = "ci-${var.sub_prefix}-${var.app_prefix}-${var.app_env}-${var.location}"
    image  = var.container_image
    cpu    = "1.0"
    memory = "1.5"
    ports {
      port     = 80
      protocol = "TCP"
    }
    environment_variables = {
      TFC_AGENT_NAME  = var.TFC_AGENT_NAME
      TFC_AGENT_TOKEN = var.TFC_AGENT_TOKEN
    }
  }
  dns_config {
    nameservers = ["1.1.1.2", "1.0.0.2"]
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.app_env
    Project     = var.app_prefix
    Owner       = "Cody Begoun"
  }
}
