local class = require 'lib.middleclass'
local Pusher = require 'pusher'

local MetaPusher = class('MetaPusher', Pusher)

function MetaPusher:initialize(world, x, y)

  Pusher.initialize(self, world, x, y)

  local twin_world = world:getTweenWorld()

  if twin_world then
    local twin = twin_world:getPusher(x,y)
    if not twin then error("missing metapusher twin") end
    self.twin = twin
    twin.twin = self
  end
end

function MetaPusher:canMove(direction)
  return Pusher.canMove(self, direction)
     and Pusher.canMove(self.twin, direction)
end

function MetaPusher:move(direction)
  Pusher.move(self, direction)
  Pusher.move(self.twin, direction)
end

return MetaPusher

