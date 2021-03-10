local Entity = function()
    local e = {}
    e.type = "entity"
    e.x = 0
    e.y = 0
    e.w = 24
    e.h = 24
    e.draw = function() end
    e.update = function() end
    e.keypressed = function() end
    e.getX = function(self)
        return self.x * self.w
    end
    e.getY = function(self)
        return self.y * self.h
    end
    e.walkon = function() end
    e.turn = function() end
    e.addItem = function() end
    return e
end

return Entity