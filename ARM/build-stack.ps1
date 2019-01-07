<#
  .SYNOPSIS 
	Build Azure environment stack
  .NOTES
  Version:        1.0
  Author:         Aaron Saikovski
  Creation Date:  30th July 2018
  Purpose/Change: Initial script development 
  
   .NOTES
  Version:        1.1
  Author:         Aaron Saikovski
  Creation Date:  5th December 2018
  Purpose/Change: Updated to use new Azure PowerShell 'Az' modules
#>
[CmdletBinding()]
param(
		[Parameter(Mandatory=$True)]
		[ValidateSet("DEV","TEST","PROD")] 
		[string] $TargetEnvironment,

		[Parameter(Mandatory=$True)]
		[string] $ResourceGroupName,

		[Parameter(Mandatory=$True)]
		[ValidateSet("Australia Southeast","Southeast Asia")] 
		[string] $ResourceGroupLocation,

		[Parameter(Mandatory=$True)]
		[hashtable] $ResourceGroupTags,

		[Parameter(Mandatory=$True)]
		[bool] $DeployResourceGroup = $false,			

		[Parameter(Mandatory=$True)]
		[bool] $DeployWeb = $false	
)

Clear-Host

Set-StrictMode -Version 3
##$ErrorActionPreference = "SilentlyContinue"
$ErrorActionPreference = "Stop"

#import new azure module
Import-Module -Name Az


#Import modules
Import-Module ./AzureLogin.psm1 -Force 
Import-Module ./AzureHelper.psm1 -Force 

#Template basepath
[string]$baseScriptPath = [System.IO.Directory]::GetParent([System.IO.Directory]::GetParent($MyInvocation.MyCommand.Path))
	
################################################################

#login to Azure
DoLogin

################################################################

#region DEPLOY_RSG
#Deploy resourcegroup
if($DeployResourceGroup)
{
	#Create ResourceGroup & Tag 	
	Write-Host "Deploying ResourceGroup..." -ForegroundColor Yellow
	DeployResourceGroup -resourceGroupName $ResourceGroupName -resourceGroupLocation $ResourceGroupLocation
	AddResourceGroupTags -resourceGroupName $ResourceGroupName -resourceGroupTags $ResourceGroupTags
	Write-Host "Completed Deploying ResourceGroup..." -ForegroundColor Green	
}
#endregion DEPLOY_RSG

################################################################

#region DEPLOY_WEB
#Deploy Web
if($DeployWeb)
{
	Write-Host "Deploying Web..." -ForegroundColor Yellow
	$webtemplateFile = "$baseScriptPath\arm\webapp.json"
	$webparametersFile = "$baseScriptPath\arm\webapp-" + $TargetEnvironment + ".parameters.json"
	$webdeploymentName = "web-" + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm')
	DeployResources -resourceGroupName $ResourceGroupName -resourceGroupLocation $ResourceGroupLocation  -templateFile $webtemplateFile -parametersFile $webparametersFile -deploymentName $webdeploymentName
	Write-Host "Completed Deploying Web..." -ForegroundColor Green
}
#endregion DEPLOY_WEB

################################################################

Write-Host "Finished"