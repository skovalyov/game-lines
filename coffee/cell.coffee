class Cell

	constructor : (@board, @row, @column) ->
		@element = $ "<td></td>"
		@image = $ "<div></div>"
		@element.append @image

	# Reference to the DOM element.
	getElement : () ->
		@element

	show : (@color, animate = false) ->
		@image.addClass @color
		if animate
			@image.one "webkitAnimationEnd animationend", =>
				@image.removeClass "circle-fade-in"
			@image.addClass "circle-fade-in"

	hide : (animate = false) ->
		onAnimationEnd = () ->
			@image.removeClass()
			@color = null
		if animate
			@image.addClass "circle-fade-out"
			@image.one "webkitAnimationEnd animationend", () =>
				onAnimationEnd.apply @
		else
			onAnimationEnd.apply @

	select : () ->
		@image.addClass "circle-jump"
		
	deselect : () ->
		@image.removeClass "circle-jump"