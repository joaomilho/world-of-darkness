'use strict';

preload = ->
  game.load.image('background','assets/world.png')
  #game.load.image('foreground','assets/world-overlay.png')

  #game.load.image('player','assets/hero-start.png')
  game.load.spritesheet('player', 'assets/hero-start.png', 32.5, 48.5);
  game.load.audio('phase0', 'assets/phase0.mp3');
  game.load.tilemap('map', 'assets/tile_set_collision.csv', null, Phaser.Tilemap.CSV);
  game.load.image('tilemap', 'assets/tilemap.png');

player = null
cursors = null
map = null
layer = null

create = ->
  game.add.tileSprite(0, 0, 2144, 2176, 'background');
  game.world.setBounds(0, 0, 2144, 2176);
  game.physics.startSystem(Phaser.Physics.P2JS);
  map = game.add.tilemap('map', 10, 10);
  map.addTilesetImage('tilemap');
  layer = map.createLayer(0);
  layer.alpha = .5
  #layer.resizeWorld();
  map.setCollisionBetween(1, 1);
  layer.debug = true;

  player = game.add.sprite(2100, 1500, 'player');
  player.width = 130/5
  player.height = 194/5
  player.animations.add('down', [0..3])
  player.animations.add('left', [4..7])
  player.animations.add('right', [8..11])
  player.animations.add('up', [12..15])

  #game.add.tileSprite(0, 0, 2144, 2176, 'foreground');

  game.physics.p2.enable(player);
  #game.physics.enable(player);

  cursors = game.input.keyboard.createCursorKeys();
  game.camera.follow(player);
  #//  The deadzone is a Rectangle that defines the limits at which the camera will start to scroll
  #//  It does NOT keep the target sprite within the rectangle, all it does is control the boundary
  #//  at which the camera will start to move. So when the sprite hits the edge, the camera scrolls
  #//  (until it reaches an edge of the world)
  #game.camera.deadzone = new Phaser.Rectangle(100, 100, 600, 400);
  #music = game.add.audio('phase0');
  #music.play();

speed = 390
update = ->
  player.body.setZeroVelocity()



  console.log("XXX", player, layer);
  game.physics.arcade.collide(player, layer);

  animate = null
  if cursors.up.isDown
    player.body.moveUp(speed)
    animate = 'up'
  else if cursors.down.isDown
    player.body.moveDown(speed)
    animate = 'down'
  else if cursors.left.isDown
    player.body.moveLeft(speed)
    animate = 'left'
  else if cursors.right.isDown
    player.body.moveRight(speed)
    animate = 'right'

  if animate
    player.animations.play(animate, 8, true)
  else
    player.animations.stop()

render = ->
  #zone = game.camera.deadzone
  #game.context.fillStyle = 'rgba(255,0,0,0.6)'
  #game.context.fillRect(zone.x, zone.y, zone.width, zone.height)
  game.debug.cameraInfo(game.camera, 32, 32)
  game.debug.spriteCoords(player, 32, 500)

actions =
  preload: preload
  create: create
  update: update
  render: render

game = new Phaser.Game 1280, 700, Phaser.CANVAS, 'world-of-darkness-game', actions

#resizeGame = ->
  #height = $(window).height()
  #width = $(window).width()

  #game.width = width
  #game.height = height

#$(window).resize(resizeGame)

