resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.sql_server_location
  version                      = "12.0"
  administrator_login          = data.azurerm_key_vault_secret.adminlogin.value
  administrator_login_password = data.azurerm_key_vault_secret.adminpassword.value

  tags = {
    environment = "production"
  }
}
data "azurerm_key_vault" "kv" {
  name                = "peti"
  resource_group_name = "shrishkeypeti"
}

data "azurerm_key_vault_secret" "adminlogin" {
  name         = var.administrator_login
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "adminpassword" {
  name         = var.administrator_login_password
  key_vault_id = data.azurerm_key_vault.kv.id
}

output "sql_server_id" {
  value = azurerm_mssql_server.sql_server.id
}
