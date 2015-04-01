// Generated by CoffeeScript 1.9.1
(function() {
  var c99;

  c99 = c99 || {};

  c99.Game = (function() {
    var Count99Game;
    Count99Game = function() {
      var i, j, tile;
      console.log('count 99 game starts');
      this.canvas = document.getElementById('game-canvas');
      this.stage = new createjs.Stage(this.canvas);
      this.stage.name = 'Main Stage';
      this.tileOnPress = function(evt) {
        console.log("Obj: " + evt.target + " clicked in Stage: " + this.stage);
        this.stage.removeChild(evt.target.parent);
        return this.stage.update();
      };
      for (i = j = 10; j >= 1; i = --j) {
        tile = new c99.GameObject(i);
        tile.x = Math.random() * (this.canvas.width - tile.width);
        tile.y = Math.random() * (this.canvas.height - tile.height);
        console.log("position: " + tile.x + " " + tile.y);
        tile.on('click', this.tileOnPress.bind(this));
        this.stage.addChild(tile);
      }
      return this.stage.update();
    };
    return Count99Game;
  })();

  c99.GameObject = (function() {
    var GameObject, p;
    GameObject = function(number) {
      this.number = number;
      this.initialize();
    };
    p = GameObject.prototype = new createjs.Container;
    p.category = 'object';
    p.width = 80;
    p.height = 80;
    p.Container_initialize = p.initialize;
    p.initialize = function() {
      var numText, shape;
      this.Container_initialize();
      shape = new createjs.Shape;
      shape.name = this.number;
      shape.graphics.setStrokeStyle(1);
      shape.graphics.beginStroke('#000');
      shape.graphics.beginFill('#efefef');
      shape.graphics.rect(0, 0, this.width, this.height);
      this.addChild(shape);
      numText = new createjs.Text(this.number, '24px Helvetica', '#ac1000');
      numText.x = this.width / 2;
      numText.y = this.height / 2;
      numText.textAlign = 'center';
      numText.textBaseline = 'middle';
      this.addChild(numText);
    };
    return GameObject;
  })();

  window.onload = function() {
    var game;
    game = new c99.Game;
  };

}).call(this);
