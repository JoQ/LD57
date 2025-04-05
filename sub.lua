local k = love.keyboard
local m = love.mouse

Sub = Class('Sub')

function Sub:initialize(x, y)
    self.x = x
    self.y = y
    self.angle = 0
    self.direction = 2

    self.width = 32
    self.height = 32
    self.idleimg = love.graphics.newImage("Assets/Sub.png")

    self.speed = 40
    self.boost = 100
    self.boost_energy = 200

end
function Sub:update(dt)
    if k.isDown("w") then
        self.y = self.y - dt * self.speed
        if self.direction == 2 then
            self.angle = Smoothangle(dt, -1.5, self.angle, 1)
        elseif self.direction == -2 then
            self.angle = Smoothangle(dt, 1.5, self.angle, 1)
        end
    elseif k.isDown("s") then
        self.y = self.y + dt * self.speed
        if self.direction == 2 then
            self.angle = Smoothangle(dt, 1.5, self.angle, 1)
        elseif self.direction == -2 then
            self.angle = Smoothangle(dt, -1.5, self.angle, 1)
        end
    end

    if k.isDown("d") then
        self.x = self.x + dt * self.speed
        self.angle = Smoothangle(dt, 0, self.angle, 5)
        self.direction = 2
    elseif k.isDown("a") then
        self.x = self.x - dt * self.speed
        self.angle = Smoothangle(dt, 0, self.angle, 5)
        self.direction = -2

    end

    if (k.isDown("space") and self.boost_energy > 0) then
        self.speed = self.boost
        self.boost_energy = self.boost_energy - dt * 1.5
        Logger.info(self.boost_energy)
    else
        self.speed = 40
    end

end
function Sub:draw()
    love.graphics.draw(self.idleimg, self.x, self.y, self.angle, self.direction, 2, self.width / 2,  self.height / 2)
end

function Smoothangle(dt, goal, current, speed)
    local diff = (goal-current+math.pi)%(2*math.pi)-math.pi
    return current + (diff * speed) * dt
end
