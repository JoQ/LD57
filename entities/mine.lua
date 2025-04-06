require 'libs/utils'
local anim8 = require 'libs/anim8'
Mine = Class('Mine')

function Mine:initialize()
    self.idleimg = love.graphics.newImage("Assets/mine.png")
    self.activeimg = love.graphics.newImage('Assets/mineactive.png')
    local g = anim8.newGrid(32, 32, self.activeimg:getWidth(), self.activeimg:getHeight())
    self.activationanimation = anim8.newAnimation(g('1-3',1), 0.1)

    Mines = {}


end
function Mine:spawn(x, y)
    local mine = {}
    mine.x = x
    mine.y = y
    mine.maxy = y - 8
    mine.miny = y + 8
    mine.down = false
    mine.speed = math.random(2, 5)
    mine.size = math.random(10, 18)*.1
    mine.state = 0 --0 default, 1 active, other value then booom
    mine.dtime = 5
    mine.etime = 3
    table.insert(Mines, mine)
end

function Mine:update(dt)
    for i, v in ipairs(Mines) do
        local bombx, bomby = cam:toScreen(v.x, v.y)
        --Collisons checks?!
        if CheckCollision(sub.x, sub.y, 64, 64, v.x, v.y, v.size*32, v.size*32) then
            v.state = 1
        end
        if v.state == 1 and v.dtime > 0 then
            --count down
            v.dtime = v.dtime - dt * 1
        end
        if v.dtime < 0 and v.state == 1 then
            --booom
            --Luven.addFlashingLight(bombx, bomby, { 1.0, 0.0, 0.0 }, 1, 5)
            v.light = Luven.addFlickeringLight(v.x, v.y, { min = { 0.8, 0.0, 0.0, 0.6 }, max = { 1.0, 0.0, 0.0, 1.0 } }, { min = 0.25, max = 0.27 }, { min = 0.12, max = 0.2 }, nil, 1, 2, 2)
            v.state = 2
        elseif v.state == 2 then
            Luven.setLightPosition(v.light, bombx, bomby)
            if v.etime > 0 then
                v.etime = v.etime - dt * 1
            else
                Luven.removeLight(v.light)
                table.remove(Mines, i)
            end
        end
        --Move it up
        if v.maxy <= v.y and v.down == false then
            v.y = v.y - dt * v.speed
        else
            v.down = true
        end
        --Or down
        if v.miny >= v.y and v.down == true then
            v.y = v.y + dt * v.speed
        else
            v.down = false
        end

    end
    self.activationanimation:update(dt)
end
function Mine:draw()
    for i,v in ipairs(Mines) do
        if v.state == 0 then
            love.graphics.draw(self.idleimg, v.x, v.y, 1, v.size, v.size)
        elseif v.state == 1 then
            self.activationanimation:draw(self.activeimg, v.x, v.y, 1, v.size, v.size)


        end
    end
end
