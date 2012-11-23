# include Module dependencies.
express = require("express")
http = require("http")
path = require("path")

app = express()

# configure the http server
app.configure ->
  app.set "port", process.env.PORT or 3002
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))

# configure logging
app.configure "development", ->
  app.use express.errorHandler()

# include the main routing table
require('./routes/main')(app);

# start up the http server
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
