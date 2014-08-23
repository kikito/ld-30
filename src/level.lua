local class = require 'lib.middleclass'

local Level = class('Level')

local TILE_WIDTH, TILE_HEIGHT = 32, 32

local function getRegionRect(region)
  local w,h = love.graphics.getDimensions()

  if region == 'up' then
    return 0,0,w,h/2
  else
    return 0,h/2,w,h/2
  end
end

local function getWorldRect(world, region)

  local rl,rt,rw,rh = getRegionRect(region)


  local ww, wh = world.width, world.height -- in tiles

  ww, wh = ww * TILE_WIDTH, wh * TILE_HEIGHT

  return rl + rw/2 - ww/2,
         rt + rh/2 - wh/2,
         ww,
         wh
end

local function drawWorld(world, region)
  local l,t,w,h = getWorldRect(world, region)

  for x = 1, world.width do
    for y = 1, world.height do
      love.graphics.rectangle('line',
                              l + (x - 1) * TILE_WIDTH,
                              t + (y - 1) * TILE_HEIGHT,
                              TILE_WIDTH,
                              TILE_HEIGHT)
    end
  end
end

function Level:initialize(map)
  self.up = map.up
  self.down = map.down
end

function Level:draw()
  drawWorld(self.up, 'up')
  drawWorld(self.down, 'down')
end

return Level
