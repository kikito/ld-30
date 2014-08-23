local Game = require 'game'
local media = require 'media'

local game

function love.load()
  media.load()
  game = Game:new(media)
end

function love.update(dt)
  game:update(dt)

end

function love.draw()
  game:draw()
end

function love.keypressed(key)
  game:keypressed(key)
end

