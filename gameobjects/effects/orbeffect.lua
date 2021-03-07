local Image = require "lib.image"
local Timer = (require "hump.timer")

local tilesize = require "lib.tilesize"

local addOrbEffect = function(game, tx, ty, mx, my)
    local cx, cy = game.cam:cameraCoords(tx * tilesize, ty * tilesize)
    local obj = {
        x = cx,
        y = cy,
        draw = function(self)
            love.graphics.setColor(1,1,1)
            love.graphics.draw(Image.orb, self.x, self.y)
        end
    }
    add(game.effects, obj)
    Timer.after(math.random()*0.1,function()
    Timer.tween(0.5+math.random()*0.1, obj, {x = mx * tilesize, y = my * tilesize}, 'in-out-quad', function()
        del(game.effects, obj)
    end) end)
end

return addOrbEffect