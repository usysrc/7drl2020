local Image = require "lib.image"

local Entity = require "gameobjects.entity"

local Hero = function(game)

    local hero = Entity()
    hero.x = 5
    hero.y = 5

    hero.draw = function(self)
        love.graphics.draw(Image.hero, self.x * self.w, self.y * self.h)
    end

    hero.move = function(self, x, y)
        local tx, ty = hero.x + x, hero.y + y
        if game.map.isWalkable(tx, ty) then
            hero.x = hero.x + x
            hero.y = hero.y + y
        end
    end

    hero.keypressed = function(self, key)
        local x,y = 0, 0
        if key == "left"    then x = -1 end
        if key == "right"   then x = 1  end
        if key == "up"      then y = -1 end
        if key == "down"    then y = 1 end
        hero:move(x,y)
    end
    
    return hero
end

return Hero