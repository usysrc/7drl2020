local Image = require "lib.image"

local Tile = function(id)
    local tile = {}
    tile.img = Image.tile
    tile.walkable = true
    return tile
end

return Tile