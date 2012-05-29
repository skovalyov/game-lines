$(document).ready ->
	scoreboard = new Scoreboard
	scoreboard.getElement().appendTo $ "#scoreboard"
	board = new Board scoreboard
	board.getElement().appendTo $ "#board"