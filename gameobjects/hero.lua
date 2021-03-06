
local Image = require "lib.image"

local Entity = require "gameobjects.entity"
local Tile = require("gameobjects.tile")



local Hero = function(game)
    local breakTiles 
    breakTiles = function(tx, ty, id)
        local tile = game.map.get(tx, ty)
        if tile then
            if not id then id = tile.id end
            if id ~= tile.id then return end
    
            if tile.flags.breakable then
                game.map.set(tx, ty, 1)
            end
            breakTiles(tx+1, ty,    id)
            breakTiles(tx-1, ty,    id)
            breakTiles(tx,   ty+1,  id)
            breakTiles(tx,   ty-1,  id)
        end
    end

    local hero = Entity()
    hero.x = 20
    hero.y = 50

    hero.draw = function(self)
        love.graphics.draw(Image.hero, self:getX(), self:getY())
    end

    hero.move = function(self, x, y)
        local tx, ty = hero.x + x, hero.y + y
        if game.map.isWalkable(tx, ty) then
            hero.x = hero.x + x
            hero.y = hero.y + y
        else
            breakTiles(tx, ty)
        end
    end

    hero.keypressed = function(self, key)
        local x,y = 0, 0
        if key == "left"    then x = -1 end
        if key == "right"   then x = 1  end
        if key == "up"      then y = -1 end
        if key == "down"    then y = 1  end
        hero:move(x,y)
    end

    hero.getX = function(self)
        return self.x * self.w
    end
    
    hero.getY = function(self)
        return self.y * self.h
    end

    return hero
end

return Hero