"use strict"

module.exports = ($scope, LotteryVote, votes) ->
  $scope.proxies = []
  LotteryVote.getProxies().then (proxies) ->
    $scope.proxies = proxies

  $scope.isInSelection = (proxy) ->
    return true for vote in votes when vote.whoId == proxy.id
    return false
