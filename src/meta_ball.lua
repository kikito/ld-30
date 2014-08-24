local class = require 'lib.middleclass'
local Ball = require 'ball'

local MetaBall = class('MetaBall', Ball)

function MetaBall:initialze(world, x, y)
  Ball.initialize(self, world, x, y)
  -- FIXME: pair with sister metaball
end


function MetaBall:canMove(direction)
  return false
end

return MetaBall

