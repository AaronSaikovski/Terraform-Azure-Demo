#resourcegroup
resourcegroup_name = "csa-test-appstack"

#Location
resourcegroup_location = "Southeast Asia" 

#tags
environment_tag = "DEV"
project_tag = "csa-dev-test"
version_tag = "1.0"


#FE App Service
appsvc_plan_name = "csa-test-appsvcplan"

appsvc_plan_settings {
    kind     = "Windows" # Linux or Windows
    tier     = "Free"
    size     = "F1"
    capacity = 1  
}

#FE App service
appsvc_name = "csa-test-appsvc"