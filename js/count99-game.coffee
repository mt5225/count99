c99 = c99 or {}  #declare an empty blacket to holding stuff

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
    createjs.Touch.enable(@stage)
    #init game
    preloader = new (c99.Preloader)(@)
    preloader.loadGraphics()

    #bind the restart game button
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
# Image preloader
##############################################
c99.Preloader = do ->
  Preloader = (game)->
    @game = game
    return
  Preloader.prototype.loadGraphics = ->
    imageList = [
      {name:'tile', path:'image/tile.png'}
      {name:'hud', path:'image/hud.png'}
      {name:'gameover', path:'image/gameover.jpg'}
      {name:'bg', path:'image/bg.png'}
      {name:'restartButton', path:'image/restart-button.png'}
    ]
    loadFiles = 0
    c99.graphics = {}
    for item in imageList
      img = new Image()
      img.onload = ((evt)->
        loadFiles++
        console.log "#{evt.target.src} loaded, progress=#{loadFiles}, total=#{imageList.length}"
        if loadFiles == imageList.length
          @game.gameInit()
      ).bind(@)
      img.src = item.path
      c99.graphics[item.name] = item

  Preloader

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
    img = new (createjs.Bitmap)(c99.graphics.tile.path) #from preloader
    img.name = @number
    @.addChild(img)

    numText = new (createjs.Text)(@number, '24px PFTempestaFiveCompressed-Regular,sans-serif', '#ac1000')
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
