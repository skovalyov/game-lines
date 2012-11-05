routes = (app) ->
  app.get "/data", (req, res) ->
    console.log "Data"

module.exports = routes