local Game  = require 'game'
local Level = require 'level'
local Map   = require 'map'
local maps  = require 'maps'
local media = require 'media'

local Play = Game:addState('Play')

function Play:hasNextLevel()
  return self.level_index < #maps
end

function Play:loadLevel()
  local map_data = maps[self.level_index]
  local map = Map:new(map_data)
  self.level = Level:new(map)
end

function Play:enteredState()
  self.level_index = 1
  self.steps = 0
  self:loadLevel()
end

function Play:draw()
  self.level:draw()

  local w,h = love.graphics.getDimensions()

  local font = media.fonts.ui

  love.graphics.setFont(font)
  local text_height = font:getHeight()
  local text_width = font:getWidth(self.steps)

  love.graphics.setColor(0,0,0)
  love.graphics.rectangle('fill', w-text_width, h-text_height, text_width, text_height)
  love.graphics.setColor(255,255,255)
  love.graphics.print(self.steps, w - text_width, h - text_height)
end

function Play:keypressed(key)
  if key == 'escape' then
    self:gotoState('Intro')
  end

  if key == 'up' or key == 'down' or key == 'right' or key == 'left' then
    if self.level:attemptMove(key) then
      self.steps = self.steps + 1
      if self.level:isWon() then
        if self:hasNextLevel() then
          self.level_index = self.level_index + 1
          self:loadLevel()
        else
          self:gotoState('Win')
        end
      end
    end
  end

  if key == ' ' or key == 'enter' or key == 'tab' then
    self.level:switchActiveWorld()
  end
end

function Play:exitedState()
  self.level = nil
end

return Play
