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
        redirectTo: '/election/test'
      .when "/election/:id", 
        controller: 'VoteControl'
        templateUrl: 'templates/vote.html'
      .otherwise 
        redirectTo: '/'
]

.controller "MainControl", ($scope) ->
  $scope.title = "LotteryVote"
