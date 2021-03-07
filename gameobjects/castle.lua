local Image = require "lib.image"
local tilesize = require "lib.tilesize"

local addOrbEffect = require "gameobjects.effects.orbeffect"

local Castle = function(game)
    local conquest = {
        x = 1,
        y = 2,
        progress = 0,
        maxprogress = 30,
        col = {1,1,1}
    }
    local war = {
        x = 1,
        y = 6,
        progress = 0,
        maxprogress = 30,
        col = {1,0,0}
    }
    local famine = {
        x = 1,
        y = 10,
        progress = 0,
        maxprogress = 30,
        col = {0,0.75,0}
    }
    local death = {
        x = 1,
        y = 14,
        progress = 0,
        maxprogress = 30,
        col = {0.5,0.5,0.5}
    }

    local drawProgress = function(rider)
        local spacingy = tilesize
        love.graphics.setColor(0,0,0)
        love.graphics.rectangle("fill", rider.x * tilesize, rider.y*tilesize+spacingy, tilesize, 8)
        love.graphics.setColor(rider.col)
        love.graphics.rectangle("fill", rider.x * tilesize, rider.y*tilesize+spacingy, tilesize*math.min(1, rider.progress/rider.maxprogress), 8)
        love.graphics.setColor(1,1,1)
        love.graphics.rectangle("line", rider.x * tilesize, rider.y*tilesize+spacingy, tilesize, 8)
    end

    local castle = {}
    
    castle.conquest, castle.war, castle.famine, castle.death = conquest, war, famine, death

    castle.draw = function()
        for i=0, 1 do
            for j=0, 16 do
                love.graphics.draw(Image.cobble, i * tilesize, j * tilesize)
                
            end
            
        end

        for j=0,16 do
            local i = 2
            love.graphics.draw(Image.mauer, i * tilesize, j * tilesize)
        end
        love.graphics.draw(Image.famine, conquest.x * tilesize, conquest.y * tilesize)
        drawProgress(conquest)

        love.graphics.draw(Image.famine, war.x * tilesize, war.y * tilesize)
        drawProgress(war)

        love.graphics.draw(Image.famine, famine.x * tilesize, famine.y * tilesize)
        drawProgress(famine)

        love.graphics.draw(Image.famine, death.x * tilesize, death.y * tilesize)
        drawProgress(death)

    end
   
    castle.addProgress = function(self, tx, ty, tile, x)

        if tile.name == "ablock" then
            conquest.progress = conquest.progress + x
            addOrbEffect(game, tx, ty, conquest.x, conquest.y)
        end
        if tile.name == "bblock" then
            war.progress = war.progress + x
            addOrbEffect(game, tx, ty, war.x, war.y)
        end
        if tile.name == "gblock" then
            famine.progress = famine.progress + x
            addOrbEffect(game, tx, ty, famine.x, famine.y)
        end
        if tile.name == "oblock" then
            death.progress = death.progress + x
            addOrbEffect(game, tx, ty, death.x, death.y)
        end
    end

    return castle
end

return Castle