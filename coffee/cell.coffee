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
			onAnimationEnd = () ->
				@image.removeClass "circle-fade-in"
			@image.one "webkitAnimationEnd mozAnimationEnd", $.proxy onAnimationEnd, this
			@image.addClass "circle-fade-in"

	hide : (animate = false) ->
		@color = null
		onAnimationEnd = () ->
			@image.removeClass()
		if animate
			@image.one "webkitAnimationEnd mozAnimationEnd", $.proxy onAnimationEnd, this
			@image.addClass "circle-fade-out"
		else
			onAnimationEnd.apply @

	select : () ->
		@image.addClass "circle-jump"
		
	deselect : () ->
		@image.removeClass "circle-jump"