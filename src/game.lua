local class    = require 'lib.middleclass'
local Stateful = require 'lib.stateful'

local Game = class('Game'):include(Stateful)

function Game:initialize(media)
  self.media = media
end

function Game:update(dt)

end

function Game:draw()

end

function Game:keypressed(key)

end

return Game
