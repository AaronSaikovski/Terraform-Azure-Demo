variable "resourcegroup_name" {
  description = "Resource group name"
}

variable "resourcegroup_location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = "Southeast Asia"
}

variable "environment_tag" {
  description = "Tag to indicate the environment we are deploying."
}

variable "project_tag" {
  description = "Tag to indicate what project we are deploying."
}

variable "version_tag" {
  description = "Tag to indicate the version we are deploying."
}

variable "appsvc_plan_name" {
  description = "App service plan name"
}

variable "appsvc_plan_settings" {
  type = "map"
  description = "App service plan settings"
}
variable "appsvc_name" {
  description = "App service name"
}