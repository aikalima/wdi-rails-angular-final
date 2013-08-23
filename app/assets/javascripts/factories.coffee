factoriesModule = angular.module('WDI.factories', [])

factoriesModule.factory "Entry", ["$resource", ($resource) ->
  $resource("/entries/:id", {id: "@id"},{
    update: {method: "PUT"}
  })
]