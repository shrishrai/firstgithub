# resource group
module "resource_group" {
  source                  = "../module/azurerm_resource_group"
  resource_group_name     = "shrish1"
  resource_group_location = "centralindia"

}
module "resource_group1" {
  source                  = "../module/azurerm_resource_group"
  resource_group_name     = "shrish2"
  resource_group_location = "centralindia"

}
odule "resource_group2" {
  source                  = "../module/azurerm_resource_group"
  resource_group_name     = "shrish3"
  resource_group_location = "centralindia"

}
# virtual network
module "virtual_network" {
  depends_on               = [module.resource_group]
  source                   = "../module/azurerm_virtual_network"
  virtual_network_name     = "vnet-shrish1"
  virtual_network_location = "centralindia"
  resource_group_name      = "shrish1"
  address_space            = ["10.1.0.0/16"]

}
# subnets



module "frontend_subnet" {
  depends_on = [module.virtual_network]
  source     = "../module/azurerm_subnet"

  subnet_name          = "frontend_subnet-shrish1"
  resource_group_name  = "shrish1"
  virtual_network_name = "vnet-shrish1"
  address_prefixes     = ["10.1.6.0/24"]
}

module "backend_subnet" {
  depends_on = [module.virtual_network]
  source     = "../module/azurerm_subnet"

  subnet_name          = "backend_subnet-shrish1"
  resource_group_name  = "shrish1"
  virtual_network_name = "vnet-shrish1"
  address_prefixes     = ["10.1.7.0/24"]
}

# SQL Server
module "sql_server" {
  source                       = "../module/azurerm_sql_server"
  sql_server_name              = "sqlserver-shrish1"
  resource_group_name          = "shrish1"
  sql_server_location          = "centralindia"
  administrator_login          = "login"
  administrator_login_password = "password"

}
module "db" {
  depends_on        = [module.sql_server]
  source            = "../module/azurerm_sql_database"
  sql_database_name = "sqldb-shrish1"
  sql_server_id     = module.sql_server.sql_server_id
}



module "pip" {
  source              = "../module/azurerm_public_ip"
  public_ip_name      = "pip-shrish1"
  resource_group_name = "shrish1"
  public_ip_location  = "centralindia"

}


# module "backend_vm" {

#   source     = "../module/azurerm_virtual_machine"

#   virtual_machine_name  = "backendvm"
#   virtual_machine_location = "centralindia"
#   resource_group_name   = "shrish1"
#   nic_name              = "nic-backend-shrish1"
#   nic_location          = "centralindia"
#   subnet_id             = 
# admin_username        = "login"
# admin_password        = "password"
# } 

module "frontend_vm" {

  source = "../module/azurerm_virtual_machine"

  virtual_machine_name     = "frontendvm"
  virtual_machine_location = "centralindia"
  resource_group_name      = "shrish1"
  nic_name                 = "nic-frontend-shrish1"
  nic_location             = "centralindia"
  subnet_id                = "frontend_subnet-shrish1"
  admin_username           = login
  admin_password           = password
}

