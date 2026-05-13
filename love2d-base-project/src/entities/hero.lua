local hero = {
    x = 20,
    y = 10,
    image = love.graphics.newImage("assets/hero.png"),
    update = function(dt)
        -- cosas de héroes
    end,
    draw = function()
        -- dibujar el héroe
        love.graphics.draw(hero.image, hero.x, hero.y)
    end
}

return hero
