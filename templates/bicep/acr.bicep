param location    string 
param acrName     string
param anonAccess  bool = false
param adminUser   bool = true

resource acr 'Microsoft.ContainerRegistry/registries@2022-02-01-preview' = {
  name: acrName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    adminUserEnabled: adminUser
    anonymousPullEnabled: anonAccess
  }
}

output acrId string       = acr.id
output acrEndpoint string = acr.properties.loginServer
