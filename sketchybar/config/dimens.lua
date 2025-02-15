local padding <const> = {
  background = 8,
  icon = 5,
  label = 10,
  bar = 10,
  left = 5,
  right = 5,
  item = 20,
  popup = 8,
}

local graphics <const> = {
  bar = {
    height = 32,
  },
  background = {
    height = 19,
    corner_radius = 0,
  },
  slider = {
    height = 20,
  },
  popup = {
    width = 200,
    large_width = 300,
  },
  blur_radius = 0,
}

local text <const> = {
  icon = 16.0,
  label = 14.0,
}

return {
  padding = padding,
  graphics = graphics,
  text = text,
}
