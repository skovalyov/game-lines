class Board

  COLORS = ["circle-red", "circle-green", "circle-blue", "circle-yellow"]

  constructor : (@scoreboard, @w = 6, @h = 6, @newCirclesNum = 3, @lineLength = 4) ->

    addCell = (rowElement, cell) ->
      cellElement = cell.getElement()
      cellElement.addEventListener "click", (event) =>
        @selectCell cell
      rowElement.appendChild cellElement
      @cells[i].push cell
      @emptyCells.push cell

    @enabled = true
    # Two-dimensional array of cells.
    @cells = []
    @emptyCells = []
    @element = document.createElement "tbody"
    for i in [0..@h - 1]
      @cells.push []
      rowElement = document.createElement "tr"
      @element.appendChild rowElement
      for j in [0..@w - 1]
        cell = new Cell @, i, j
        addCell.call @, rowElement, cell
    @addNewCircles()

  # Reference to the DOM element.
  getElement : () ->
    @element
    
  addNewCircles : () ->
    i = 0
    # Add the predefined number of new circles.
    while i++ < @newCirclesNum
      # Get a random empty cell.
      randomCellIndex = Math.floor Math.random() * @emptyCells.length
      randomCell = @emptyCells[randomCellIndex]
      # Remove the cell from the empty cells array as we put the circle into it.
      @emptyCells.splice randomCellIndex, 1
      # Get a random color for the new circle.
      randomColorIndex = Math.floor Math.random() * COLORS.length
      randomColor = COLORS[randomColorIndex]
      # Put the circle into the cell.
      randomCell.show randomColor, true
    @removeLines()
      
  removeLines : () ->
    @cellsToClean = []
    for i in [0..@h - 1]
      for j in [0..@w - 1]
        # Check for vertical lines.
        if i < @h - @lineLength + 1
          @testLine (@cells[i + k][j] for k in [0..@lineLength - 1])
        # Check for horizontal lines.
        if j < @w - @lineLength + 1
          @testLine (@cells[i][j + k] for k in [0..@lineLength - 1])
        # Check for lt > rb diagonal lines.
        if i < @h - @lineLength + 1 and j < @w - @lineLength + 1
          @testLine (@cells[i + k][j + k] for k in [0..@lineLength - 1])
        # Check for rt > lb diagonal lines.
        if i < @h - @lineLength + 1 and j >= @lineLength - 1
          @testLine (@cells[i + k][j - k] for k in [0..@lineLength - 1])
    @cleanCell cell for cell in @cellsToClean
    @scoreboard.increaseScore @cellsToClean.length

  testLine : (line) ->
    removeLine =
      line.every (cell, index) ->
        (index == line.length - 1 or cell.color and cell.color == line[index + 1].color)
    if removeLine
      @cellsToClean = @cellsToClean.concat (cell for cell in line when @cellsToClean.indexOf(cell) == -1)
  
  cleanCell : (cell) ->
    cell.hide true
    @emptyCells.push cell

  selectCell : (cell) ->
    # If some circle is already selected and the user clicks on an empty cell,
    # move the selected circle to the clicked cell. 
    if @enabled and @selectedCell and not cell.color
      path = @findPath @selectedCell.column, @selectedCell.row, cell.column, cell.row
      if path.length > 0
        @moveCell @selectedCell, path
        @selectedCell = null
    # If there is a circle in the clicked cell, select it.
    if cell.color
      if @selectedCell
        @selectedCell.deselect()
      @selectedCell = cell
      @selectedCell.select()
      
  moveCell : (@movableCell, @path) ->
    # Disable parallel move invocation.
    @enabled = false
    # Reset the step counter.
    @step = 0
    # Add the clicked cell to the empty cells array as the circle is moving out of it.
    @emptyCells.push @movableCell
    # Initialize step by step move.
    @moveInterval = setInterval =>
      @makeNextCellMove()
    , 100
  
  makeNextCellMove : () ->
    movableCellColor = @movableCell.color
    @movableCell.hide()
    stepData = @path[@step]
    @movableCell = @cells[stepData.row][stepData.column]
    @movableCell.show movableCellColor
    @step++
    if @step == @path.length
      clearInterval @moveInterval
      cellIndex = @emptyCells.indexOf @movableCell
      @emptyCells.splice cellIndex, 1
      @removeLines()
      # Add new circles if no cells are removed or there are no circles on the board.
      @addNewCircles() if @cellsToClean.length == 0 or @emptyCells.length == @w * @h
      # Enable move invocation again upon move complete.
      @enabled = true
  
  getQueueHashKey : (column, row) ->
    "#{column}.#{row}"
    
  findPath : (column1, row1, column2, row2) ->
    @targetColumn = column1
    @targetRow = row1
    @queue = []
    @queueHash = {}
    @stepsToTarget = Number.MAX_VALUE
    # Recursively navigate through the board to find the shortest path.
    @inspectCell column2, row2
    # Return reversed path.
    @queue.reverse()

  inspectCell : (currentColumn, currentRow, queue = [], step = 0) ->
    # Target cell reached.
    if currentColumn == @targetColumn and currentRow == @targetRow
      @stepsToTarget = step
      @queue = queue
    # Column out of range.
    if not (@w > currentColumn >= 0)
      return
    # Row out of range.
    if not (@h > currentRow >= 0)
      return
    # Get queue hash key of the inspected cell.
    queueHashKey = @getQueueHashKey currentColumn, currentRow
    # Check if the cell has been already visited and that step value is less or equal to the current step value.
    if @queueHash[queueHashKey] <= step
      return
    # Get reference to the inspected cell.
    cell = @cells[currentRow][currentColumn]
    # Ball in the cell.
    if cell.color
      return
    # Add step to the queue.
    stepData =
      column : currentColumn
      row : currentRow
      step : step
    queue = queue.concat stepData
    @queueHash[queueHashKey] = step
    # Inspect adjacent cells.
    if (step < @stepsToTarget)
      step++
      @inspectCell currentColumn - 1, currentRow, queue, step
      @inspectCell currentColumn + 1, currentRow, queue, step
      @inspectCell currentColumn, currentRow - 1, queue, step
      @inspectCell currentColumn, currentRow + 1, queue, step