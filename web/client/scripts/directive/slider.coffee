"use strict"

_ = require "lodash"
$ = require "jquery"

module.exports = ->
  restrict: 'E'
  template: '<div class="slider"><span class="bar"></span></div>'
  scope:
    onChange: '&'
  link: (scope, element, $attrs) ->
    $element = $(element)
    $slider = $element.find('div.slider')
    $bar = $element.find('span.bar')
    width = null
    offset = null
    mouseDown = false;
    element.on "mousedown touchstart", (e) ->
      mouseDown = true
      width = $slider.width() unless width
      offset = $bar.offset().left unless offset
      adjustBar(e)
    element.on "mouseup touchend", (e) ->
      mouseDown = false
    element.on "mousemove touchmove", _.throttle (e) ->
      return unless mouseDown
      adjustBar(e)
    adjustBar = (e) ->
      pageX = e.pageX || e.originalEvent?.touches?[0]?.pageX
      if pageX
        diff = pageX - offset
        diff = 0 if diff < 0
        diff = 100 if diff > width
        value = Math.round(100 * diff / width)
        $bar.width "#{value}%"
        scope.sliderValue = value
