local cron = require 'lib.cron'
local Game = require 'game'
local media = require 'media'

local Win = Game:addState('Win')

function Win:draw()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(media.img.win, 0,0)
  love.graphics.setFont(media.fonts.big)
  love.graphics.print(self.win_msg, 100,300)
end

function Win:enteredState()
  media.sfx['game-win']:play()

  self.win_msg = ""

  self.scoreClock = cron.after(1, function()
    self.win_msg = self.win_msg ..
      "\n\nYou finished in " .. (self.steps or 0)  .. " steps."
  end)

  self.exitClock = cron.after(3, function()
    self.win_msg = self.win_msg ..
      "\n\n\n(Press any key)"
  end)
end

function Win:update(dt)
  self.scoreClock:update(dt)
  self.exitClock:update(dt)
end

function Win:exitedState()
  self.exitClock = nil
end

function Win:keypressed(key)
  self:gotoState('Intro')
end

return Win
