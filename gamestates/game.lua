local Camera = require "hump.camera"
local cameralerp = require "lib.cameralerp"

local Hero = require "gameobjects.hero"
local Map  = require "gameobjects.map"

local entities, map, cam, hero

local game = {}

function game:init()
    cam = Camera()

    hero = Hero(game)
    cameralerp.init(cam, hero)
    entities = {}
    add(entities, hero)
    game.entities = entities
    
    map = Map()
    game.map = map
end

function game:update(dt)
    cameralerp.update(cam, hero, dt)
end

function game:draw()
    love.graphics.clear()
    cam:attach()
    map:draw()
    for ent in all(entities) do
        ent:draw()
    end
    cam:detach()
end

function game:keypressed(...)
    for ent in all(entities) do
        ent:keypressed(...)
    end
end

return game