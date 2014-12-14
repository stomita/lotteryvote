"use strict"

module.exports = angular.module "app.controller", []

.controller "VoteControl", require "./vote"
.controller "LotteryControl", require "./lottery"
.controller "ProxyPickerControl", require "./proxy-picker"