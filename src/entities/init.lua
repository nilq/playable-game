local path = "src/entities/"
local Player = require(path .. "player")
local Block = require(path .. "block")
local Jump = require(path .. "jumpblock")
local Enemy = require(path .. "enemyblock")
return {
  Player = Player,
  Block = Block,
  Jump = Jump,
  Enemy = Enemy
}
