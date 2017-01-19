class
  new: (@x, @y, @w, @h) =>
    @acc = 10

    @dx = 0
    @dy = 0

    @frc_x = 0.35
    @frc_y = 2

    @gravity  = 25
    @grounded = false

    @keys = {
      "right": "right"
      "left":  "left"
    }

  update: (dt) =>
    with love.keyboard
      if .isDown @keys["right"]
        @dx += @acc * dt
      if .isDown @keys["left"]
        @dx -= @acc * dt

    @dx -= (@dx / @frc_x) * dt
    @dy -= (@dy / @frc_y) * dt

    @x, @y, @cols = world\move @, @x + @dx, @y + @dy

    @grounded = false
    for c in *@cols
      with c.normal
        unless .y == 0
          if .y == -1
            @grounded = true
        unless .x == 0
          @dx = 0

    @dy += @gravity * dt unless @grounded

    with game
      ww, wy, ww, wh = .camera\getWorld!

      .camera.x = math.lerp .camera.x, @x + @dx, dt * 2
      .camera.y = math.lerp .camera.y, @y + @dy, dt * 2

      .camera.angle = math.lerp .camera.angle, @dx * 2, dt

  draw: =>
    with lg
      .setColor 255, 0, 0
      .rectangle "fill", @x, @y, @w, @h
