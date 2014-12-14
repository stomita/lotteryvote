"use strict"

_ = require "lodash"
theme = require "../common/theme"

module.exports = ($scope, $routeParams, $q, $timeout, $modal, LotteryVote) ->

  electionId = $routeParams.id

  colors = theme["default"].colors

  $scope.votes = []
  $scope.voteRates = []

  $q.all [
    LotteryVote.getElection(electionId)
  ,
    LotteryVote.getMyVotes(electionId)
  ]
  .then (rets) ->
    $scope.election = rets[0]
    votes = rets[1]
    $scope.votes =
      if votes.length > 0
        for vote, i in votes
          who = vote.candidate || vote.proxy
          {
            id: vote.id
            whoId: who.id
            name: who.name
            weight: vote.weight
            type: if vote.candidate then 'candidate' else 'proxy'
            color: if vote.candidate then colors[i % colors.length] else "#bbbbbb"
            iconUrl: who.iconUrl
          }
      else
        for candidate, i in $scope.election.candidates
          {
            id: "id-#{Math.random()}"
            whoId: candidate.id
            name: candidate.name
            weight: 0
            type: 'candidate'
            color: colors[i % colors.length]
            iconUrl: candidate.iconUrl
          }
    $scope.$apply()
    calcVoteRates()
  .catch (err) ->
    console.error err


  $scope.hasProxies = ->
    _.find $scope.votes, (el) -> el.type == 'proxy'


  $scope.addProxy = ->
    modal = $modal.open
      templateUrl: 'templates/proxy-picker.html'
      controller: 'ProxyPickerControl'
      resolve:
        votes: -> $scope.votes
    modal.result.then (ret) ->
      proxy = ret.proxy
      if ret.action == 'add'
        $scope.votes.push
          id: "id-#{Math.random()}"
          whoId: proxy.id
          name: proxy.name
          weight: 0
          type: 'proxy'
          color: "#bbbbbb"
          iconUrl: proxy.iconUrl
      else
        $scope.votes = $scope.votes.filter (vt) -> vt.whoId != proxy.id
      $scope.completeVoteChange()
    .catch (err) ->
      console.error err


  $scope.startLottery = ->
    $modal.open
      templateUrl: 'templates/lottery.html'
      controller: 'LotteryControl'
      resolve:
        election: -> $scope.election
        votes: -> $scope.votes

  $scope.completeVoteChange = ->
    calcVoteRates()
    votes =
      for vote in $scope.votes
        id: if String(vote.id).indexOf('id-') == 0 then null else vote.id
        weight: vote.weight
        candidate:
          if vote.type == 'candidate'
            id: vote.whoId
            name: vote.name
          else
            null
        proxy:
          if vote.type == 'proxy'
            id: vote.whoId
            name: vote.name
          else
            null
    LotteryVote.saveMyVotes(electionId, votes)

  $scope.isChartVisible = false

  calcVoteRates = ->
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
    $scope.isChartVisible = totalWeights > 0
    $timeout -> $scope.$apply()

