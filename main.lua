require "lib.table"

local system = require "system"
local Gamestate = require "hump.gamestate"
local game = require "gamestates.game"

function love.load()
    math.randomseed(os.time())
    Gamestate.registerEvents()
    Gamestate.switch(game)
end