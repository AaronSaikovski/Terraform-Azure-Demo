#configure the resource provider
provider "azurerm" {
  version = "=1.20.0"
}

#create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.resourcegroup_name}"
  location = "${var.resourcegroup_location}"

  tags {
    Environment = "${var.environment_tag}"
    Project = "${var.project_tag}"
    Version = "${var.version_tag}"
  }
}

#App service plan
resource "azurerm_app_service_plan" "webapp" {
  name                = "${var.appsvc_plan_name}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${azurerm_resource_group.rg.location}"
  kind                = "${var.appsvc_plan_settings["kind"]}"
  sku {
    tier     = "${var.appsvc_plan_settings["tier"]}"
    size     = "${var.appsvc_plan_settings["size"]}"
    capacity = "${var.appsvc_plan_settings["capacity"]}"
  }
}

#App service
resource "azurerm_app_service" "webapp" {
  name                = "${var.appsvc_name}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${azurerm_resource_group.rg.location}"
  app_service_plan_id = "${azurerm_app_service_plan.webapp.id}"

   client_affinity_enabled = "false"
   https_only = "true"
 
  site_config {
    dotnet_framework_version = "v4.0"
    php_version = "7.1"
    use_32_bit_worker_process = "true"
    ftps_state = "FtpsOnly"
    http2_enabled ="true"
    websockets_enabled ="false"
    always_on ="false"
    scm_type = "None"  
    default_documents = ["hostingstart.html"] 
  } 
}