local Game = require 'game'
local media = require 'media'

local Intro = Game:addState('Intro')

function Intro:draw()
  love.graphics.setFont(media.fonts.big)
  love.graphics.print('Intro', 100,100)
end

function Intro:keypressed(key)
  if key == ' ' or key == 'enter' then
    self:gotoState('Play')
  elseif key == 'escape' then
    love.event.quit()
  end
end

return Intro
