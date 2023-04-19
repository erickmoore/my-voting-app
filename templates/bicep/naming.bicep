param name string
param location string

@allowed([
  'aks'
  'vnet'
  'acr'
])
param resourceType string

var replaceSpace = replace(name, ' ', '-')
var replaceName = '${resourceType}-${location}-${replaceSpace}'

output resourceName string = replaceName
