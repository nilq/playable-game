class
  new: (@x, @y, @w, @h) =>

  draw: =>
    with lg
      .setColor 0, 255, 255
      .rectangle "fill", @x, @y, @w, @h

  apply: (thing) =>
    0, -10
