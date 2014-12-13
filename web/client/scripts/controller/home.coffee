"use strict"

theme = require "../common/theme"

module.exports = ($scope, $timeout, $modal) ->

  colors = theme["default"].colors

  $scope.voteRates = []

  $scope.elements = [
    { id: 1, name: 'AAA', weight: 10, type: 'candidate', color: colors[0], iconUrl: "/images/aaa.png" }
    { id: 2, name: 'BBB', weight: 40, type: 'candidate', color: colors[1], iconUrl: "/images/bbb.png" }
    { id: 3, name: 'CCC', weight: 30, type: 'candidate', color: colors[2], iconUrl: "/images/ccc.png" }
    { id: 4, name: 'aaa', weight: 0, type: 'proxy', color: '#bbbbbb', iconUrl: "/images/aaa.png" }
    { id: 5, name: 'bbb', weight: 0, type: 'proxy', color: '#bbbbbb', iconUrl: "/images/bbb.png" }
  ]


  $scope.addProxy = ->
    modal = $modal.open
      templateUrl: 'templates/proxy-picker.html'
      controller: 'ProxyPickerControl'
    ###
    $scope.elements.push
      id: $scope.elements.length
      name: 'Added Proxy'
      weight: 0
      type: 'proxy'
    $scope.$apply()
    ###

  $scope.calcVoteRates = ->
    $scope.voteRates = []
    totalWeights = 0
    proxyWeights = 0
    for elem in $scope.elements
      totalWeights += elem.weight
      if elem.type == 'candidate'
        $scope.voteRates.push
          key: elem.name
          y: elem.weight
          color: elem.color 
      else
        proxyWeights += elem.weight
    if proxyWeights > 0
      $scope.voteRates.push
        key: '委任'
        y: proxyWeights
        color: '#bbbbbb'
    if totalWeights < 100
      $scope.voteRates.push
        key: '未決定'
        y: 100 - totalWeights
        color: '#f6f6f6'

    $timeout ->
      console.log $scope.voteRates
      $scope.$apply()

  $scope.calcVoteRates()
