"use strict"

module.exports = angular.module "app.service", []
.factory "LotteryVote",
  if typeof LVRemoteController == 'object'
    require "./lottery-vote"
  else
    require "./lottery-vote-stub"