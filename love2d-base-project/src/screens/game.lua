local screen = {
    _hero_module = require("../entities/hero"),

    load = function(self)
        self.background_image = love.graphics.newImage("assets/background.png")
        self.hero = self._hero_module.new_hero(54, 130)
    end,
    update = function(self, dt)
        self.hero:update(dt) -- hero.update(hero, dt)
    end,
    draw = function(self)
        love.graphics.draw(self.background_image, 0,0)
        self.hero:draw() -- hero.draw(hero)
        self.hero:draw_hitbox()
    end,
    keypressed = function(self, key)
        self.hero:keypressed(key)
    end,
    keyreleased = function(self, key)
        self.hero:keyreleased(key)
    end
}

return screen
