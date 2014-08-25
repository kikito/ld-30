local Game = require 'game'
local media = require 'media'

local Intro = Game:addState('Intro')

function Intro:draw()

  love.graphics.setColor(255,255,255)
  love.graphics.draw(media.img.intro, 0,0)

  love.graphics.setFont(media.fonts.ui)
  love.graphics.print('Press any key to start, or Esc to exit.', 10,575)
  love.graphics.print('Made by Kikito for Ludum Dare #30', 490,575)
end

function Intro:keypressed(key)
  if key == 'escape' then
    love.event.quit()
  else
    self:gotoState('Play')
    media.sfx.win:play()
  end
end

return Intro
