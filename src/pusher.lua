local class = require 'lib.middleclass'
local media = require 'media'

local Pusher = class('Pusher')

function Pusher:initialize(world, x, y)
  self.world = world
  self.x, self.y = x,y
end

function Pusher:move(direction)
  self.x, self.y = self.world:getNextCoordinate(self.x, self.y, direction)
  local ball = self.world:getBall(self.x, self.y)
  media.sfx.step:play()
  if ball then ball:move(direction) end
end

function Pusher:canMove(direction)
  local world = self.world
  local next_x, next_y = world:getNextCoordinate(self.x, self.y, direction)

  local ball = world:getBall(next_x, next_y)
  if ball then return ball:canMove(direction) end
  return world:isTraversable(next_x, next_y)
end

function Pusher:attemptMove(direction)
  if self:canMove(direction) then
    self:move(direction)
    return true
  end
end


return Pusher
