local class = require 'lib.middleclass'

local Game = class('Game')

function Game:initialize(media)
  self.media = media
end

function Game:update(dt)

end

function Game:draw()

end

function Game:keypressed(key)
  if key == 'escape' then love.event.quit() end

end

return Game
