param location string 
param acrName string
param anonAccess bool = false

resource acr 'Microsoft.ContainerRegistry/registries@2022-02-01-preview' = {
  name: acrName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    adminUserEnabled: false
    anonymousPullEnabled: anonAccess
  }
}

output acrId string = acr.id
