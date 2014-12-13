"use strict"

$ = require "jquery"

module.exports = ($document) ->
  restrict: 'E'
  template: '<span class="photo"></span>'
  scope:
    photo: '='
  link: ($scope, $element, $attrs) ->
    $element = $($element)
    $scope.$watch "photo", (photoUrl) ->
      $element.find(".photo").css
        "background-image": "url(#{photoUrl})"
        "background-size": "100% auto"
