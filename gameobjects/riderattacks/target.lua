local Image = require "lib.image"
local Entity = require "gameobjects.entity"
local tilesize = require "lib.tilesize"

local Target = function(game)
    local obj = Entity()
    obj.x = game.hero.x + 1
    obj.y = game.hero.y 
    obj.draw = function(self)
        love.graphics.draw(Image.target, self.x * tilesize, self.y * tilesize)
    end
    obj.walkon = function(self, other)
        other:hit(10)
    end
    add(game.entities, obj)
end

return Target