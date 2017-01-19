class
  new: (@x, @y, @w, @h) =>

  draw: =>
    with lg
      .setColor 255, 255, 255
      .draw game.sprites.block[0], @x, @y
