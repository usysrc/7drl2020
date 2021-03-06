local Hero = require "gameobjects.hero"
local Map  = require "gameobjects.map"

local entities, map

local game = {}

function game:init()
    entities = {}
    add(entities, Hero(game))
    game.entities = entities
    
    map = Map()
    game.map = map
    
end

function game:draw()
    love.graphics.clear()
    map:draw()
    for ent in all(entities) do
        ent:draw()
    end
end

function game:keypressed(...)
    for ent in all(entities) do
        ent:keypressed(...)
    end
end

return game