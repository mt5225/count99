c99 = c99 or {}

#########################
#Define of game class
#########################
c99.Game = do ->
  Count99Game = ->
    console.log('count99 game starts')

    #create main stage
    @canvas = document.getElementById('game-canvas')
    @stage = new (createjs.Stage)(@canvas)
    @stage.name = 'Main Stage'
    @gameInit()  #init game

    restartButton = document.getElementById('restart-button')
    restartButton.onclick = ((evt) ->
      gameOverScene = document.getElementById("gameover")
      gameOverScene.classList.remove("gameover-appear")
      @gameInit()
    ).bind(@)

  #game init
  Count99Game.prototype.gameInit = ->
    @nextCount = 1
    @totalTile = 3
    @nextCountLabel = document.getElementById('next-count')

    # the onPress event handler for the tile
    @tileOnPress = (evt)->
      console.log "Obj: #{evt.target} clicked in Stage: #{@stage}"
      if(evt.target.name == @nextCount)
        @stage.removeChild evt.target.parent
        @stage.update()
        @nextCount++
        @nextCountLabel.innerHTML= @nextCount
        #game over logic
        if(@nextCount > @totalTile)
            @gameOver()

    # make 10 tiles
    for i in [@totalTile..1]
      tile = new (c99.GameObject)(i)
      tile.x = Math.random()*(@canvas.width - tile.width)
      tile.y = Math.random()*(@canvas.height - tile.height)
      console.log("position: #{tile.x} #{tile.y}")
      tile.on 'click', @tileOnPress.bind(@)
      @stage.addChild tile

    #update the stage
    @stage.update()

  #game over logic
  Count99Game.prototype.gameOver = ->
      @nextCount = 1
      @nextCountLabel.innerHTML = @nextCount
      gameOverScene = document.getElementById("gameover")
      gameOverScene.classList.add("gameover-appear")

  Count99Game

##############################################
# Define of game object: block with number
##############################################
c99.GameObject = do ->
  GameObject = (number)->
    @number = number
    @initialize()
    return

  p = GameObject.prototype = new (createjs.Container)
  # instance variables
  p.category = 'object'
  p.width = 80
  p.height = 80
  p.Container_initialize = p.initialize

  p.initialize = ->
    @Container_initialize()
    img = new (createjs.Bitmap)('image/tile.png')
    img.name = @number
    @.addChild(img)

    numText = new (createjs.Text)(@number, '24px Helvetica', '#ac1000')
    numText.x = @width / 2
    numText.y = @height /2
    numText.textAlign = 'center'
    numText.textBaseline = 'middle'
    @.addChild(numText)
    return
  GameObject

window.onload = ->
  # entry point
  game = new (c99.Game)
  return
