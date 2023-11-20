
resource "azurerm_resource_group" "TVAksjonenNettbutikk_resource_group" {
  name     = "TVAksjonenNettbutikk-${var.environment}"
  location = var.location
  tags     = local.tags
}

resource "azurerm_service_plan" "service_plan" {
  name                = "TVAksjonenNettbutikk-${var.environment}-asp"
  resource_group_name = azurerm_resource_group.TVAksjonenNettbutikk_resource_group.name
  location            = "West Europe"
  sku_name            = var.sku
  os_type             = "Linux"  
}

resource "azurerm_static_site" "client_static_site" {
  name                = "tan-webapp-${var.environment}"
  resource_group_name = azurerm_resource_group.TVAksjonenNettbutikk_resource_group.name
  location            = "West Europe" # Norwegian stapps are forbidden :(
}

resource "azurerm_application_insights" "application_insights" {
  name                = "tan-appinsight-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.TVAksjonenNettbutikk_resource_group.name
  application_type    = "web"
  tags                = local.tags
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "tansa${var.environment}"
  resource_group_name      = azurerm_resource_group.TVAksjonenNettbutikk_resource_group.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.tags

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_linux_function_app" "tvaksjonen-function" {
  name                       = "tan-functions-${var.environment}"
  location                   = azurerm_service_plan.service_plan.location
  resource_group_name        = azurerm_resource_group.TVAksjonenNettbutikk_resource_group.name
  service_plan_id            = azurerm_service_plan.service_plan.id
  storage_account_name       = azurerm_storage_account.storage_account.name
  storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key
  site_config {}
}