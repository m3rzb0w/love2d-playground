---@meta

BULLET_SPEED = 500
BULLET = {}

function BULLET.spawn(x, y, dir)
    table.insert(BULLET, { width = 10, height = 10, x = x, y = y, dir = dir })
end

function BULLET.draw()
    for _, v in ipairs(BULLET) do
        love.graphics.setColor(255, 0, 255)
        love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    end
end

function BULLET.update(dt)
    for i, v in ipairs(BULLET) do
        if v.dir == "up" then
            v.y = v.y - BULLET_SPEED * dt
        end
        if v.y < 0 then
            table.remove(BULLET, i)
        end
        print(v.y)
    end
end

function BULLET.shoot(key, player)
    if key == "a" then
        BULLET.spawn(player.x + 15, player.y - 20 + player.size / 2, "up")
    end
end