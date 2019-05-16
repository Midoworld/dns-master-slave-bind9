#Variables initialization
#Azure Authentication & VM credentials
/*
Below secret are located in the "secret" folder which is ignored for any git sync, 
this associated file name is : main-smz-sand1.tfvars

subscription_id = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
service_principals = [
  {
    Application_Name   = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" 
    Application_Id     = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
    Application_Secret = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
    Application_object_id = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  },
]
tenant_id = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

# VM Credential and public key certificate
app_admin = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
pass = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
ssh_key = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

#Postgre SQL
pgsql_administrator_login = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
pgsql_administrator_password = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
*/
#MySQL DataBase
#mysql_administrator_login = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
#mysql_administrator_password = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

#Common variables
app_name = "dns"

env_name = "prd"

rg_apps_name = "SANDBOX-DEPLOY-DEVOPS"

rg_infr_name = "SANDBOX-DEPLOY-DEVOPS"

#Storage
sa_infr_name = "testterraformetfstate"

#Backup
bck_rsv_name = "bck-app-test"

#Network

#noprd first, prd second
subnets = [
  "/subscriptions/d142ae0b-98e9-4600-a032-03e4cd871cee/resourceGroups/SANDBOX-DEPLOY-DEVOPS/providers/Microsoft.Network/virtualNetworks/SANDBOX-DEPLOY-DEVOPS-vnet/subnets/default",
]

apps_nsgs = [
  {
    suffix_name = "dns-master"
  },
  {
    suffix_name = "dns-slave"
  },
]

apps_nsgrules = [

  {
    Id_Nsg                     = "1"
    direction                  = "Inbound"
    suffix_name                = "dnsmaster-dns"
    access                     = "Allow"
    priority                   = "100"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    destination_port_range     = "53"
    protocol                   = "tcp"
    source_port_range          = "*"
  },
  {
    Id_Nsg                     = "1"
    direction                  = "Inbound"
    suffix_name                = "dnsmaster-ssh"
    access                     = "Allow"
    priority                   = "1000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    destination_port_range     = "22"
    protocol                   = "tcp"
    source_port_range          = "*"
  },
  {
    Id_Nsg                     = "1"
    direction                  = "Inbound"
    suffix_name                = "dnsmaster-snmp"
    access                     = "Allow"
    priority                   = "1001"
    source_address_prefix      = "12.48.0.0/19"
    destination_address_prefix = "*"
    destination_port_range     = "161"
    protocol                   = "tcp"
    source_port_range          = "*"
  },
  {
    Id_Nsg                     = "1"
    direction                  = "Inbound"
    suffix_name                = "Deny_tcp"
    access                     = "Deny"
    priority                   = "2000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    destination_port_range     = "*"
    protocol                   = "*"
    source_port_range          = "*"
  },
   {
    Id_Nsg                     = "1"
    direction                  = "Inbound"
    suffix_name                = "Deny_udp"
    access                     = "Deny"
    priority                   = "2001"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    destination_port_range     = "*"
    protocol                   = "UDP"
    source_port_range          = "*"
  },
   {
    Id_Nsg                     = "1"
    direction                  = "Inbound"
    suffix_name                = "Deny_any"
    access                     = "Deny"
    priority                   = "2003"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    destination_port_range     = "*"
    protocol                   = "*"
    source_port_range          = "*"
  },
  {
    Id_Nsg                     = "2"
    direction                  = "Inbound"
    suffix_name                = "dnsslave-dns"
    access                     = "Allow"
    priority                   = "100"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    destination_port_range     = "53"
    protocol                   = "tcp"
    source_port_range          = "*"
  },
  {
    Id_Nsg                     = "2"
    direction                  = "Inbound"
    suffix_name                = "dnsslave-ssh"
    access                     = "Allow"
    priority                   = "1000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    destination_port_range     = "22"
    protocol                   = "tcp"
    source_port_range          = "*"
  },
  {
    Id_Nsg                     = "2"
    direction                  = "Inbound"
    suffix_name                = "dnsslave-snmp"
    access                     = "Allow"
    priority                   = "1001"
    source_address_prefix      = "12.48.0.0/19"
    destination_address_prefix = "*"
    destination_port_range     = "161"
    protocol                   = "tcp"
    source_port_range          = "*"
  },
  {
    Id_Nsg                     = "2"
    direction                  = "Inbound"
    suffix_name                = "Deny_tcp"
    access                     = "Deny"
    priority                   = "2000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    destination_port_range     = "*"
    protocol                   = "*"
    source_port_range          = "*"
  },
   {
    Id_Nsg                     = "2"
    direction                  = "Inbound"
    suffix_name                = "Deny_udp"
    access                     = "Deny"
    priority                   = "2001"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    destination_port_range     = "*"
    protocol                   = "UDP"
    source_port_range          = "*"
  },
   {
    Id_Nsg                     = "2"
    direction                  = "Inbound"
    suffix_name                = "Deny_any"
    access                     = "Deny"
    priority                   = "2003"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    destination_port_range     = "*"
    protocol                   = "*"
    source_port_range          = "*"
  },
]

# Virtual Machines components : Load Balancer & Availability Set & Nic & VM
Lb_sku = "Standard" #"Basic" 

