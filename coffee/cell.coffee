class Cell

  constructor : (@board, @row, @column) ->
    @element = document.createElement "td"
    @image = document.createElement "div"
    @element.appendChild @image

  # Reference to the DOM element.
  getElement : () ->
    @element

  show : (@color, animate = false) ->
    @image.className += (" " + @color)
    onAnimationEnd = (e) =>
      @image.className = @image.className.replace /\bcircle-fade-in\b/, ""
      @image.removeEventListener e.type, onAnimationEnd
    if animate
      @image.addEventListener "webkitAnimationEnd", onAnimationEnd
      @image.addEventListener "animationend", onAnimationEnd
      @image.className += " circle-fade-in"

  hide : (animate = false) ->
    onAnimationEnd = (e) =>
      if e
        @image.removeEventListener e.type, onAnimationEnd
      @image.className = ""
      @color = null
    if animate
      @image.addEventListener "webkitAnimationEnd", onAnimationEnd
      @image.addEventListener "animationend", onAnimationEnd
      @image.className += " circle-fade-out"
    else
      onAnimationEnd()

  select : () ->
    @image.className += " circle-jump"
    
  deselect : () ->
    @image.className = @image.className.replace /\bcircle-jump\b/, ""