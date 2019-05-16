# Providers
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${lookup(var.service_principals[0], "Application_Id")}"
  client_secret   = "${lookup(var.service_principals[0], "Application_Secret")}"
  tenant_id       = "${var.tenant_id}"
  version         = "1.15"
}

# Module

####################################################
##########           Infra                ##########
####################################################

## Prerequisistes Inventory
module "Get-AzureRmResourceGroup-Infr" {
  source  = "../module/Get-AzureRmResourceGroup"
  rg_name = "${var.rg_infr_name}"
}

module "Get-AzureRmStorageAccount-Infr" {
  source     = "../module/Get-AzureRmStorageAccount"
  sa_rg_name = "${var.rg_infr_name}"
  sa_name    = "${var.sa_infr_name}"
}

####################################################
##########              Apps              ##########
####################################################

## Prerequisistes Inventory
module "Get-AzureRmResourceGroup-MyApps" {
  source  = "../module/Get-AzureRmResourceGroup"
  rg_name = "${var.rg_apps_name}"
}

## Core Network components
module "Create-AzureRmNetworkSecurityGroup-Apps" {
  source                  = "../module/Create-AzureRmNetworkSecurityGroup"
  nsgs                    = ["${var.apps_nsgs}"]
  nsg_prefix              = "${var.app_name}-${var.env_name}-"
  nsg_suffix              = "-nsg1"
  nsg_location            = "${module.Get-AzureRmResourceGroup-MyApps.rg_location}"
  nsg_resource_group_name = "${module.Get-AzureRmResourceGroup-MyApps.rg_name}"
  nsg_tags                = "${module.Get-AzureRmResourceGroup-MyApps.rg_tags}"
  nsgrules                = ["${var.apps_nsgrules}"]
}

## Virtual Machines components
module "Create-AzureRmAvailabilitySet-Apps" {
  source                  = "../module/Create-AzureRmAvailabilitySet"
  ava_availabilitysets    = ["${var.Availabilitysets}"]
  ava_prefix              = "${var.app_name}-${var.env_name}-"
  ava_suffix              = "-avs1"
  ava_location            = "${module.Get-AzureRmResourceGroup-MyApps.rg_location}"
  ava_resource_group_name = "${module.Get-AzureRmResourceGroup-MyApps.rg_name}"
  ava_tags                = "${module.Get-AzureRmResourceGroup-MyApps.rg_tags}"
}

module "Create-AzureRmLoadBalancer-Apps" {
  source                 = "../module/Create-AzureRmLoadBalancer"
  Lbs                    = ["${var.Lbs}"]
  lb_prefix              = "${var.app_name}-${var.env_name}-"
  lb_suffix              = "-lb1"
  lb_location            = "${module.Get-AzureRmResourceGroup-MyApps.rg_location}"
  lb_resource_group_name = "${module.Get-AzureRmResourceGroup-MyApps.rg_name}"
  Lb_sku                 = "${var.Lb_sku}"
  subnets_ids            = "${var.subnets}"
  lb_tags                = "${module.Get-AzureRmResourceGroup-MyApps.rg_tags}"
  LbRules                = ["${var.LbRules}"]
}

module "Create-AzureRmNetworkInterface-Apps" {
  source                  = "../module/Create-AzureRmNetworkInterface"
  Linux_Vms               = ["${var.Linux_Vms}"]                                         #If no need just fill "Linux_Vms = []" in the tfvars file
  Windows_Vms             = ["${var.Windows_Vms}"]                                       #If no need just fill "Windows_Vms = []" in the tfvars file
  nic_prefix              = "${var.app_name}-${var.env_name}-"
  nic_suffix              = "-nic1"
  nic_location            = "${module.Get-AzureRmResourceGroup-MyApps.rg_location}"
  nic_resource_group_name = "${module.Get-AzureRmResourceGroup-MyApps.rg_name}"
  subnets_ids             = "${var.subnets}"
  lb_backend_ids          = "${module.Create-AzureRmLoadBalancer-Apps.lb_backend_ids}"
  nic_tags                = "${module.Get-AzureRmResourceGroup-MyApps.rg_tags}"
  nsgs_ids                = "${module.Create-AzureRmNetworkSecurityGroup-Apps.nsgs_ids}"
}

