return {
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
      [1] = function(level, state)
        level.earth:toggleWall(5,3)
      end
    }
  },
  { earth = [[
      ...#.....
      ...#.....
      .&.#.O..X
      .........
    ]],
    hell = [[
      .........
      .........
      .&...O#.X
      ......#..
    ]]
  },
  { earth = [[
      ......###
      .@.......
      ..0..#.X.
      .....#...
    ]],
    hell = [[
      ...###..#
      .@.#....#
      ..0....X#
      #########
    ]]
  },
  { earth = [[
      ######........
      #...X#....O...
      #....#........
      #..&.#.2......
      #....#........
      #....#........
      #....#...O..X.
      ######........
      ..............
    ]],
    hell = [[
      ..............
      ..............
      ..1O..........
      ...&..........
      ..X...........
      ##############
      ..............
      .........X..O.
      ..............
    ]],
    buttons = {
      [1] = function(level, state)
        level.earth:toggleWall(6,3)
      end,
      [2] = function(level, state)
        level.hell:toggleWall(10,6)
      end
    }
  },
  { earth = [[
      ....X.###
      ##.O.####
      #@.O.X...
      #.0..#.X.
      ####.....
    ]],
    hell = [[
      #########
      ...###..#
      .@.#....#
      ..0....X#
      #..######
    ]]
  },
  { earth = [[
      .........#....
      .&.1.....#0.O.
      .........#....
      ...........###
      ..............
      ..............
      .....#########
      .....#.2.#.X.#
      .....#...#...#
    ]],
    hell = [[
      ..............
      .&........0O..
      ..............
      ..............
      ###...........
      ..#...........
      3.#...........
      ..#........X..
      X.#...........
    ]],
    buttons = {
      [1] = function(level, state)
        level.earth:toggleWall(6,8)
      end,
      [2] = function(level, state)
        level.hell:toggleWall(3,7)
      end,
      [3] = function(level, state)
        level.earth:toggleWall(12,7)
      end
    }
  },
  { earth = [[
      @.#....###
      ..#.2...3.
      ##......0.
      ....###...
      ...#...#..
      ...#.5.#..
    ]],
    hell = [[
      ..........
      ..........
      ........0.
      ##########
      .4.#...#.1
      ...#.X.#.@
    ]],
    buttons = {
      [1] = function(level, state)
        level.earth:toggleWall(3,2)
      end,
      [2] = function(level, state)
        level.hell:toggleWall(11,4)
      end,
      [3] = function(level, state)
        level.hell:toggleWall(2,4)
      end,
      [4] = function(level, state)
        level.earth:toggleWall(7,4)
      end,
      [5] = function(level, state)
        level.hell:toggleWall(4,6)
      end
    }
  }
}
