window.onload = () ->
  scoreboard = new Scoreboard
  document.getElementById("scoreboard").appendChild scoreboard.getElement()
  board = new Board scoreboard
  document.getElementById("board").appendChild board.getElement()