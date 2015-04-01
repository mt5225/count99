c99 = c99 or {}
c99.Game = do ->
  Count99Game = ->
    console.log('count 99 game starts')
    @canvas = document.getElementById('game-canvas')
    @stage = new (createjs.Stage)(@canvas)
    @stage.name = 'Main Stage'

    # the onPress event handler
    @tileOnPress = (evt)->
      console.log "Obj: #{evt.target} clicked in Stage: #{@stage}"
      @stage.removeChild evt.target.parent
      @stage.update()

    # make tiles
    for i in [10..1]
      tile = new (c99.GameObject)(i)
      tile.x = Math.random()*(@canvas.width - tile.width)
      tile.y = Math.random()*(@canvas.height - tile.height)
      console.log("position: #{tile.x} #{tile.y}")
      tile.on 'click', @tileOnPress.bind(@)
      @stage.addChild tile

    #update stage
    @stage.update()

  Count99Game

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
