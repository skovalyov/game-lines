class Scoreboard

	constructor : () ->
		@element = document.createElement "p"
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
		if @element.firstChild
			@element.removeChild @element.firstChild
		@element.appendChild document.createTextNode @score.toString()