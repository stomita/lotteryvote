"use strict"

_ = require "lodash"
Promise = require "promise"

module.exports = () ->

  getElection: (electionId) ->
    Promise.resolve(
      require("./data/elections")[0]
    )

  getElections: ->
    Promise.resolve(
      require "./data/elections"
    )

  getCandidates: (electionId) ->
    Promise.resolve(
      require "./data/candidates"
    )

  getMyVotes: (electionId) ->
    Promise.resolve(
      require "./data/votes"
    )


