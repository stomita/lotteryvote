"use strict"

$ = require "jquery"

module.exports = ($document) ->
  restrict: 'E'
  template: """
    <span class="photo" ng-click="handleClick()"></span>
  """
  scope:
    photo: '='
    onClick: "&click"
  link: ($scope, $element, $attrs) ->
    $element = $($element)
    $scope.handleClick = -> $scope.onClick?()
    $scope.$watch "photo", (photoUrl) ->
      $element.find(".photo").css
        "background-image": "url(#{photoUrl})"
        "background-size": "100% auto"
