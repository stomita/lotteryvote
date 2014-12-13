"use strict"

_ = require "lodash"
$ = require "jquery"

module.exports = ($document) ->
  restrict: 'E'
  template: """
    <div class="slider">
      <div class="bar"></div>
      <div class="title">{{ title }}</div>
      <div class="weight">{{ value }} %</div>
    </div>
  """
  scope:
    title: '='
    value: '='
    color: '='
    onChange: '&change'
    onComplete: '&complete'
  link: ($scope, $element, $attrs) ->
    $element = $($element)
    $slider = $element.find('div.slider')
    $bar = $element.find('div.bar')
    width = null
    offset = null
    adjustBar = (e) ->
      pageX = e.pageX || e.originalEvent?.touches?[0]?.pageX
      if pageX
        diff = pageX - offset
        diff = 0 if diff < 0
        diff = 100 if diff > width
        value = Math.round(100 * diff / width)
        $bar.width "#{value}%"
        $scope.onChange?(value: value)
    mouseDown = false;
    $element.on "mousedown touchstart", (e) ->
      mouseDown = true
      width = $slider.width()
      offset = $bar.offset().left
      adjustBar(e)
    $document.on "mouseup touchend", (e) ->
      $scope.onComplete?() if mouseDown
      mouseDown = false
    $element.on "mousemove touchmove", (e) ->
      return unless mouseDown
      adjustBar(e)
    $scope.$watch "value", (value) ->
      $bar.width "#{value}%"
    $scope.$watch "color", (color) ->
      $bar.css "background-color", color
