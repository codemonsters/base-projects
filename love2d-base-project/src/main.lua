autoscale = require('./misc/autoscale')
require ("./misc/utils")

enable_local_lua_debugger()

-- *** CALLBACKS LOVE2D *** --

function change_screen(screen_module_name)
    current_screen = require("./screens/" .. screen_module_name)
    current_screen.load()
end

function love.load()
    love.graphics.setDefaultFilter("nearest") -- definimos el filtro usado durante el escalado
    change_screen("menu")
    autoscale.init(384, 216)    -- pasamos como argumento la resolución fija a la que diseñaremos el juego
end

function love.update(dt)
    current_screen.update(dt)
end

function love.draw()
    autoscale.before_draw()
    current_screen.draw()
    autoscale.after_draw()
end

function love.keypressed(key)
    current_screen.keypressed(key)
end

function love.keyreleased(key)
    current_screen.keyreleased(key)
end

function love.resize(w, h)
    autoscale.resize(w, h)
end
