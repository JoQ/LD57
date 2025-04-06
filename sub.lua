local k = love.keyboard

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
    self.boost_energy = 40
    self.light_energy = 0.8

    self.inventorysweed = 0

    self.light = Luven.addNormalLight(self.x + 5, self.y - 27, { 0.9, 1, 0 }, 1, Luven.lightShapes.cone, 0)
end
function Sub:update(dt)
    local camx, camy = cam:toScreen(self.x, self.y)
    if k.isDown("w") and self.y > 0 then
        self.y = self.y - dt * self.speed
        if self.direction == 2 then
            self.angle = Smoothangle(dt, -1.5, self.angle, 1)
        elseif self.direction == -2 then
            self.angle = Smoothangle(dt, 1.5, self.angle, 1)
        end
    elseif k.isDown("s") and self.y < WORLD_HEIGHT then
        self.y = self.y + dt * self.speed
        if self.direction == 2 then
            self.angle = Smoothangle(dt, 1.5, self.angle, 1)
        elseif self.direction == -2 then
            self.angle = Smoothangle(dt, -1.5, self.angle, 1)
        end
    else
        self.angle = Smoothangle(dt, 0, self.angle, 1)
    end

    if k.isDown("d") and self.x < WORLD_WIDTH then
        self.x = self.x + dt * self.speed
        self.angle = Smoothangle(dt, 0, self.angle, 5)
        self.direction = 2
        Luven.setLightScale(self.light, 1, 1)
    elseif k.isDown("a") and self.x > 0 then
        self.x = self.x - dt * self.speed
        self.angle = Smoothangle(dt, 0, self.angle, 5)
        self.direction = -2
        Luven.setLightScale(self.light, -1, 1)
    end

    if (k.isDown("space") and self.boost_energy > 0) then
        self.speed = self.boost
        self.boost_energy = self.boost_energy - dt * 1.5
    else
        self.speed = 40
    end

    if self.direction == 2 then
        Luven.setLightPosition(self.light, (camx + 32 * math.cos(self.angle)), (camy + 32 * math.sin(self.angle)))
    elseif self.direction == -2 then
        Luven.setLightPosition(self.light, (camx - 32 * math.cos(self.angle)), (camy - 32 * math.sin(self.angle)))
    end

    Luven.setLightRotation(self.light, self.angle)
    Luven.setLightPower(self.light, self.light_energy)
    cam:setPosition(self.x, self.y)
end
function Sub:draw()
    love.graphics.draw(self.idleimg, self.x, self.y, self.angle, self.direction, 2, self.width / 2,  self.height / 2)

    love.graphics.setColor(1, 0.5, 0, 0.8)
    love.graphics.setLineWidth(5)
    love.graphics.arc("line", "open", self.x, self.y, 45, 0, self.boost_energy/100 * 2 * math.pi)
    love.graphics.setColor(1, 1, 1)
    --love.graphics.arc("line", "open", self.x, self.y, 50, 0, self.light * math.pi)
end

function Smoothangle(dt, goal, current, speed)
    local diff = (goal-current+math.pi)%(2*math.pi)-math.pi
    return current + (diff * speed) * dt
end

function Sub:inventory(action, type, amount)
    if action == "add" then
        if type == "seaweed" then
            self.inventorysweed = self.inventorysweed + amount
        end
    end
end
