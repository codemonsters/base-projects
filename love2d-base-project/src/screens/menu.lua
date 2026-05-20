local screen = {
    load = function(self)
    end,
    update = function(self, dt)
    end,
    draw = function(self)
        love.graphics.print("*** MENU ***", 100, 100)
    end,
    keypressed = function(self, key)
        if key == "space" then
            change_screen("game")
        end
    end,
    keyreleased = function(self, key)
    end
}
return screen
