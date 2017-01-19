class
  new: (@x, @y, @w, @h) =>

  draw: =>
    with lg
      .setColor 0, 255, 0
      .rectangle "fill", @x, @y, @w, @h
