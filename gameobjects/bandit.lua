local Timer = require "hump.timer"

local randomselect = require "lib.randomselect"
local Image = require "lib.image"
local Entity = require "gameobjects.entity"

local Bandit = function(game, x,y)
    local tile = game.map.get(x,y)
    if tile and not tile.walkable then return end

    local bandit = Entity()
    bandit.type = "bandit"
    bandit.x = x or 40
    bandit.y = y or 25
    bandit.color = {1,1,1}

    bandit.maxhp = 30
    bandit.hp = bandit.maxhp
    bandit.attack = 8

    bandit.draw = function(self)
        love.graphics.setColor(self.color)
        love.graphics.draw(Image.bandit, self:getX(), self:getY())
        love.graphics.setColor(1,1,1)
    end

    bandit.hit = function(self, other)
        self.hp = self.hp - other.attack
        if self.hp <= 0 then del(game.entities, self) end
        self.color = {0,0,0}
        Timer.after(0.25, function() self.color = {1,1,1} end)
    end

    bandit.walkon = function(self, other)
        self:hit(other)
    end

    bandit.walkinto = function(self, x,y,tx,ty)
        local found = false
        for ent in all(game.entities) do
            if ent ~= self then
                if ent.x == tx and ent.y == ty then
                    if ent.type ~= self.type then ent:walkon(self) end
                    found = true
                end
            end
        end
        if not found then
            self.x = self.x + x
            self.y = self.y + y
        end
    end

    bandit.move = function(self, x, y)
        local tx, ty = self.x + x, self.y + y
        if game.map.isWalkable(tx, ty) then
            self:walkinto(x,y,tx,ty)
        end
    end

    bandit.turn = function(self)
        if math.random() < 0.1 then
            self:move(randomselect{{-1,0}, {0, 1}, {0, -1}} )
        else
            local tx, ty = 0, 0
            if game.hero.x > self.x then
                tx = 1
            elseif game.hero.x < self.x then
                tx = -1
            end
            if game.hero.y > self.y then
                ty = 1
            elseif game.hero.y < self.y then
                ty = -1
            end
            self:move(tx, ty)
        end
    end

    return bandit
end

return Bandit