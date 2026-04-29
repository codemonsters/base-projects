local screen = {
    load = function()
    end,
    update = function(dt)
    end,
    draw = function()
        love.graphics.print("*** PARTIDA ***", 400, 300)
    end,
    keypressed = function(key)
    end,
    keyreleased = function(key)
    end
}

return screen
