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
    @gameInit()
    restartButton = document.getElementById('restart-game')
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

    # make 10 tiles
    for i in [@totalTile..1]
      tile = new (c99.GameObject)(i)
      tile.x = Math.random()*(@canvas.width - tile.width)
      tile.y = Math.random()*(@canvas.height - tile.height)
      console.log("position: #{tile.x} #{tile.y}")
      tile.on 'click', @tileOnPress.bind(@)
      @stage.addChild tile

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
    shape = new (createjs.Shape)
    shape.name = @number
    shape.graphics.setStrokeStyle(1)
    shape.graphics.beginStroke('#000')
    shape.graphics.beginFill('#efefef')
    shape.graphics.rect(0,0,@width,@height)
    @.addChild(shape)

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
