"use strict"

_ = require "lodash"

module.exports = ($q, $timeout) ->

  getElection: (electionId) ->
    $q (resolve) ->
      $timeout ->
        resolve(require("./data/elections")[0])

  getElections: ->
    $q (resolve) ->
      $timeout ->
        resolve(require "./data/elections")

  getMyVotes: (electionId) ->
    $q (resolve) ->
      $timeout ->
        resolve(require "./data/votes")

  saveMyVotes: (electionId, votes) ->
    $q (resolve) ->
      $timeout ->
        resolve(success: true)


