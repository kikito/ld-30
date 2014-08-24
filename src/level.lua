local class    = require 'lib.middleclass'
local media    = require 'media'
local Pusher   = require 'pusher'
local Ball     = require 'ball'
local MetaBall = require 'meta_ball'
local Button   = require 'button'


local TILE_WIDTH, TILE_HEIGHT = 32, 32

local charQuadTranslation = {
  earth = {
    ['@'] = 'human',
    ['.'] = 'ground',
    ['#'] = 'wall',
    ['O'] = 'ball',
    ['_'] = 'button',
    ['X'] = 'goal',
    ['0'] = 'meta_ball'
  },
  hell = {
    ['@'] = 'demon',
    ['.'] = 'hell_ground',
    ['#'] = 'hell_wall',
    ['O'] = 'hell_ball',
    ['_'] = 'hell_button',
    ['X'] = 'hell_goal',
    ['0'] = 'meta_ball'
  }
}


local function getQuadFromChar(char, region)
  local quad_name = charQuadTranslation[region][char]
  return media.quads[quad_name]
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

end

------------

local World = class('World')

function World:initialize(level, world_data, region, button_callbacks)
  self.level = level
  self.region = region
  self.width = world_data.width
  self.height = world_data.height

  self.cells = {}
  self.balls = {}
  self.buttons = {}

  for y=1, self.height do
    self.cells[y] = {}
    for x=1, self.width do
      local char = world_data.cells[y][x]
      if     char == '@' then
        if self.pusher then error('Two pushers defined on the same world') end
        self.pusher = Pusher:new(self, x, y)
        char = '.'
      elseif char == 'O' then
        self.balls[#self.balls + 1] = Ball:new(self, x, y)
        char = '.'
      elseif char == '0' then
        self.balls[#self.balls + 1] = MetaBall:new(self, x, y)
        char = '.'
      elseif tonumber(char) then
        local callback = assert(button_callbacks[n], 'missing button callback: '.. char)
        self.buttons[#self.buttons + 1] = Button:new(self, x, y, callback)
        char = '_'
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

  local ball, char, ball_quad
  for i=1,#self.balls do
    ball = self.balls[i]
    char = ball.class.name == 'Ball' and 'O' or '0'
    ball_quad = getQuadFromChar(char, self.region)
    love.graphics.draw(media.img.atlas, ball_quad, getCellLT(l,t, ball.x, ball.y))
  end

  local pusher_quad = getQuadFromChar('@', self.region)
  love.graphics.draw(media.img.atlas, pusher_quad, getCellLT(l,t,self.pusher.x, self.pusher.y))
end

function World:getNextCoordinate(x,y,direction)
  if direction == 'up'    then return x,y-1 end
  if direction == 'down'  then return x,y+1 end
  if direction == 'left'  then return x-1,y end
  return x+1,y
end

function World:attemptMove(direction)
  if not self.active then return end
  if self.pusher:attemptMove(direction) then
    self:checkButtons()
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

function World:getPusher(x,y)
  local pusher = self.pusher
  if pusher.x == x and pusher.y == y then return pusher end
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

function World:isEmpty(x,y)
  return self:isTraversable(x, y)
    and not self:getPusher(x, y)
    and not self:getBall(x, y)
end

function World:checkButtons()
  local button
  for i=1, #self.buttons do
    button = self.buttons[i]
    if self:getPusher(button.x, button.y)
    or self:getBall(button.x, button.y)
    then
      button:press()
    else
      button:release()
    end
  end
end

function World:toggleWall(x,y)
  local char = self.cells[y][x]
  if char == '.' then
    self.cells[y][x] = '#'
  elseif char == '#' then
    self.cells[y][x] = '.'
  else
    error('can not toggle wall ' .. x ..','.. y .. ': invalid char - ' .. char)
  end
end

local Level = class('Level')

function Level:initialize(map)
  self.earth = World:new(self, map.earth, 'earth', map.buttons)
  self.hell = World:new(self, map.hell, 'hell', map.buttons)
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
