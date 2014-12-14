"use strict"

_ = require "lodash"

module.exports = ($window, $q) ->
  service = {}
  for methodName, methodFn of $window.LVRemoteController
    if typeof methodFn == 'function'
      service[methodName] = do (methodFn) ->
        ->
          args = Array.prototype.slice.apply(arguments)
          $q (resolve, reject) ->
            args.push (result, event) ->
              if event.status then resolve(result) else reject(new Error(event.message))
            methodFn.apply($window.LVRemoteController, args)
  service

