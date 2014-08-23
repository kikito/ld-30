local class = require 'lib.middleclass'
local media = require 'media'


local World = class('World')

local TILE_WIDTH, TILE_HEIGHT = 32, 32

local charQuadTranslation = {
  up = {
    ['@'] = 'human',
    ['.'] = 'ground',
    ['#'] = 'wall',
    ['O'] = 'ball',
    ['1'] = 'button',
    ['X'] = 'goal'
  },
  down = {
    ['@'] = 'demon',
    ['.'] = 'hell_ground',
    ['#'] = 'hell_wall',
    ['O'] = 'hell_ball',
    ['1'] = 'hell_button',
    ['X'] = 'hell_goal'
  }
}


local function getQuadFromChar(char, region)
  local quadName = charQuadTranslation[region][char]
  return media.quads[quadName]
end

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

local function getCellLT(world_l, world_t, x, y)
  return world_l + (x - 1) * TILE_WIDTH,
         world_t + (y - 1) * TILE_HEIGHT
end

function World:initialize(world_data, region)
  self.region = region
  self.width = world_data.width
  self.height = world_data.height

  self.cells = {}
  self.balls = {}

  for y=1, self.height do
    self.cells[y] = {}
    for x=1, self.width do
      local char = world_data.cells[y][x]
      if     char == '@' then
        if self.player then error('Two players defined on the same world') end
        self.player = {x=x,y=y}
        char = '.'
      elseif char == 'O' then
        self.balls[#self.balls + 1] = {x=x,y=y}
        char = '.'
      end
      self.cells[y][x] = char
    end
  end
end

function World:draw(l,t)
  love.graphics.setColor(255,255,255)
  for x = 1, self.width do
    for y = 1, self.height do
      local quad = getQuadFromChar(self.cells[y][x], self.region)
      love.graphics.draw(media.img.atlas, quad, getCellLT(l,t,x,y))
    end
  end

  local ball_quad = getQuadFromChar('O', self.region)

  for i=1,#self.balls do
    local ball = self.balls[i]
    love.graphics.draw(media.img.atlas, ball_quad, getCellLT(l,t, ball.x, ball.y))
  end

  local player_quad = getQuadFromChar('@', self.region)
  love.graphics.draw(media.img.atlas, player_quad, getCellLT(l,t,self.player.x, self.player.y))
end


local Level = class('Level')

function Level:initialize(map)
  self.up = World:new(map.up, 'up')
  self.down = World:new(map.down, 'down')
end

function Level:draw()
  self.up:draw(getWorldRect(self.up, 'up'))
  self.down:draw(getWorldRect(self.down, 'down'))
end

return Level
