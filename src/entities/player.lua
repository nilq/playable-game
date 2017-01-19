do
  local _class_0
  local _base_0 = {
    update = function(self, dt)
      do
        local _with_0 = love.keyboard
        if _with_0.isDown(self.keys["right"]) then
          self.dx = self.dx + (self.acc * dt)
        end
        if _with_0.isDown(self.keys["left"]) then
          self.dx = self.dx - (self.acc * dt)
        end
      end
      self.dx = self.dx - ((self.dx / self.frc_x) * dt)
      self.dy = self.dy - ((self.dy / self.frc_y) * dt)
      self.x, self.y, self.cols = world:move(self, self.x + self.dx, self.y + self.dy)
      self.grounded = false
      self.wall = 0
      local _list_0 = self.cols
      for _index_0 = 1, #_list_0 do
        local c = _list_0[_index_0]
        do
          local _with_0 = c.normal
          if not (_with_0.y == 0) then
            if _with_0.y == -1 then
              self.grounded = true
            end
            self.dy = 0
          end
          if not (_with_0.x == 0) then
            self.dx = 0
            if not (self.grounded) then
              self.wall = _with_0.x
            end
          end
        end
      end
      if game.noob then
        self.dx = self.dx - (self.wall * dt * 0.5)
        self.dy = self.dy + (self.gravity * 0.75 * dt)
      else
        self.dy = self.dy + (self.gravity * dt)
      end
      do
        local _with_0 = game
        local ww, wy, wh
        ww, wy, ww, wh = _with_0.camera:getWorld()
        _with_0.camera.x = math.lerp(_with_0.camera.x, self.x + self.dx, dt * 2)
        _with_0.camera.y = math.lerp(_with_0.camera.y, self.y + self.dy, dt * 2)
        _with_0.camera.angle = math.lerp(_with_0.camera.angle, -self.dx * 0.015, dt * 5)
        return _with_0
      end
    end,
    press = function(self, key)
      if key == self.keys["jump"] then
        if self.grounded then
          self.dy = -self.jump_force
        else
          if not (self.wall == 0) then
            self.dx = self.wall_jump.x * self.wall
          end
          if not (self.wall == 0) then
            self.dy = -self.wall_jump.y
          end
        end
      end
    end,
    draw = function(self)
      do
        local _with_0 = lg
        _with_0.setColor(255, 0, 0)
        _with_0.rectangle("fill", self.x, self.y, self.w, self.h)
        return _with_0
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y, w, h)
      self.x, self.y, self.w, self.h = x, y, w, h
      self.acc = 10
      self.dx = 0
      self.dy = 0
      self.frc_x = 0.35
      self.frc_y = 2
      self.gravity = 30
      self.grounded = false
      self.jump_force = 8
      self.keys = {
        ["right"] = "right",
        ["left"] = "left",
        ["jump"] = "space"
      }
      self.wall = 0
      self.wall_jump = {
        x = 6,
        y = 5
      }
    end,
    __base = _base_0,
    __name = nil
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  return _class_0
end
