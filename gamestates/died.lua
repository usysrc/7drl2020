local died = {}

died.draw = function()
    love.graphics.clear()
    love.graphics.print("you dead, son", 250, 150)
end

return died