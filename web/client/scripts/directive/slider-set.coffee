"use strict"

_ = require "lodash"

module.exports = ->
  restrict: 'E'
  templateUrl: 'templates/common/slider-set.html'
  scope:
    elements: '='
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
          index = Math.floor(Math.random() * others.length)
          others[index]?.weight -= diff - reduced
      elem.weight = weight
      $scope.$apply()
  ]
  link: ($scope, $element, $attrs) ->
