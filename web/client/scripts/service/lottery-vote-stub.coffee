"use strict"

_ = require "lodash"
Promise = require "promise"

module.exports = () ->
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


