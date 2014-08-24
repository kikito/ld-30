local class = require 'lib.middleclass'

local Ball = class('Ball')

function Ball:initialize(world, x, y)
  self.world = world
  self.x, self.y = x,y
end

function Ball:move(direction)
  self.x, self.y = self.world:getNextCoordinate(self.x, self.y, direction)
end

function Ball:canMove(direction)
  local world = self.world
  local next_x, next_y = world:getNextCoordinate(self.x, self.y, direction)
  return world:isEmpty(next_x, next_y)
end

return Ball
