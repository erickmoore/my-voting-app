param name string
param location string

@allowed([
  'aks'
  'vnet'
  'acr'
])
param resourceType string

var replaceSpace  = replace(name, ' ', '-')
var replaceName   = toLower('${resourceType}-${location}-${replaceSpace}') 
var fullName      = contains('acr', resourceType) ? replace(replaceName, '-', '') : replaceName

output resourceName string = fullName
