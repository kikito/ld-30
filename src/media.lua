local multisource = require 'lib.multisource'
local Map         = require 'map'

local media = {}

local function newSource(name)
  local path = 'sfx/' .. name .. '.ogg'
  local source = love.audio.newSource(path)
  return multisource.new(source)
end

media.load = function()
  local names = [[
    step
  ]]

  media.sfx = {}
  for name in names:gmatch('%S+') do
    media.sfx[name] = newSource(name)
  end

  --[[
  media.music = love.audio.newSource('sfx/music.fm')
  media.music:setLooping(true)
  ]]

  media.img = {
    human = love.graphics.newImage('img/human.png')
  }

  media.maps = {
    map1 = Map:new('maps/map1.lua')
  }
end

media.cleanup = function()
  for _,sfx in pairs(media.sfx) do
    sfx:cleanup()
  end
end

return media
