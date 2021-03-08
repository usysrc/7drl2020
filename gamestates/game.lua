local Camera = require "hump.camera"
local cameralerp = require "lib.cameralerp"
local Timer = (require "hump.timer")

local Hero      = require "gameobjects.hero"
local Map       = require "gameobjects.map"
local Castle    = require "gameobjects.castle"

local entities, map, cam, hero, castle, effects

local game = {}

function game:init()
    cam = Camera()
    game.cam = cam

    hero = Hero(game)
    game.hero = hero
    
    cameralerp.init(cam, hero)
    entities = {}
    add(entities, hero)
    game.entities = entities
    
    castle = Castle(game)
    game.castle = castle
    
    map = Map()
    game.map = map

    effects = {}
    game.effects = effects
end

function game:update(dt)
    Timer.update(dt)
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
    castle:draw()
    for effect in all(effects) do
        effect:draw()
    end
    hero:drawUI()
end

function game:keypressed(...)
    for ent in all(entities) do
        ent:keypressed(...)
    end
end

function game:turn()
    cameralerp.turn()
    castle:turn()
end

return game