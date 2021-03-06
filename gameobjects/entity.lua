local Entity = function()
    local e = {}
    e.x = 0
    e.y = 0
    e.w = 24
    e.h = 24
    e.draw = function() end
    e.update = function() end
    return e
end

return Entity