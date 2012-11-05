{exec} = require 'child_process'

onExec = (error, stdout, stderr) ->
  throw error if error
  console.log stdout + stderr

task "watch", "Watch All", () ->
  invoke "watchStylus"
  invoke "watchCoffeeScript"

task "watchStylus", "Watch Stylus", () ->
  console.log "Watching Stylus..."
  cp = exec "stylus -o ./public/css/ -w ./src/stylus/", onExec

task "watchCoffeeScript", "Watch CoffeeScript", () ->
  console.log "Watching CoffeeScript..."
  cp = exec "coffee -j ./public/js/game.js -cw ./src/coffee/", onExec

task "build", "Build All", () ->
  invoke "buildStylus"
  invoke "buildCoffeeScript"

task "buildStylus", "Build Stylus", () ->
  console.log "Building Stylus..."
  cp = exec "stylus -o ./public/css/ ./src/stylus/", onExec

task "buildCoffeeScript", "Build CoffeeScript", () ->
  console.log "Building CoffeeScript..."
  cp = exec "coffee -j ./public/js/game.js -c ./src/coffee/", onExec