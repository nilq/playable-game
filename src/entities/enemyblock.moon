class
  new: (@x, @y, @w, @h) =>

  draw: =>
    with lg
      .setColor 255, 100, 100
      .draw game.sprites.block[0], @x, @y

  apply: (thing) =>
    game.load!
    nil, nil
