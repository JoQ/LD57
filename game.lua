Class = require 'libs/middleclass'
require 'settings'
require 'sub'
require 'entities.seaweed'
require 'entities.mine'

local gamera = require 'libs/gamera'
Luven = require 'libs/luven/luven'

local k = love.keyboard


Game = Class('Game')

function Game:initialize()
    WORLD_WIDTH = 2000
    WORLD_HEIGHT = 2000
    cam = gamera.new(0,0,WORLD_WIDTH,WORLD_HEIGHT)
    love.graphics.setDefaultFilter("nearest","nearest")

    bg = love.graphics.newImage("Assets/BG.png")

    Luven.init(WINDOW_WIDTH, WINDOW_HEIGHT, false)
    Luven.setAmbientLightColor({ 0.7, 0.7, 0.7 })


    --sublight = Luven.addNormalLight(200, 200, { 0.9, 1, 0 }, 1, Luven.lightShapes.cone, 0)

    sub = Sub:new(200, 200)

    seaweed = Seaweed:new()
    mine = Mine:new()

    for i = 1, 150 do
        seaweed:spawn(math.random(20, 1980), math.random(10, 350))
    end
    for i = 1, 50 do
        mine:spawn(math.random(20, 1980), math.random(900, 1350))
    end

end

function Game:update(dt)
    Luven.update(dt)
    sub:update(dt)
    mine:update(dt)

    if sub.y < 650 then
        Luven.setAmbientLightColor({ 0.5, 0.5, 0.5 })
    elseif sub.y >= 900 and sub.y <= 1599 then
        Luven.setAmbientLightColor({ 0.3, 0.3, 0.3 })
    elseif sub.y >= 1600 then
        Luven.setAmbientLightColor({ 0.1, 0.1, 0.1 })
    end

    --Luven.setLightPosition(sub.light, sub.x, sub.y)

end

function love.keypressed(key)
    if key == "e" then
        seaweed:collect(sub.x, sub.y)
    end
end

function Game:draw()
    local function drawCameraStuff()
      -- draw stuff that will be affected by the camera, for example:

      love.graphics.draw(bg, 0, 0)
      seaweed:draw()
      mine:draw()
      sub:draw()

    end
    Luven.drawBegin()
    cam:draw(drawCameraStuff)
    Luven.drawEnd()

    love.graphics.print("Seaweed: " .. tostring(sub.inventorysweed), 10, 30)
    --love.graphics.rectangle("fill",10,30,sub.boost_energy,15)
end
