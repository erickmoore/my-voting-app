param name      string
param location  string
@allowed([
  'Standard_RAGRS'
  'Standard_GRS'
  'Standard_LRS'
])
param sku       string = 'Standard_RAGRS'
param container string = 'tfstate'

resource stg 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: name
  location: location
  sku: {
    name: sku
  }
  kind: 'StorageV2'
}

resource stgBlob 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' = {
  parent: stg
  name:   'default'
}

resource stgContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
parent: stgBlob
name:   container
}
