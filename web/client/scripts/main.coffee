"use strict"

module.exports = angular.module "app", [
  "ngRoute"
  require("./controller").name
  require("./service").name
  require("./directive").name
]

.config [
  '$routeProvider'
  ($routeProvider) ->
    $routeProvider
      .when "/", 
        controller: 'BaseControl'
        templateUrl: 'templates/root.html'
      .otherwise 
        redirectTo: '/'
]

.controller "MainControl", ($scope) ->
  $scope.title = "LotteryVote"
  $scope.handleSliderChange = (v) -> console.log v
