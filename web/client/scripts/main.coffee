"use strict"

module.exports = angular.module "app", [
  "ngRoute"
  "ui.bootstrap"
  require("./controller").name
  require("./service").name
  require("./directive").name
]

.config [
  '$routeProvider'
  ($routeProvider) ->
    $routeProvider
      .when "/", 
        controller: 'HomeControl'
        templateUrl: 'templates/home.html'
      .otherwise 
        redirectTo: '/'
]

.controller "MainControl", ($scope) ->
  $scope.title = "LotteryVote"
  $scope.handleSliderChange = (v) -> console.log v
