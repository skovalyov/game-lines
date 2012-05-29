class Scoreboard

	constructor : () ->
		@element = $ "<p></p>"
		@resetScore()

	# Reference to the DOM element.
	getElement : () ->
		@element

	resetScore : () ->
		@score = 0
		@updateScore()

	increaseScore : (numCircles) ->
		@score += 10 + (numCircles - 4) * 20 if numCircles >= 4
		@updateScore()

	updateScore : () ->
		@element.text @score.toString()