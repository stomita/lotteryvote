"use strict"

module.exports = angular.module "app", [
  "ngRoute"
  require("./controller").name
  require("./service").name
]

.config [
  '$routeProvider'
  ($routeProvider) ->
    $routeProvider
      .when "/", 
        controller: 'BaseControl'
        templateUrl: '/root.html'
      .otherwise  redirectTo '/'
]

.controller "MainControl", ($scope, $document) ->
