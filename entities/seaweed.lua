Seaweed = Class('Seaweed')

function Seaweed:initialize()
    self.idleimg = love.graphics.newImage("Assets/Seaweed.png")
    Seaweeds = {}

end
function Seaweed:spawn(x, y)
    local weed = {}
    weed.x = x
    weed.y = y
    table.insert(Seaweeds, weed)
end
function Seaweed:update(dt)

end
function Seaweed:draw()
    for i,v in ipairs(Seaweeds) do
        love.graphics.draw(self.idleimg, v.x, v.y)
    end

end
function Seaweed:collect(x, y)
    for i,v in ipairs(Seaweeds) do
        Logger.info(v.x - x)
        if math.sqrt((x - v.x) ^ 2 + (y - v.y) ^ 2) < 60 then
            --Add resturs till inventory?!
            sub:inventory("add", "seaweed", 1)
            table.remove(Seaweeds, i)
        end

    end
end
