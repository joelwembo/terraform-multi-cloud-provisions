param location string
param name string

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2021-09-01' = {
  name: name
  location: location
  sku: {
    name: 'Premium'
  }
}

output name string = containerRegistry.name
output id string = containerRegistry.id
