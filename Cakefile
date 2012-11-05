{exec} = require 'child_process'

onExec = (error, stdout, stderr) ->
  console.log stdout if stdout?
  console.log stderr if stderr?
  console.log error if error?

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

task "publishGitHubPages", "Publish GitHub Pages", () ->
  console.log "Publishing GitHub Pages..."
  cp = exec "git checkout gh-pages", onExec
  cp = exec "git read-tree master:public", onExec
  cp = exec "git commit -m 'Publish GitHub pages'", onExec
  cp = exec "git push origin gh-pages", onExec
  cp = exec "git checkout master", onExec
