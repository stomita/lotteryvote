"use strict"

module.exports = angular.module "app.directive", [
  "nvd3ChartDirectives"
]
.directive "pieChart", require "./pie-chart"
.directive "photoIcon", require "./photo-icon"
.directive "slider", require "./slider"
.directive "sliderSet", require "./slider-set"