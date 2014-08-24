local multisource = require 'lib.multisource'
local Map         = require 'map'

local media = {}

local TILE_WIDTH, TILE_HEIGHT = 32,32

local function newSource(name)
  local path = 'sfx/' .. name .. '.ogg'
  local source = love.audio.newSource(path)
  return multisource.new(source)
end

local function newQuad(x,y,atlas)
  local l,t = (x-1)*TILE_WIDTH, (y-1)*TILE_HEIGHT
  return love.graphics.newQuad(l,t,TILE_WIDTH, TILE_HEIGHT, atlas:getDimensions())
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

  local atlas = love.graphics.newImage('img/atlas.png')
  media.img = {
    atlas = atlas
  }

  media.quads = {
    human        = newQuad(1,1, atlas),
    ground       = newQuad(2,1, atlas),
    wall         = newQuad(3,1, atlas),
    ball         = newQuad(4,1, atlas),
    button       = newQuad(5,1, atlas),
    goal         = newQuad(6,1, atlas),
    demon        = newQuad(1,2, atlas),
    hell_ground  = newQuad(2,2, atlas),
    hell_wall    = newQuad(3,2, atlas),
    hell_ball    = newQuad(4,2, atlas),
    hell_button  = newQuad(5,2, atlas),
    hell_goal    = newQuad(6,2, atlas),
    meta_ball    = newQuad(4,3, atlas)
  }
end

media.cleanup = function()
  for _,sfx in pairs(media.sfx) do
    sfx:cleanup()
  end
end

return media
