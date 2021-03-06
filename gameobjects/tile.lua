local Image = require "lib.image"

local TilePreset = function(name, img, walkable, flags)
    
    local fl = {}
    if flags then
        for flag in all(flags) do
            fl[flag] = true
        end
    end

    return {
        name = name,
        img = img,
        walkable = walkable,
        flags = fl
    }
end

local tiles = {
    TilePreset("grass", Image.tile, true),
    TilePreset("oblock", Image.block, false, {"breakable"}),
    TilePreset("bblock", Image.bblock, false, {"breakable"}),
    TilePreset("gblock", Image.gblock, false, {"breakable"})
}

local Tile = function(id)
    local tile = {}
    local preset = tiles[id]
    tile.img = preset.img
    tile.walkable = preset.walkable
    tile.flags = preset.flags
    tile.id = id
    return tile
end

return Tile