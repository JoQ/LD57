-------------------------------------------------
-- PH-name #LD56
-- Website: http://jksoft.se
-- Licence:
-- Copyright (c) JoQ, JKsoft
-------------------------------------------------

require 'game'
require 'settings'


function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { resizable = false, vsync = false, minwidth = 800, minheight = 600 })
    love.window.setTitle("LD56 - PH-name")
    Game = Game:new()
end

function love.update(dt)
    Game:update(dt)
end

function love.draw()
    Game:draw()
    love.graphics.print("Current FPS: " .. tostring(love.timer.getFPS()), 10, 10)
end
