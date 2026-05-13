local screen = {
    load = function()
        background_image = love.graphics.newImage("assets/background.png")
        hero = require("../entities/hero")
        
    end,
    update = function(dt)
        hero.update(dt)
    end,
    draw = function()
        love.graphics.draw(background_image, 0,0)
        hero.draw()
    end,
    keypressed = function(key)
    end,
    keyreleased = function(key)
    end
}

return screen
