Mine = Class('Mine')

function Mine:initialize()
    self.idleimg = love.graphics.newImage("Assets/mine.png")
    Mines = {}

end
function Mine:spawn(x, y)
    local mine = {}
    mine.x = x
    mine.y = y
    mine.maxy = y - 8
    mine.miny = y + 8
    mine.down = false
    table.insert(Mines, mine)
end
function Mine:update(dt)
    for i, v in ipairs(Mines) do
        if v.maxy <= v.y and v.down == false then
            v.y = v.y - dt * 3
        else
            v.down = true
        end
        if v.miny >= v.y and v.down == true then
            v.y = v.y + dt * 3
        else
            v.down = false
        end

    end
end
function Mine:draw()
    for i,v in ipairs(Mines) do
        love.graphics.draw(self.idleimg, v.x, v.y)
    end
end
