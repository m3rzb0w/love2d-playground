-- requires

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
    r = 100,
    g = 1,
    b = 1
}

local text_logo = {
    val = "Hello World !",
    r = 255,
    g = 0,
    b = 255,
    x = SCREEN_WIDTH / 2,
    y = SCREEN_HEIGHT / 2
}

local debug_status = true
local rebound_count = 0


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
end

local function input_user()
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end

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
        love.graphics.setColor(60 / 255, 179 / 255, 113 / 255)
        love.graphics.rectangle("fill", t.x - 10, t.y - 10, t.size + 20, t.size + 20)
    end
    --fill
    love.graphics.setColor(love.math.colorFromBytes(t.r, t.g, t.b))
    love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
end



-- love2d init functions

function love.load() -- run at launch
    love.graphics.setBackgroundColor(bg_rgb.red, bg_rgb.green, bg_rgb.blue)
    print_debug()
end

function love.update(dt) -- loop 60 times/sec
    -- dt delta time

    input_user()
    tile.x = tile.x + tile.xspeed
    tile.y = tile.y + tile.yspeed
    tile_two.x = tile_two.x + tile_two.xspeed
    tile_two.y = tile_two.y + tile_two.yspeed
    check_position()
end

function love.draw() -- draw on the screen
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Press d for debug mode | status : " .. tostring(debug_status).."\nRebound : "..rebound_count, 10, 10, SCREEN_HEIGHT, "left")
    love.graphics.setColor(love.math.colorFromBytes(text_logo.r, text_logo.g, text_logo.b))
    love.graphics.print(text_logo.val, text_logo.x, text_logo.y)
    draw_rect(tile)
    draw_rect(tile_two)
end
