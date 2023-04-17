targetScope = 'subscription'

param location string = 'eastus2'
@maxLength(15)
param purpose string = 'sysdig'
param cidr string = '10.175.0.0/20'

var rgName = 'rg-${location}-${purpose}'
var publicKeyData = loadTextContent('../../aks.pub')

module aksNaming 'nameFix.bicep' = {
  scope: rg
  name: 'make-aksName'
  params: {
    location: rg.location
    name: purpose
    resourceType: 'aks'
  }
}

module vnetNaming 'nameFix.bicep' = {
  scope: rg
  name: 'make-vnetName'
  params: {
    location: rg.location
    name: purpose
    resourceType: 'vnet'
  }
}

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
    name: vnetNaming.outputs.fixedName
  }
}

module aks 'aks.bicep' = {
  scope: rg
  name: 'deploy-aks'
  params: {
    location: rg.location
    name: aksNaming.outputs.fixedName
    publicKey: publicKeyData
    subnetId: aksVNet.outputs.subnetId
  }
}
