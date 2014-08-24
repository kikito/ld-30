local class = require 'lib.middleclass'
local media = require 'media'


local TILE_WIDTH, TILE_HEIGHT = 32, 32

local charQuadTranslation = {
  earth = {
    ['@'] = 'human',
    ['.'] = 'ground',
    ['#'] = 'wall',
    ['O'] = 'ball',
    ['1'] = 'button',
    ['X'] = 'goal'
  },
  hell = {
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

  if region == 'earth' then
    return 0,0,w,h/2
  else
    return 0,h/2,w,h/2
  end
end

local function getWorldLT(world, cx, cy)

  local w, h = world.width * TILE_WIDTH, world.height * TILE_HEIGHT

  return cx - w/2, cy - h/2
end

local function getCellLT(world_l, world_t, x, y)
  return world_l + (x - 1) * TILE_WIDTH,
         world_t + (y - 1) * TILE_HEIGHT
end

local function getNextCoordinate(x,y,direction)
  if direction == 'up'    then return x,y-1 end
  if direction == 'down'  then return x,y+1 end
  if direction == 'left'  then return x-1,y end
  if direction == 'right' then return x+1,y end
end

------------

local World = class('World')

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

function World:draw()

  love.graphics.setColor(255,255,255)

  local rl,rt,rw,rh = getRegionRect(self.region)
  if self.active then
    love.graphics.rectangle('fill', rl,rt,rw,rh)
  end

  local l,t = getWorldLT(self, rl + rw/2, rt + rh/2)

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

function World:attemptMove(direction)
  if not self.active then return end

  local player = self.player

  local next_player_x, next_player_y = getNextCoordinate(player.x, player.y, direction)

  local ball = self:getBall(next_player_x, next_player_y)

  if ball then
    local next_ball_x, next_ball_y = getNextCoordinate(ball.x, ball.y, direction)
    if self:isTraversable(next_ball_x, next_ball_y) then
      local another_ball = self:getBall(next_ball_x, next_ball_y)
      if another_ball then return false end
      ball.x, ball.y = next_ball_x, next_ball_y
      player.x, player.y = next_player_x, next_player_y

      return true
    end
  elseif self:isTraversable(next_player_x, next_player_y) then
    player.x, player.y = next_player_x, next_player_y
  end
end

function World:isWon()
  local ball, char
  for i=1, #self.balls do
    ball = self.balls[i]
    char = self.cells[ball.y][ball.x]
    if char ~= 'X' then return false end
  end
  return true
end

function World:isOut(x,y)
  return x < 1 or x > self.width or y < 1 or y > self.height
end

function World:getBall(x,y)
  if self:isOut(x,y) then return nil end
  local ball
  for i=1, #self.balls do
    ball = self.balls[i]
    if ball.x == x and ball.y == y then return ball end
  end
end

function World:isTraversable(x,y)
  if self:isOut(x,y) then return false end
  local char = self.cells[y][x]
  return char ~= '#'
end

local Level = class('Level')

function Level:initialize(map)
  self.earth = World:new(map.earth, 'earth')
  self.hell = World:new(map.hell, 'hell')
  self.earth.active = true
end

function Level:draw()
  self.earth:draw('earth')
  self.hell:draw('hell')
end

function Level:attemptMove(direction)
  self.earth:attemptMove(direction)
  self.hell:attemptMove(direction)
end

function Level:isWon()
  return self.earth:isWon() and self.hell:isWon()
end

function Level:switchActiveWorld()
  self.earth.active = not self.earth.active
  self.hell.active = not self.hell.active
end

return Level
