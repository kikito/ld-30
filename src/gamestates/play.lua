local Game = require 'game'
local Level = require 'level'

local Play = Game:addState('Play')

function Play:enteredState()
  self.level = Level:new(self.media.maps.map1)
end

function Play:draw()
  self.level:draw()
end

function Play:keypressed(key)
  if key == 'escape' then
    self:gotoState('Intro')
  end
end

function Play:exitedState()
  self.level = nil
end

return Play
