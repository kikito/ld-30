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
    buttons = {
      function(level, state)
        level.earth:toggleWall(5,3)
      end
    }
  }
}
