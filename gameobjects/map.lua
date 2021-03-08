local Tile = require("gameobjects.tile")

local w = 24
local h = 24

local Map = function()
    local data = {}

    local map = {}
    local mw, mh = 100, 50
    for i=1, mw do
        for j=1, mh do
                data[i..","..j] = Tile(1)
        end
    end

    for n=1, 1000 do
        local i = math.random(25, mw)
        local j = math.random(0, mh)
        local len = math.random(2, 5)
        local oi, oj, di, dj = 0, 0, 0, 0
        if math.random() < 0.5 then
            di = 1
        else
            dj = 1
        end
        -- if math.random() < 0.5 then
        --     di, dj = -di, -dj
        -- end
        local t = math.random(2, 5)
        while len >= 0 do
            len = len - 1
            oi = oi + di
            oj = oj + dj
            data[(i+oi)..","..(j+oj)] = Tile(t)
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

    map.get = function(x,y)
        return data[x..","..y]
    end

    map.set = function(x,y, id)
        data[x..","..y] = Tile(id)
    end

    return map
end

return Map