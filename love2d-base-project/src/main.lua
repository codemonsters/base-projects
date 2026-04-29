require('./misc/autoscale')
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
    init_autoscale()
end

function love.update(dt)
    current_screen.update(dt)
end

function love.draw()
    love.graphics.push()
    love.graphics.setCanvas(mainCanvas)
    love.graphics.translate(desplazamientoX, desplazamientoY)
    love.graphics.scale(factorEscala, factorEscala)

    current_screen.draw()

    love.graphics.pop()
end

function love.keypressed(key)
    current_screen.keypressed(key)
end

function love.keyreleased(key)
    current_screen.keyreleased(key)
end

function love.resize(w, h)
    update_scale_variables(w, h)
end
