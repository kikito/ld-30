local class = require 'lib.middleclass'
local media = require 'media'

local Ball = class('Ball')

function Ball:initialize(world, x, y)
  self.world = world
  self.x, self.y = x,y
end

function Ball:move(direction)
  local world = self.world
  self.x, self.y = world:getNextCoordinate(self.x, self.y, direction)
  media.sfx.roll:play()

  if world:isGoal(self.x, self.y) then
    media.sfx.goal:play()
  end

end

function Ball:canMove(direction)
  local world = self.world
  local next_x, next_y = world:getNextCoordinate(self.x, self.y, direction)
  return world:isEmpty(next_x, next_y)
end

return Ball
