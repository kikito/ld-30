local class = require 'lib.middleclass'

local Map = class('Map')

local function parseWorldString(str)
  str = str:gsub(' ', '')

  local result = {cells = {}}

  local width = #(str:match("[^\n]+"))
  result.width = width

  local y,x = 1,1
  for row in str:gmatch("[^\n]+") do
    assert(#row == width, 'Map is not aligned: width of row ' .. tostring(y) .. ' should be ' .. tostring(width) .. ', but it is ' .. tostring(#row))
    result.cells[y] = {}
    x = 1
    for char in row:gmatch(".") do
      result.cells[y][x] = char
      x = x + 1
    end
    y=y+1
  end

  result.height = y - 1

  return result
end

function Map:initialize(map_data)
  self.earth    = parseWorldString(map_data.earth)
  self.hell     = parseWorldString(map_data.hell)
  self.buttons  = map_data.buttons
end

return Map




