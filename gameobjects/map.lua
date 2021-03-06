local Tile = require("gameobjects.tile")

local w = 24
local h = 24

local Map = function()
    local data = {}

    local map = {}
    for i=1, 100 do
        for j=1, 100 do
            data[i..","..j] = Tile()
        end
    end

    map.isWalkable = function(x,y)
        local tile = data[x..","..y]
        return tile and tile.walkable
    end

    map.draw = function(self)
        for i=1, 100 do
            for j=1, 100 do
                local tile = data[i..","..j]
                if tile then
                    love.graphics.draw(tile.img, i * w, j * h)
                end
            end
        end
    end
    return map
end

return Map