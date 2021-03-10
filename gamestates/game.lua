local Camera = require "hump.camera"
local cameralerp = require "lib.cameralerp"
local Timer = (require "hump.timer")

local Hero      = require "gameobjects.hero"
local Bandit    = require "gameobjects.bandit"
local Potion    = require "gameobjects.potion"
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

    for i=1, 10 do
        add(entities, Bandit(game, i*8, 25))
    end
    for i=1, 10 do
        for j=1, 10 do
            add(entities, Potion(game, 2+i*8, 2+j*8))
        end
    end
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
    for ent in all(entities) do
        ent:turn()
    end
end

return game