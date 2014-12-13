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
      $element.css "background-image", "url(#{photoUrl})"
