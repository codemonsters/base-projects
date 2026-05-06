--[[
    Este módulo permite definir una resolución fija en la que programar
    un videojuego con Love2D y lo escala proporcionalmente de forma 
    automática.

    Para utilizarlo es necesario:
    - Importar el módulo en el archivo main.lua del juego. Ej: autoscale = require('./misc/autoscale')
    - Ejecutar una vez (por ejemplo dentro de love.load()): autoscale.init() 
    - Antes de dibujar (al inicio de la función love.draw()), ejecutar: autoscale.before_draw()
    - Después de dibujar (al final de la función love.draw()), ejecutar: autoscale.after_draw()
    - Dentro de la función love.resize(w, h), ejecutar: autoscale.resize(w, h)
--]]

local autoscale = {
    _fixed_width = 1280, -- valor por defecto para el ancho fijo del juego (se puede redefinir al inicializar el módulo)
    _fixed_height = 720
}

-- define la variable booleana autoscale.mobile para saber si el juego se está ejecutando en un dispositivo móvil
if love.system.getOS() == "iOS" or love.system.getOS() == "Android" then
    autoscale.mobile = true
else
    autoscale.mobile = false
end

-- actualiza las variables que se utilizan para hacer correctamente el escalado (es necesario llamar a esta función al iniciar el juego y también cada vez que se redimensiona la ventana)
-- (calcula el valor de las variables factorEscala, desplazamientoX, desplazamientoY utilizadas para escalar y desplazar el viewport del juego dentro de la ventana principal)
autoscale.resize = function(device_width, device_height)
    local width_scale_factor = device_width / autoscale._fixed_width
    local height_scale_factor = device_height / autoscale._fixed_height
    if width_scale_factor < height_scale_factor then
        autoscale.scale_factor = width_scale_factor
    else
        autoscale.scale_factor = height_scale_factor
    end

    autoscale.shift_x = (device_width - autoscale.scale_factor * autoscale._fixed_width) / 2
    autoscale.shift_y = (device_height - autoscale.scale_factor * autoscale._fixed_height) / 2
end

-- El módulo requiere que se ejecute una vez init() antes de ser utilizado
autoscale.init = function(fixed_width, fixed_height)
        autoscale._fixed_width = fixed_width
        autoscale._fixed_height = fixed_height

        if autoscale.mobile then
            love.window.setFullscreen(true)
            autoscale.device_width, autoscale.device_height = love.graphics.getDimensions()
        else
            autoscale.device_width, autoscale.device_height = love.window.getDesktopDimensions()
            if not love.window.getFullscreen() then
                autoscale.device_width, autoscale.device_height = autoscale.device_width * .7, autoscale.device_height * .7 -- definimos el tamaño inicial de la ventana
                love.window.setMode(
                    autoscale.device_width,
                    autoscale.device_height,
                    {
                        vsync = true,
                        resizable = true,
                        centered = true
                    }
                )
            end
        end
        autoscale.resize(autoscale.device_width, autoscale.device_height)
    end

autoscale.before_draw = function()
    love.graphics.push()
    love.graphics.setCanvas()
    love.graphics.translate(autoscale.shift_x, autoscale.shift_y)
    love.graphics.scale(autoscale.scale_factor, autoscale.scale_factor)
end

autoscale.after_draw = function()
    love.graphics.pop()
end

return autoscale
