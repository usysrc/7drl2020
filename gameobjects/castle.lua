local Image = require "lib.image"
local tilesize = require "lib.tilesize"

local Castle = function(game)
    local conquest = {
        x = 1,
        y = 2,
        progress = 0,
    }
    local war = {
        x = 1,
        y = 6,
        progress = 0
    }
    local famine = {
        x = 1,
        y = 10,
        progress = 0
    }
    local death = {
        x = 1,
        y = 14,
        progress = 0
    }

    local drawProgress = function(rider)
        local spacingy = tilesize
        love.graphics.setColor(1,0,0)
        love.graphics.rectangle("fill", rider.x * tilesize, rider.y*tilesize+spacingy, tilesize*rider.progress/100, 8)
        love.graphics.setColor(1,1,1)
        love.graphics.rectangle("line", rider.x * tilesize, rider.y*tilesize+spacingy, tilesize, 8)
    end

    local castle = {}
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
    return castle
end

return Castle