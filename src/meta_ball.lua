local class = require 'lib.middleclass'
local Ball = require 'ball'

local MetaBall = class('MetaBall', Ball)

function MetaBall:initialize(world, x, y)
  Ball.initialize(self, world, x, y)

  local twin_world = world:getTweenWorld()

  if twin_world then
    local twin = twin_world:getBall(x,y)
    if not twin then error("missing metaball twin") end
    self.twin = twin
    twin.twin = self
  end
end

function MetaBall:canMove(direction)
  return Ball.canMove(self, direction)
     and Ball.canMove(self.twin, direction)
end

function MetaBall:move(direction)
  Ball.move(self, direction)
  Ball.move(self.twin, direction)
end


return MetaBall

