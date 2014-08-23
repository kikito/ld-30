local Game = require 'game'

local Play = Game:addState('Play')

function Play:draw()
  love.graphics.print('Play', 100,100)
end

function Play:keypressed(key)
  if key == 'escape' then
    self:gotoState('Intro')
  end
end

return Play
