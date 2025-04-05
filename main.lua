-------------------------------------------------
-- PH-name #LD57
-- Website: http://jksoft.se
-- Licence:
-- Copyright (c) JoQ, JKsoft
-------------------------------------------------

Lualog = require'lualog'

Logger = Lualog.new{ -- you can use Lualog() instead Lualog.new
    tag = 'LD57', -- a logger tag. default: ''
    styles = {dev = 'yellow', crash = 'bgred'}, -- define custom methods and their style. default: {}
    ignore_levels = {'dev'}, -- ignore levels (array). default: {}
    datestring = '%H:%M:%S', -- date string for os.date(). default: false => Not show
    table_inspect = { -- table-inspect plugin config
        prettyfy = true, -- pretty print tables. default: false
        allow_tostring = true, -- allow use table __tostring metamethod. default: true
        level_depth = 0 -- max nested level to inspect. default: 0. 0 means no level limit
    },
    plugins = {'table-inspect'} -- add plugins to log items. table-inspect is a optional predefined plugin.
                               -- You can add function plugins here too. See as define a plugin at Plugin section. default: {} => no plugins added.
}


require 'game'
require 'settings'


function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { resizable = false, vsync = false, minwidth = 800, minheight = 600 })
    love.window.setTitle("LD57 - Sten's Sub")
    Game = Game:new()


    Logger.info('LuaLog redo!')

end

function love.update(dt)
    Game:update(dt)
end


function love.draw()
    Game:draw()
    love.graphics.print("Current FPS: " .. tostring(love.timer.getFPS()), 10, 10)
end

function love.quit()
    Luven.dispose()
end
