do
  local _class_0
  local _base_0 = {
    draw = function(self)
      do
        local _with_0 = lg
        _with_0.setColor(0, 255, 0)
        _with_0.rectangle("fill", self.x, self.y, self.w, self.h)
        return _with_0
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y, w, h)
      self.x, self.y, self.w, self.h = x, y, w, h
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
