param location  string
param name      string
param cidr      string


resource vnet 'Microsoft.Network/virtualNetworks@2022-09-01' = {
  name: name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        cidr
      ]
    }
    subnets: [
      {
        name: '${name}_aks_subnet'
        properties: {
          addressPrefix: cidr
        }
      }
    ]
  }
}

output subnetId string = vnet.properties.subnets[0].id
