local cron = require 'lib.cron'
local Game = require 'game'

local Win = Game:addState('Win')

function Win:draw()
  love.graphics.print('You won!', 100,100)
end

function Win:enteredState()
  self.exitClock = cron.after(5, function()
    self:gotoState('Intro')
  end)
end

function Win:update(dt)
  self.exitClock:update(dt)
end

function Win:exitedState()
  self.exitClock = nil
end

function Win:keypressed(key)
  self:gotoState('Intro')
end

return Win
