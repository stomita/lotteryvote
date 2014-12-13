"use strict"

_ = require "lodash"
theme = require "../common/theme"

module.exports = ($scope, $timeout, $modal, LotteryVote) ->

  colors = theme["default"].colors

  $scope.votes = []
  $scope.voteRates = []

  LotteryVote.getElection().then (election) ->
    $scope.election = election
    $scope.$apply()

  LotteryVote.getMyVotes().then (votes) ->
    $scope.votes =
      for vote, i in votes
        who = vote.candidate || vote.proxy
        {
          id: vote.id
          name: who.name
          weight: vote.weight
          type: if vote.candidate then 'candidate' else 'proxy'
          color: if vote.candidate then colors[i % colors.length] else "#bbbbbb"
          iconUrl: who.iconUrl
        }
    $scope.$apply()
    $scope.calcVoteRates()
  .catch (err) ->
    console.error err

  $scope.hasProxies = ->
    _.find $scope.votes, (el) -> el.type == 'proxy'

  $scope.hasValidVotes = ->
    _.find $scope.votes, (el) -> el.weight > 0

  $scope.addProxy = ->
    modal = $modal.open
      templateUrl: 'templates/proxy-picker.html'
      controller: 'ProxyPickerControl'

  $scope.startLottery = ->
    modal = $modal.open
      templateUrl: 'templates/lottery.html'
      controller: 'LotteryControl'
      resolve:
        election: -> $scope.election
        votes: -> $scope.votes

  $scope.calcVoteRates = ->
    $scope.voteRates = []
    totalWeights = 0
    proxyWeights = 0
    for elem in $scope.votes
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
    $timeout -> $scope.$apply()

