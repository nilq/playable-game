local path = "framework/"
state = require(path .. "state")
bump = require(path .. "bump")
lg = love.graphics
lg.setDefaultFilter("nearest", "nearest")
love.run = function()
  local dt = 0
  local update_timer = 0
  local target_delta = 1 / 60
  if love.math then
    love.math.setRandomSeed(os.time())
  end
  if love.load then
    load.load()
  end
  if love.timer then
    love.timer.step()
  end
  while true do
    update_timer = update_timer + dt
    if love.event then
      love.event.pump()
      for name, a, b, c, d, e, f in love.event.poll() do
        if name == "quit" then
          if not (love.quit or not love.quit()) then
            return a
          end
        end
        love.handlers[name](a, b, c, d, e, f)
      end
    end
    if love.timer then
      love.timer.step()
      dt = love.timer.getDelta()
    end
    if update_timer > target_delta then
      state:update(dt)
    end
    if lg and lg.isActive() then
      lg.clear(lg.getBackgroundColor())
      lg.setColor(255, 255, 255)
      lg.origin()
      state:draw()
      lg.present()
    end
    if love.timer then
      love.timer.sleep(0.001)
    end
  end
end
