local Game = require 'game'
local media = require 'media'

local Intro = Game:addState('Intro')

function Intro:draw()
  love.graphics.setFont(media.fonts.big)
  love.graphics.setColor(255,255,255)
  love.graphics.print('Earth, Hell and Space', 100,100)

  love.graphics.setFont(media.fonts.ui)
  love.graphics.print('Press any key to start. Esc exits', 100,300)

end

function Intro:keypressed(key)
  if key == 'escape' then
    love.event.quit()
  else
    self:gotoState('Play')
  end
end

return Intro
