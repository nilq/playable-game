class
  new: (@x, @y, @w, @h) =>

  draw: =>
    with lg
      .setColor 255, 0, 0
      .rectangle "fill", @x, @y, @w, @h

  apply: (thing) =>
    game.load!
    nil, nil
