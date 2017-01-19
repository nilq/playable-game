class
  new: (@x, @y, @w, @h) =>

  draw: =>
    with lg
      .setColor 100, 255, 255
      .draw game.sprites.block[0], @x, @y

  apply: (thing) =>
    0, -12
