"use strict"

module.exports = angular.module "app.controller", []

.controller "HomeControl", require "./home"
.controller "LotteryControl", require "./lottery"
.controller "ProxyPickerControl", require "./proxy-picker"