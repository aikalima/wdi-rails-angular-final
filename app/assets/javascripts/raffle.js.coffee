WDI = WDI || {}

WDI.app = angular.module("Raffler", ["ngResource", 'WDI.factories', 'WDI.directives'])

@TestCtrl = ["$scope", ($scope) ->
  $scope.name = 'Markus'
]

@RaffleCtrl = ["$scope", "Entry", ($scope, Entry) ->
  $scope.entries = Entry.query()

  $scope.saveRating = (rating, entry) ->
    entry.rating = rating
    Entry.update entry

  $scope.addEntry = ->
    entry = Entry.save($scope.newEntry)
    $scope.entries.push(entry)
    $scope.newEntry = {}

  $scope.drawWinner = ->
    pool = []
    angular.forEach $scope.entries, (entry) ->
      pool.push(entry) if !entry.winner
    if pool.length > 0
      entry = pool[Math.floor(Math.random()*pool.length)]
      entry.winner = true
      Entry.update(entry)
      # Note: line below would also works, see ng docs
      # entry.$update()
      $scope.lastWinner = entry
    else
      # everybody won, reset ...
      _.map $scope.entries, (entry,key) ->
        entry.winner = false
        Entry.update(entry)


]