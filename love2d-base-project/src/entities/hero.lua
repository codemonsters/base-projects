local my_module = {}

function my_module.new_hero(x_init, y_init)
    local hero = {
        x = x_init,
        y = y_init,
        img_shift_x = -60,
        img_shift_y = -130,
        hitbox = {x = 2, y = 4, w = 23, h = 40},
        image = love.graphics.newImage("assets/hero.png"),
        _left_pressed = false,
        _right_pressed = false,
        update = function(self, dt)
            if self._left_pressed then
                self.x = self.x - 1
            end
            if self._right_pressed then
                self.x = self.x + 1
            end
        end,
        draw = function(self)
            -- dibujar el héroe
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.draw(self.image, self.x + self.img_shift_x, self.y + self.img_shift_y)
        end,
        draw_hitbox = function(self)
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.rectangle(
                "line",
                self.x + self.hitbox.x,
                self.y + self.hitbox.y,
                self.hitbox.w, self.hitbox.h)
        end,
        keypressed = function(self, key)
            if key == "left" then
                self._left_pressed = true
            elseif key == "right" then
                self._right_pressed = true
            end
        end,
        keyreleased = function(self, key)
            if key == "left" then
                self._left_pressed = false
            elseif key == "right" then
                self._right_pressed = false
            end
        end,
    }
    return hero
end

return my_module

