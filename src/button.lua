local class = require 'lib.middleclass'
local media = require 'media'

local Button = class('Button')

function Button:initialize(world, x,y,callback)
  self.world = world
  self.x, self.y = x,y
  self.callback = callback
  self.state = 'released'
end

function Button:press()
  self:setState('pressed')
end

function Button:release()
  self:setState('released')
end

function Button:setState(newState)
  if newState ~= self.state then
    self.state = newState
    self.callback(self.world.level, newState)
    media.sfx.button:play()
  end
end

return Button
