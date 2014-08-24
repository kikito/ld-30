local class = require 'lib.middleclass'

local Ball = class('Ball')

function Ball:initialize(world, x, y)
  self.world = world
  self.x, self.y = x,y
end

function Ball:move(next_x, next_y)
  self.x, self.y = next_x, next_y
  return true
end

function Ball:attemptMove(direction)
  local world = self.world
  local next_x, next_y = world:getNextCoordinate(self.x, self.y, direction)

  if world:isTraversable(next_x, next_y) then
    local another_ball = world:getBall(next_x, next_y)
    if another_ball then return false end
    return self:move(next_x, next_y)
  end
end

return Ball
