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
  },
]=]
  { earth = [[
      ......###
      .@.O.X...
      ..0..#.X.
      .....#...
    ]],
    hell = [[
      ...##....
      .@.##....
      ..0##..X.
      .........
    ]],
    buttons = {
      function(level, state)
        level.earth:toggleWall(5,3)
      end
    }
  }
}
