param location  string = 'eastus2'
param adminName string = 'linadmin'
param name      string
param subnetId  string
param publicKey string

@allowed([
  'Standard_B2ms'
])
param vmSize    string = 'Standard_B2ms'

@maxValue(3)
param nodeCount int = 3

resource aks 'Microsoft.ContainerService/managedClusters@2023-02-01' = {
  name: name
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: 'private'
    agentPoolProfiles: [
      {
        name: 'default'
        count: nodeCount
        vmSize: vmSize
        vnetSubnetID: subnetId
        mode: 'System'
      }
    ]
    linuxProfile: {
      adminUsername: adminName
      ssh: {
        publicKeys: [
          {
            keyData: publicKey
          }
        ]
      }
    }
  }
  sku: {
    name: 'Base'
    tier: 'Standard'
  }
}

output aksId string = aks.id