#Load balancer sample usage
Lbs = [/*
  {
    suffix_name = "lbdns"
    Id_Subnet   = "1"             #Id of the Subnet
    static_ip   = "198.18.192.73"
  },
*/]

LbRules = [/*
  {
    Id             = "1"           #Id of a the rule within the Load Balancer 
    Id_Lb          = "0"           #Id of the Load Balancer
    suffix_name    = "glprlbpollerdmz" #MUST match the Lbs suffix_name
    lb_port        = "80"
    probe_protocol = "Tcp"
    request_path   = "/"
  }, 
*/]

#Availability Set sample usage
/*
Availabilitysets = [
  {
    suffix_name = "front" #It must equals the Vm suffix_name
  },
]
*/
Availabilitysets = []

Linux_Vms = [
  {
    suffix_name                   = "master"
    id                            = "1"                      #Id of the VM
    Id_Lb                         = "777" #1                     #Id of the Load Balancer, set to 777 if there is no Load Balancer
    Id_Subnet                     = "1"                      #Id of the Subnet
    Id_Ava                        = "777"                    #Id of the Availabilitysets, set to 777 if there is no Availabilitysets
    zone                          = "777"                      #Availability Zones ids separated by an espace, if you don't need to set it to "", WARNING you could not have Availabilitysets and AvailabilityZones
    Id_Nsg                        = "1"                      #Id of the Network Security Group, set to 777 if there is no Network Security Groups
    BackupPolicyName              = "BackupPolicy-Schedule1"
    static_ip                     = "12.48.0.40"
    enable_accelerated_networking = "true"
    vm_size                       = "Standard_DS2_v2"
    managed_disk_type             = "Premium_LRS"
    publisher                     = "Canonical"
    offer                         = "UbuntuServer"
    sku                           = "18.04-LTS"
    lun                           = "0"
    disk_size_gb                  = "32"
  },
  {
    suffix_name                   = "slave"
    id                            = "2"                      #Id of the VM
    Id_Lb                         = "777" #2                      #Id of the Load Balancer, set to 777 if there is no Load Balancer
    Id_Subnet                     = "1"                      #Id of the Subnet
    Id_Ava                        = "777"                    #Id of the Availabilitysets, set to 777 if there is no Availabilitysets
    zone                          = "777"                      #1-2-3 Availability Zones ids separated by an espace, if you don't need to set it to "", WARNING you could not have Availabilitysets and AvailabilityZones
    Id_Nsg                        = "2"                      #Id of the Network Security Group, set to 777 if there is no Network Security Groups
    BackupPolicyName              = "BackupPolicy-Schedule1"
    static_ip                     = "12.48.0.41"
    enable_accelerated_networking = "true"
    vm_size                       = "Standard_DS2_v2"
    managed_disk_type             = "Premium_LRS"
    publisher                     = "Canonical"
    offer                         = "UbuntuServer"
    sku                           = "18.04-LTS"
    lun                           = "0"
    disk_size_gb                  = "32"
  },
]

Windows_Vms = []

#VM Scale Set
Linux_Ss_Vms = []

Windows_Ss_Vms = []

pgsql_config = []
pgsql_db = []
pgsql_db_firewall = []
pgsql_server = []
#PaaS MySql

mysql_server = [/*
  {
    suffix_name           = "dns"
    version               = "5.7"
    ssl_enforcement       = "Disabled"
    sku_name              = "GP_Gen5_4"
    sku_capacity          = 4
    sku_tier              = "GeneralPurpose"
    sku_family            = "Gen5"
    storage_mb            = 512000
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  },
*/]

mysql_config = [/*
  {
    id_server         = "0"               #Must match an Id of one mysql_server
    MySQLConfigValue  = "600"
    MySQLConfigName   = "interactive_timeout" #Specifies the name of the MySQL Configuration, which needs to be a valid MySQL configuration name. Changing this forces a new resource to be created. See :https://dev.mysql.com/doc/refman/5.7/en/server-configuration.html 
  },
*/]

mysql_db_firewall = [/*
  {
    id_server = "0"             #Must match an Id of one mysql_server
    id        = "1"             #Id of the my sql database
    start_ip  = "198.18.192.74"
    end_ip    = "198.18.192.75"
  },
   {
    id_server = "0"             #Must match an Id of one mysql_server
    id        = "2"             #Id of the my sql database
    start_ip  = "198.18.192.76"
    end_ip    = "198.18.192.78"
  },
     {
    id_server = "0"             #Must match an Id of one mysql_server
    id        = "3"             #Id of the my sql database
    start_ip  = "198.18.232.100"
    end_ip    = "198.18.232.102"
  },
*/]

mysql_db = [/*
  {
    id_server   = "0"                          #Must match an Id of one mysql_server
    id          = "1"                          #Id of the my sql database
    suffix_name = "dns"
    charset     = "utf8"
    collation   = "utf8_unicode_ci"
  },
  {
    id_server   = "0"
    id          = "2"
    suffix_name = "dns_storage"
    charset     = "utf8"
    collation   = "utf8_unicode_ci"
  },
*/]
mysql_vnet_rule = [/*
  {
    id = "0"
    id_server = "1"
    Id_Subnet = "1"
  },
*/]
