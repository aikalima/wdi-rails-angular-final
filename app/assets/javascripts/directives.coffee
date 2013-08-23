directivesModule = angular.module('WDI.directives', [])

directivesModule.directive 'starRating', () ->
  restrict: 'A', # directive to be used as attribute of an element
  template: "<ul class='rating'>" + "<li ng-repeat='star in stars' ng-class='star' ng-click='toggle($index)'>" + "★" + "</li>" + "</ul>",
  scope: # scope variables. Values are passed in as attributes, see html
    ratingValue: "=",
    max: "="
    onRatingSelected: '&'
  link: (scope, elem, attrs) ->
    # link function: it's like a directive controller

    # anytime stars change, redraw the whole thing
    updateStars = () ->
      scope.stars = []
      i = 0
      while i < scope.max
        scope.stars.push {
               filled: i < scope.ratingValue
              }
        i++

    #watch for changes to the ratingValue
    scope.$watch 'ratingValue', (newVal, oldVal) ->
      # take action -> redraw stars
      if newVal then updateStars()

    #on-click event handler, see directive html
    scope.toggle = (index) ->
      # ng-repeat indexed [0 ..9], add 1 to get rating [1..10]
      newRating = index + 1
      # change the ratingValue, will wake up watcher
      scope.ratingValue = newRating
      # just fire event, it evaluates expression in on-rating-selected, see html
      scope.onRatingSelected {newRating: scope.ratingValue}

