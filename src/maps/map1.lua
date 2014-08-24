local earth = [[
....#...
.@..#...
..O...X.
....#...
]]

local hell = [[
........
.@##.##.
..##O##.
.......X
]]

return {
  earth = earth,
  hell = hell,
  buttons = function(button, state)
    if button == "1" and state == "pressed" then
      print('FIXME: remove block from earth')
    end
  end
}
