"use strict"

_ = require "lodash"

module.exports = ->
  restrict: 'E'
  templateUrl: 'templates/common/slider-set.html'
  scope:
    elements: '=source'
    targetType: '@target'
    onComplete: '&complete'
  controller: [ "$scope", ($scope) ->
    $scope.changeWeight = (elem, weight) ->
      others = (el for el in $scope.elements when el.id != elem.id)
      wsum = _.reduce others, (sum, el) ->
        sum + el.weight
      , 0
      if wsum + weight > 100
        diff = wsum + weight - 100
        reduced = 0
        for el in others
          dw = Math.floor(diff * el.weight / wsum)
          el.weight -= dw
          reduced += dw
        if diff > reduced
          dw = diff - reduced
          delements = el for el in others when el.weight >= dw
          index = Math.floor(Math.random() * delements.length)
          delements[index]?.weight -= dw
      elem.weight = weight
      $scope.$apply()
    $scope.handleComplete = ->
      console.log $scope
      $scope.onComplete?()
  ]
  link: ($scope, $element, $attrs) ->
