local Game = require 'game'

require 'gamestates.intro'
require 'gamestates.play'

local media = require 'media'

local game

function love.load()
  media.load()
  game = Game:new(media)
  game:gotoState('Intro')
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

