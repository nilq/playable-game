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
      local _list_0 = self.cols
      for _index_0 = 1, #_list_0 do
        local c = _list_0[_index_0]
        do
          local _with_0 = c.normal
          if not (_with_0.y == 0) then
            if _with_0.y == -1 then
              self.grounded = true
            end
          end
          if not (_with_0.x == 0) then
            self.dx = 0
          end
        end
      end
      if not (self.grounded) then
        self.dy = self.dy + (self.gravity * dt)
      end
      do
        local _with_0 = game
        local ww, wy, wh
        ww, wy, ww, wh = _with_0.camera:getWorld()
        _with_0.camera.x = math.lerp(_with_0.camera.x, self.x + self.dx, dt * 2)
        _with_0.camera.y = math.lerp(_with_0.camera.y, self.y + self.dy, dt * 2)
        _with_0.camera.angle = math.lerp(_with_0.camera.angle, self.dx * 2, dt)
        return _with_0
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
      self.gravity = 25
      self.grounded = false
      self.keys = {
        ["right"] = "right",
        ["left"] = "left"
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
