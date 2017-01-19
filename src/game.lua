gamera = require("framework/dep/gamera")
lg.setBackgroundColor(255, 255, 255)
game = {
  game_objects = { },
  map_stuff = {
    ["player"] = {
      r = 255,
      g = 0,
      b = 0
    },
    ["block"] = {
      r = 0,
      g = 0,
      b = 0
    },
    ["jump"] = {
      r = 0,
      g = 0,
      b = 255
    },
    ["enemy"] = {
      r = 0,
      g = 255,
      b = 255
    }
  },
  grid_size = 16,
  level = 1,
  levels = {
    [1] = "whatsyourask"
  }
}
game.initialize_assets = function()
  do
    game.sprites = { }
  end
  do
    local _with_0 = game.sprites
    _with_0.player = {
      [0] = lg.newImage("assets/player/stand.png")
    }
    _with_0.block = {
      [0] = lg.newImage("assets/block/redish.png")
    }
  end
  do
    game.grid_size = game.sprites.block[0]:getWidth()
    return game
  end
end
game.initialize_assets()
game.load = function()
  do
    game.game_objects = { }
    game.camera = gamera.new(0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    game.camera:setWindow(0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    game.camera:setScale(3)
    game.load_level("assets/levels/" .. tostring(game.levels[game.level]) .. ".png")
    return game
  end
end
game.update = function(dt)
  do
    local _list_0 = game.game_objects
    for _index_0 = 1, #_list_0 do
      local _continue_0 = false
      repeat
        local g = _list_0[_index_0]
        if g == nil then
          _continue_0 = true
          break
        end
        if g.update then
          g:update(dt)
        end
        _continue_0 = true
      until true
      if not _continue_0 then
        break
      end
    end
    return game
  end
end
game.draw = function()
  do
    game.camera:draw(function()
      return game.draw_world()
    end)
    return game
  end
end
game.draw_world = function()
  do
    local _list_0 = game.game_objects
    for _index_0 = 1, #_list_0 do
      local _continue_0 = false
      repeat
        local g = _list_0[_index_0]
        if g == nil then
          _continue_0 = true
          break
        end
        if g.draw then
          g:draw()
        end
        _continue_0 = true
      until true
      if not _continue_0 then
        break
      end
    end
    return game
  end
end
game.load_level = function(path)
  do
    local image = love.image.newImageData(path)
    for x = 1, image:getWidth() do
      local row = { }
      for y = 1, image:getHeight() do
        local rx, ry = x - 1, y - 1
        local r, g, b = image:getPixel(rx, ry)
        for k, v in pairs(game.map_stuff) do
          if r == v.r and g == v.g and b == v.b then
            game.make_entity(k, game.grid_size * rx, game.grid_size * ry)
          end
        end
      end
    end
    return game
  end
end
game.make_entity = function(id, x, y)
  local Player, Block, Jump, Enemy
  do
    local _obj_0 = require("src/entities")
    Player, Block, Jump, Enemy = _obj_0.Player, _obj_0.Block, _obj_0.Jump, _obj_0.Enemy
  end
  local _exp_0 = id
  if "player" == _exp_0 then
    local player = Player(x, y, game.sprites.player[0]:getWidth(), game.sprites.player[0]:getHeight())
    game.player = player
    table.insert(game.game_objects, player)
    world:add(player, player.x, player.y, player.w, player.h)
    return player
  elseif "block" == _exp_0 then
    local block = Block(x, y, game.sprites.block[0]:getWidth(), game.sprites.block[0]:getHeight())
    table.insert(game.game_objects, block)
    world:add(block, block.x, block.y, block.w, block.h)
    return block
  elseif "jump" == _exp_0 then
    local jump = Jump(x, y, game.sprites.block[0]:getWidth(), game.sprites.block[0]:getHeight())
    table.insert(game.game_objects, jump)
    world:add(jump, jump.x, jump.y, jump.w, jump.h)
    return jump
  elseif "enemy" == _exp_0 then
    local enemy = Enemy(x, y, game.sprites.block[0]:getWidth(), game.sprites.block[0]:getHeight())
    table.insert(game.game_objects, enemy)
    world:add(enemy, enemy.x, enemy.y, enemy.w, enemy.h)
    return enemy
  end
end
love.keypressed = function(key, isrepeat)
  do
    local _list_0 = game.game_objects
    for _index_0 = 1, #_list_0 do
      local _continue_0 = false
      repeat
        local g = _list_0[_index_0]
        if g == nil then
          _continue_0 = true
          break
        end
        if g.press then
          g:press(key)
        end
        _continue_0 = true
      until true
      if not _continue_0 then
        break
      end
    end
    return game
  end
end
return game
