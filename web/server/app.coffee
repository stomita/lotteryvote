###
Module dependencies.
###
express = require("express")
http = require("http")
path = require("path")
app = express()
module.exports = app

# all environments
app.set "port", process.env.PORT or 3000
app.set "views", path.join(__dirname, "../views")
app.set "view engine", "ejs"
app.use express.favicon()
app.use express.logger("dev")
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use app.router
app.use express.static(path.join(__dirname, "../public"))
app.configure "development", ->
  app.use express.static(path.join(__dirname, "../.tmp"))
app.configure "production", "staging", ->
  app.use express.static(path.join(__dirname, "../dist"))

# development only
app.use express.errorHandler()  if "development" is app.get("env")

app.get "/", (req, res) ->
  res.render "index"

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
