local class = require 'lib.middleclass'

local Pusher = class('Pusher')

function Pusher:initialize(world, x, y)
  self.world = world
  self.x, self.y = x,y
end

function Pusher:move(next_x, next_y)
  self.x, self.y = next_x, next_y
  return true
end

function Pusher:attemptMove(direction)
  local world = self.world

  local next_x, next_y = world:getNextCoordinate(self.x, self.y, direction)

  local ball = world:getBall(next_x, next_y)

  if ball then
    if ball:attemptMove(direction) then
      return self:move(next_x, next_y)
    end
  elseif world:isTraversable(next_x, next_y) then
    return self:move(next_x, next_y)
  end
end


return Pusher