module "Create-AzureRmVm-Apps" {
  source                  = "../module/Create-AzureRmVm"
  sa_bootdiag_storage_uri = "${module.Get-AzureRmStorageAccount-Infr.sa_primary_blob_endpoint}"
  Linux_Vms               = ["${var.Linux_Vms}"]                                                #If no need just fill "Linux_Vms = []" in the tfvars file
  Windows_Vms             = ["${var.Windows_Vms}"]                                              #If no need just fill "Windows_Vms = []" in the tfvars file
  vm_location             = "${module.Get-AzureRmResourceGroup-MyApps.rg_location}"
  vm_resource_group_name  = "${module.Get-AzureRmResourceGroup-MyApps.rg_name}"
  vm_prefix               = "${var.app_name}-${var.env_name}-"
  vm_tags                 = "${module.Get-AzureRmResourceGroup-MyApps.rg_tags}"
  app_admin               = "${var.app_admin}"
  pass                    = "${var.pass}"
  ssh_key                 = "${var.ssh_key}"
  ava_set_ids             = "${module.Create-AzureRmAvailabilitySet-Apps.ava_set_ids}"
  Linux_nics_ids          = "${module.Create-AzureRmNetworkInterface-Apps.Linux_nics_ids}"
  Windows_nics_ids        = "${module.Create-AzureRmNetworkInterface-Apps.Windows_nics_ids}"
}

# Infra cross services for Apps
module "Enable-AzureRmRecoveryServicesBackupProtection-Apps" {
  source                      = "../module/Enable-AzureRmRecoveryServicesBackupProtection"
  resource_names              = "${concat(module.Create-AzureRmVm-Apps.Linux_Vms_names,module.Create-AzureRmVm-Apps.Windows_Vms_names)}"     #Names of the resources to backup
  resource_group_names        = "${concat(module.Create-AzureRmVm-Apps.Linux_Vms_rgnames,module.Create-AzureRmVm-Apps.Windows_Vms_rgnames)}" #Resource Group Names of the resources to backup
  resource_ids                = "${concat(module.Create-AzureRmVm-Apps.Linux_Vms_ids,module.Create-AzureRmVm-Apps.Windows_Vms_ids)}"         #Ids of the resources to backup
  bck_rsv_name                = "${var.bck_rsv_name}"
  bck_rsv_resource_group_name = "${module.Get-AzureRmResourceGroup-Infr.rg_name}"
  bck_ProtectedItemType       = "Microsoft.ClassicCompute/virtualMachines"
  bck_BackupPolicyName        = "BackupPolicy-Schedule1"
  bck_location                = "${module.Get-AzureRmResourceGroup-Infr.rg_location}"
}

#PaaS DB Services
module "Create-AzureRmPostgreSqlDatabase-Apps" {
  source                       = "../module/Create-AzureRmPostgreSqlDatabase"
  pgsql_prefix                 = "${var.app_name}-${var.env_name}-"
  pgsql_suffix                 = "-pgsql1"
  pgsql_server                 = ["${var.pgsql_server}"]
  pgsql_administrator_login    = "${var.pgsql_administrator_login}"
  pgsql_administrator_password = "${var.pgsql_administrator_password}"
  pgsql_config                 = ["${var.pgsql_config}"]
  pgsql_db_firewall            = ["${var.pgsql_db_firewall}"]
  pgsql_db                     = ["${var.pgsql_db}"]
  pgsql_resource_group_name    = "${module.Get-AzureRmResourceGroup-MyApps.rg_name}"
  pgsql_location               = "${module.Get-AzureRmResourceGroup-MyApps.rg_location}"
  pgsql_subnet_id              = "${element(var.subnets,1)}"
}

#My Sql PaaS DB Services
module "Create-AzureRmMySqlDatabase-Apps" {
  source                       = "../module/Create-AzureRmMySqlDatabase"
  mysql_prefix                 = "${var.app_name}-${var.env_name}-"
  mysql_suffix                 = "-mysql1"
  mysql_server                 = ["${var.mysql_server}"]
  mysql_administrator_login    = "${var.mysql_administrator_login}"
  mysql_administrator_password = "${var.mysql_administrator_password}"
  mysql_config                 = ["${var.mysql_config}"]
  mysql_db_firewall            = ["${var.mysql_db_firewall}"]
  mysql_db                     = ["${var.mysql_db}"]
  mysql_resource_group_name    = "${module.Get-AzureRmResourceGroup-MyApps.rg_name}"
  mysql_location               = "${module.Get-AzureRmResourceGroup-MyApps.rg_location}"
  mysql_subnet_id              = "${element(var.subnets,1)}"
}

