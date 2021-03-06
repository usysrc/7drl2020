local display = require "display.display"

local calcTarget = function(cam, obj)
    local tx = (obj:getX()) + love.graphics.getWidth()/4
    local ty = (obj:getY()) + love.graphics.getHeight()/4
    return tx, ty
end

local init = function(cam, obj)
    cam.x, cam.y = calcTarget(cam, obj)
end

local update = function(cam, obj, dt, speed)
    local speed = 3
    local tx, ty = calcTarget(cam, obj)
    cam.x = cam.x + (tx - cam.x) * dt * speed
    cam.y = cam.y + (ty - cam.y) * dt * speed
end

return {
    init = init,
    update = update,
}