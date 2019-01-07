#Build DEV stack

#resource group tags
[hashtable] $Tags =  @{"Environment"="DEV";"Project"="csa-dev-test-arm";"Version"="1.0"}

#do the build
./build-stack.ps1 -TargetEnvironment "DEV" `
					-ResourceGroupName "csa-dev-test-arm" `
					-ResourceGroupLocation "Southeast Asia" `
					-ResourceGroupTags $Tags `
					-DeployResourceGroup $true `
					-DeployWeb $true 