return {
--[=[
  { earth = [[
....#...
.@..#...
..O...X.
....#...
]],
    hell = [[
........
.@##.##.
..##O##.
.......X
]],
  },
]=]
  { earth = [[
....#...
.@..#...
..O.#.X.
....#...
]],
    hell = [[
......
.@.1..
......
]],
    buttons = function(button, state)
      if button == "1" then
        print('FIXME: button 1 ' .. state)
      end
    end
  }
}
