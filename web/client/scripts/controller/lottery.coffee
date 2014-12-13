"use strict"

_ = require "lodash"

module.exports = ($scope, $timeout, election, votes) ->
  console.log election, votes
  rvotes = votes.filter (v) -> v.type == 'candidate' && v.weight > 0
  rvotes = rvotes.map (v) ->
    [ v.weight * Math.random(), v ]
  .sort (v1, v2) ->
    if v1[0] < v2[0] then 1
    else if v1[0] > v2[0] then -1
    else 0
  .map (v) -> v[1]
  $timeout ->
    $scope.candidate = rvotes[0]
  , 4000





