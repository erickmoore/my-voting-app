targetScope           = 'subscription'

// Parameters
//
param location  string = 'eastus2'
@maxLength(15)
param purpose   string = 'sysdig'
param cidr      string = '10.175.0.0/20'

// Variables
//
var rgName        = 'rg-${location}-${purpose}'
var publicKeyData = loadTextContent('../../aks.pub')

// Create names for resources
//
module aksNaming 'naming.bicep' = {
  scope: rg
  name: 'make-aksName'
  params: {
    location: rg.location
    name: purpose
    resourceType: 'aks'
  }
}

module acrNaming 'naming.bicep' = {
  scope: rg
  name: 'make-acrName'
  params: {
    location: rg.location
    name: purpose
    resourceType: 'acr' 
  }
}

module vnetNaming 'naming.bicep' = {
  scope: rg
  name: 'make-vnetName'
  params: {
    location: rg.location
    name: purpose
    resourceType: 'vnet'
  }
}

// Create resources
//
resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: rgName
  location: location
}

module aksVNet 'aksVNet.bicep' = {
  scope: rg
  name: 'deploy-aksVnet'
  params: {
    cidr: cidr
    location: rg.location
    name: vnetNaming.outputs.resourceName
  }
}

module aks 'aks.bicep' = {
  scope: rg
  name: 'deploy-aks'
  params: {
    location: rg.location
    name: aksNaming.outputs.resourceName
    publicKey: publicKeyData
    subnetId: aksVNet.outputs.subnetId
  }
}

module acr 'acr.bicep' = {
  scope: rg
  name: 'deploy-acr'
  params: {
    acrName: acrNaming.outputs.resourceName
    location: rg.location
  }
}

output acrEndpoint string = acr.outputs.acrEndpoint
