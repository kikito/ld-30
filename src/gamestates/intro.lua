local Game = require 'game'

local Intro = Game:addState('Intro')

function Intro:draw()
  love.graphics.print('Intro', 100,100)
end

function Intro:keypressed(key)
  if key == ' ' then
    self:gotoState('Play')
  elseif key == 'escape' then
    love.event.quit()
  end
end

return Intro
