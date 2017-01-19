export gamera = require "framework/dep/gamera"

export game = {
  game_objects: {}

  map_stuff: {
    "player": {r: 255, g: 0,   b: 0}
    "block":  {r: 0,   g: 0,   b: 0}
  }

  grid_size: 16

  level: 1
  levels: {
    [1]: "whatsyourask"
  }
}

game.initialize_assets = ->
  with game
    .sprites = {}

game.load = ->
  with game
    .game_objects = {}

    .initialize_assets!

    .camera = gamera.new 0, 0, love.graphics.getWidth!, love.graphics.getHeight!
    .camera\setWindow 0, 0, love.graphics.getWidth!, love.graphics.getHeight!
    .camera\setScale 3

    .load_level "assets/levels/#{.levels[.level]}.png"

game.update = (dt) ->
  with game
    for g in *.game_objects
      continue if g == nil
      g\update dt if g.update

game.draw = ->
  with game
    .camera\draw ->
      .draw_world!

game.draw_world = ->
  with game
    for g in *.game_objects
      continue if g == nil
      g\draw! if g.draw

game.load_level = (path) ->
  with game
    image = love.image.newImageData path

    for x = 1, image\getWidth!
      row = {}
      for y = 1, image\getHeight!

        rx, ry = x - 1, y - 1
        r, g, b = image\getPixel rx, ry

        for k, v in pairs .map_stuff
          if r == v.r and g == v.g and b == v.b
            .make_entity k, .grid_size * rx, .grid_size * ry

game.make_entity = (id, x, y) ->
  import Player, Block from require "src/entities"

  switch id
    when "player"
      player = Player x, y, 16, 16
      ----------------------------------
      -- do things with player here ...
      ----------------------------------
      game.player = player
      table.insert game.game_objects, player

      world\add player, player.x, player.y, player.w, player.h

      return player

    when "block"
      block = Block x, y, 16, 16
      table.insert game.game_objects, block

      world\add block, block.x, block.y, block.w, block.h

      return block
game
