local Gamestate = require "hump.gamestate"
local diedState = require "gamestates.died"
local Timer = require "hump.timer"
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
                game.castle:addProgress(tx, ty, tile, 1)
            end
            breakTiles(tx+1, ty,    id)
            breakTiles(tx-1, ty,    id)
            breakTiles(tx,   ty+1,  id)
            breakTiles(tx,   ty-1,  id)
        end
    end

    local hero = Entity()
    hero.items = {}
    hero.x = 15
    hero.y = 25
    hero.color = {1,1,1}

    hero.hp = 100
    hero.maxhp = 100
    hero.attack = 10

    hero.draw = function(self)
        love.graphics.setColor(self.color)
        love.graphics.draw(Image.hero, self:getX(), self:getY())
        love.graphics.setColor(1,1,1)
    end

    hero.walkinto = function(self, x,y,tx,ty)
        local found = false
        for ent in all(game.entities) do
            if ent ~= game.hero then
                if ent.x == tx and ent.y == ty then
                    ent:walkon(self)
                    found = true
                end
            end
        end
        if not found then
            hero.x = hero.x + x
            hero.y = hero.y + y
        end
    end

    hero.move = function(self, x, y)
        local tx, ty = hero.x + x, hero.y + y
        if game.map.isWalkable(tx, ty) then
            self:walkinto(x,y,tx,ty)
        else
            breakTiles(tx, ty)
        end
        game:turn()
    end

    hero.keypressed = function(self, key)
        local x,y = 0, 0
        if key == "left"    then x = -1 end
        if key == "right"   then x = 1  end
        if key == "up"      then y = -1 end
        if key == "down"    then y = 1  end
        if x ~= 0 or y ~= 0 then hero:move(x,y) end
        if #key == 1 then
            local k = 0
            for item in all(self.items) do
                k = k + 1
                if k == tonumber(key) then
                    item:use(self)
                    del(self.items, item)
                end
            end
        end
    end

    hero.drawUI = function(self)
        love.graphics.setColor(1,0,0)
        love.graphics.rectangle("fill", 100, 4, 100 * hero.hp/hero.maxhp, 16)
        love.graphics.setColor(1,1,1)
        love.graphics.rectangle("line", 100, 4, 100, 16)
        love.graphics.setColor(1,1,1)
        local k = 0
        for item in all(self.items) do
            k = k + 1
            love.graphics.print(k..") "..item.name, 100, 32 + k*16)
        end
    end

    hero.walkon = function(self, other)
        self:hit(other)
    end
 
    hero.hit = function(self, other)
        self.hp = self.hp - other.attack
        if self.hp <= 0 then Gamestate.switch(diedState) end
        self.color = {0,0,0}
        Timer.after(0.25, function() self.color = {1,1,1} end)
    end

    hero.addItem = function(self, item)
        add(self.items, item)
    end

    return hero
end

return Hero