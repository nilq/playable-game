----------------------------------
-- requirenments
----------------------------------
path = "framework/dep/"

export state = require path .. "state"
export bump  = require path .. "bump"

export world = bump.newWorld!

export lg = love.graphics

lg.setDefaultFilter "nearest", "nearest"

love.run = ->
  dt = 0

  update_timer = 0
  target_delta = 1 / 60

  love.math.setRandomSeed os.time! if love.math
  load.load!                       if love.load
  love.timer.step!                 if love.timer

  state\switch "src/game"

  while true
    update_timer += dt

    if love.event
      love.event.pump!

      for name, a, b, c, d, e, f in love.event.poll!
        if name == "quit"
          if not love.quit or not love.quit!
            return a

        love.handlers[name] a, b, c, d, e, f

    if love.timer
      love.timer.step!
      dt = love.timer.getDelta!

    ----------------------------------
    -- updates here please
    ----------------------------------
    if update_timer > target_delta
      state\update dt

    if lg and lg.isActive!
      lg.clear    lg.getBackgroundColor!
      lg.setColor 255, 255, 255

      lg.origin!
      state\draw!

      lg.present!

    love.timer.sleep 0.001 if love.timer
