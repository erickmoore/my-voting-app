param name string
param location string

@allowed([
  'incedentResponse'
  'infosec'
  'sysengineering'
])
param emailDescription string = 'incedentResponse'
param emailToAlert string


resource alertGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: name
  location: location
  properties: {
    enabled: true
    groupShortName: 'myag'
    emailReceivers: [
      {
        name: emailDescription
        emailAddress: emailToAlert
      }
    ]
  }
}

output alertGroupId string = alertGroup.id
