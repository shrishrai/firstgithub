
resource "azurerm_mssql_database" "database" {
  name         = var.sql_database_name
  server_id    = var.sql_server_id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"

  tags = {
    foo = "bar"
  }
}
data "azurerm_mssql_server" "sql_server" {
  name                = "sqlserver-shrish1"
  resource_group_name = "shrish1"
}
