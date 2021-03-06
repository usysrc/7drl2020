local Image = require "lib.image"

local TilePreset = function(img, walkable)
    return {
        img = img,
        walkable = walkable
    }
end

local tiles = {
    TilePreset(Image.tile, true),
    TilePreset(Image.block, false),
    TilePreset(Image.bblock, false),
    TilePreset(Image.gblock, false)    
}

local Tile = function(id)
    local tile = {}
    local preset = tiles[id]
    tile.img = preset.img
    tile.walkable = preset.walkable
    return tile
end

return Tile