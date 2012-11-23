module.exports = (app) ->
  # Index Page GET
  app.get "/", (req, res) ->
    res.render "index",
      title: "Neptune"