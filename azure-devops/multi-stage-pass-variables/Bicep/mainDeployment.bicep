targetScope = 'subscription'

@allowed([
  'dev'
  'test'
  'prod'
])
param environmentShort string
param location string = 'westeurope'
param locationShort string = 'we'

resource rgshared 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-shared-${environmentShort}-${locationShort}-001'
  location: location
}

var kubeletIdentityName = 'id-demo-kubelet-${environmentShort}-${locationShort}-001'

module kubeletIdentity 'userAssignedIdentities.bicep' = {
  scope: rgshared
  name: 'kubeletIdentity'
  params: {
    identityName: kubeletIdentityName
    location: location
  }
}

var acrName = 'acrdemo${environmentShort}${locationShort}001'

module acr 'registries.bicep' = if (environmentShort == 'prod') {
  scope: rgshared
  name: 'acr'
  params: {
    location: location
    name: acrName
  }
}

output kubeletIdentityPrincipalId string = kubeletIdentity.outputs.principalId
output acrId string = environmentShort == 'prod' ? acr.outputs.id : ''
