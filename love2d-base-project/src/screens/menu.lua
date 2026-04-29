local screen = {
    load = function()
    end,
    update = function(dt)
    end,
    draw = function()
        love.graphics.print("*** MENU ***", 400, 300)
    end,
    keypressed = function(key)
        if key == "space" then
            change_screen("game")
        end
    end,
    keyreleased = function(key)
    end
}
return screen
