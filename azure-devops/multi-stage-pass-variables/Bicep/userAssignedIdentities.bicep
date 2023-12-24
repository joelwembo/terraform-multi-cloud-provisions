param identityName string
param location string

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: identityName
  location: location
}

output id string = managedIdentity.id
output principalId string = managedIdentity.properties.principalId
