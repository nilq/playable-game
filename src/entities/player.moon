class
  new: (@x, @y, @w, @h) =>
    @acc = 10

    @dx = 0
    @dy = 0

    @frc_x = 0.35
    @frc_y = 2

    @gravity  = 30
    @grounded = false

    @jump_force = 5

    @keys = {
      "right": "right"
      "left":  "left"
      "jump":  "space"
    }

    @wall = 0
    @wall_jump = {
      x: 6
      y: 5
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
    @wall     = 0

    for c in *@cols
      with c.normal
        unless .y == 0
          if .y == -1
            @grounded = true
          @dy = 0
        unless .x == 0
          @dx = 0
          @wall = .x unless @grounded

    ----------------------------------
    -- noob
    ----------------------------------
    if game.noob
      @dx -= @wall * dt * 0.5
      @dy += @gravity * 0.75 * dt
    else
      @dy += @gravity * dt

    with game
      ww, wy, ww, wh = .camera\getWorld!

      .camera.x = math.lerp .camera.x, @x + @dx, dt * 2
      .camera.y = math.lerp .camera.y, @y + @dy, dt * 2

      .camera.angle = math.lerp .camera.angle, -@dx * 0.015, dt * 5

  press: (key) =>
    if key == @keys["jump"]
      if @grounded
        @dy = -@jump_force
      else
        @dx = @wall_jump.x * @wall  unless @wall == 0
        @dy = -@wall_jump.y         unless @wall == 0

  draw: =>
    with lg
      .setColor 255, 0, 0
      .rectangle "fill", @x, @y, @w, @h
