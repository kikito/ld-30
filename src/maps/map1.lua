local up = [[
.@..#...
..O.#.X.
....#...
]]

local down = [[
........
..@.1...
........
]]

return {
  up = up,
  down = down,
  buttons = function(button, state)
    if button == "1" and state == "pressed" then
      print('FIXME: remove block from up')
    end
  end
}
