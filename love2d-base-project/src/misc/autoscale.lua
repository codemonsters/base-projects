local _fixed_width, _fixed_height = 1280, 720 -- El juego se programa dentro una pantalla de este tamaño fijo (la ventana escalará esto según sea necesario)

-- define la variable booleana 'mobile' para saber si el juego se está ejecutando en un dispositivo móvil
if love.system.getOS() == "iOS" or love.system.getOS() == "Android" then
    mobile = true
else
    mobile = false
end

-- actualiza las variables que se utilizan para hacer correctamente el escalado (es necesario llamar a esta función al iniciar el juego y también cada vez que se redimensiona la ventana)
-- (calcula el valor de las variables factorEscala, desplazamientoX, desplazamientoY utilizadas para escalar y desplazar el viewport del juego dentro de la ventana principal)
function update_scale_variables(device_width, device_height)
    local factorEscalaAncho = device_width / _fixed_width
    local factorEscalaAlto = device_height / _fixed_height
    if factorEscalaAncho < factorEscalaAlto then
        factorEscala = factorEscalaAncho
    else
        factorEscala = factorEscalaAlto
    end

    desplazamientoX = (device_width - factorEscala * _fixed_width) / 2
    desplazamientoY = (device_height - factorEscala * _fixed_height) / 2
end

function init_autoscale(fixed_width, fixed_height)
    _fixed_width = fixed_width
    _fixed_height = fixed_height

    if mobile then
        love.window.setFullscreen(true)
        device_width, device_height = love.graphics.getDimensions()
    else
        device_width, device_height = love.window.getDesktopDimensions()
        if not love.window.getFullscreen() then
            device_width, device_height = device_width * .7, device_height * .7 -- definimos el tamaño inicial de la ventana
            love.window.setMode(
                device_width,
                device_height,
                {
                    vsync = true,
                    resizable = true,
                    centered = true
                }
            )
        end
    end
    update_scale_variables(device_width, device_height)
end
