param name string
param location string

@allowed([
  'aks'
  'vnet'
])
param resourceType string

var replaceSpace = replace(name, ' ', '-')
var replaceName = '${resourceType}-${location}-${replaceSpace}'

output fixedName string = replaceName
