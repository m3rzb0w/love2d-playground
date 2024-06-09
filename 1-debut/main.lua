---@meta
-- requires
require "bullet"

-- variables
local bg_rgb = { -- black
    red = 0,
    green = 0,
    blue = 0
}

local tile = {
    size = 64,
    x = 128,
    y = 128,
    xspeed = 10,
    yspeed = 10,
    r = 255,
    g = 0,
    b = 255
}

local tile_two = {
    size = 64,
    x = 512,
    y = 12,
    xspeed = 5,
    yspeed = 5,
    r = 255,
    g = 0,
    b = 255
}

local player = {
    size = 40,
    x = 10,
    y = 120,
    xspeed = 200,
    yspeed = 200,
    r = 255,
    g = 255,
    b = 255,
}

local ground_bg = {
    x = 0,
    y = -1200,
    yspeed = 50
}


local text_logo = {
    val = "Hello World !",
    r = 255,
    g = 0,
    b = 255,
    x = SCREEN_WIDTH / 2,
    y = SCREEN_HEIGHT / 2
}

local assets_path = "assets/pictures/"

local assets = {
    ship = assets_path.."ship.png",
}

local debug_status = false
local rebound_count = 0

local ship = love.graphics.newImage(assets.ship)

local function print_debug()
    print("[info]: debug status : " .. tostring(debug_status))
end

function love.keypressed(k)
    if k == "d" then
        debug_status = not debug_status
        print_debug()
    end

    if k == "r" then
        rebound_count = 0
        print("[info] resetting rebound")
    end

    if k == "a" then
        BULLET.shoot(k, player)
    end
end


local function input_user(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end

    if love.keyboard.isDown("up") then
        player.y = player.y - player.yspeed * dt
    end

    if love.keyboard.isDown("down") then
        player.y = player.y + player.yspeed * dt
    end

    if love.keyboard.isDown("left") then
        player.x = player.x - player.xspeed * dt
    end

    if love.keyboard.isDown("right") then
        player.x = player.x + player.xspeed * dt
    end

    -- if love.keyboard.isDown("a") then
    --     BULLET.shoot("a", player)
    -- end

    love.keypressed()
end

local function random_col()
    return math.random(0, 255)
end

local function color_randomizer(t)
    t.r = random_col()
    t.g = random_col()
    t.b = random_col()
end

local function check_position()
    --tile one
    if tile.x + tile.size >= SCREEN_WIDTH or tile.x <= 0 then
        tile.xspeed = tile.xspeed * -1
        rebound_count = rebound_count + 1
        color_randomizer(tile)
    end

    if tile.y + tile.size >= SCREEN_HEIGHT or tile.y <= 0 then
        tile.yspeed = tile.yspeed * -1
        rebound_count = rebound_count + 1
        color_randomizer(tile)
    end



    --tile two
    if tile_two.x + tile_two.size >= SCREEN_WIDTH or tile_two.x <= 0 then
        tile_two.xspeed = tile_two.xspeed * -1
        rebound_count = rebound_count + 1
        color_randomizer(tile_two)
    end

    if tile_two.y + tile_two.size >= SCREEN_HEIGHT or tile_two.y <= 0 then
        tile_two.yspeed = tile_two.yspeed * -1
        rebound_count = rebound_count + 1
        color_randomizer(tile_two)
    end
end

local function draw_rect(t)
    --border
    if debug_status then
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", t.x, t.y, t.size, t.size)
    end
    --fill
    love.graphics.setColor(love.math.colorFromBytes(t.r, t.g, t.b))
    love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
end

local function draw_player(p)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(ship, p.x, p.y, 0, 1, 1)
    if debug_status then
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", p.x, p.y, p.size, p.size)
        love.graphics.setColor(255/255, 0, 255/255)
        love.graphics.rectangle("line", p.x + p.size/2 - 8, p.y + p.size/2 - 8, 16, 16)
        love.graphics.setColor(1, 1, 1)
    end
end



-- love2d init functions

function love.load() -- run at launch
    love.graphics.setBackgroundColor(bg_rgb.red, bg_rgb.green, bg_rgb.blue)
    print_debug()
end

function love.update(dt) -- loop 60 times/sec
    -- dt delta time

    input_user(dt)
    tile.x = tile.x + tile.xspeed
    tile.y = tile.y + tile.yspeed
    tile_two.x = tile_two.x + tile_two.xspeed
    tile_two.y = tile_two.y + tile_two.yspeed
    check_position()
    ground_bg.y = ground_bg.y + ground_bg.yspeed * dt
    if ground_bg.y >= 1200 then
        ground_bg.y = -1200
    end
    BULLET.update(dt)
end

function love.draw() -- draw on the screen
    -- love.graphics.draw(bg, 0, 0, 0, 1, 1)
    -- love.graphics.draw(ground, ground_bg.x, ground_bg.y)


    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Press d for debug mode | status : " .. tostring(debug_status).."\nRebound : "..rebound_count.."\nPlayer pos : "..player.x..", "..player.y, 10, 10, SCREEN_HEIGHT, "left")
    love.graphics.setColor(love.math.colorFromBytes(text_logo.r, text_logo.g, text_logo.b))
    love.graphics.printf(text_logo.val, 0, text_logo.y, SCREEN_WIDTH, "center")
    -- draw_rect(tile)
    -- draw_rect(tile_two)
    -- draw_rect(player)
    draw_player(player)
    BULLET.draw()
    love.graphics.setColor(1, 1, 1)

end
