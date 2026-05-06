local screen = {
    load = function()
        hero = require("../entities/hero")
    end,
    update = function(dt)
        hero.update(dt)
    end,
    draw = function()
        love.graphics.print("*** PARTIDA ***", 100, 100)
        hero.draw()
    end,
    keypressed = function(key)
    end,
    keyreleased = function(key)
    end
}

return screen
