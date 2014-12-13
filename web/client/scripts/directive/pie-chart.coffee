"use strict"

$ = require "jquery"

module.exports = ($timeout) ->
  restrict: 'E'
  template: """
    <div ng-style="{ width: width+'px', height: height+'px', overflow: 'hidden' }">
      <nvd3-pie-chart
        data="data"
        width="{{ nWidth + 100 }}"
        height="{{ nHeight + 100 }}"
        x="xFunction"
        y="yFunction"
        color="colorFunction"
        showLabels="true"
        donut="true"
        donutRatio=".30"
      >
        <svg style="margin-left: -50px; margin-top: -50px;"></svg>
      </nvd3-pie-chart>
    </div>
  """
  scope:
    data: '=data'
    width: '@'
    height: '@'
  controller: [ "$scope", ($scope) ->
    $scope.xFunction = (d) ->
      d.key || '(none)'
    $scope.yFunction = (d) ->
      d.y || 0
    $scope.colorFunction = (d, i) ->
      d.data?.color || '#aaa'
  ]
  link: ($scope, $element, $attrs) ->
    $element = $($element)
    $scope.nWidth = $scope.width || $element.parent().width()
    $scope.nHeight = +$scope.height
