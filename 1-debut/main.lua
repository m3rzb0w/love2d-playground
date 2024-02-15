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
    r = 1,
    g = 1,
    b = 1
}


local function input_user()
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

local function random_float()
    return math.floor(math.random() * 10) / 10
end

local function color_randomizer(t)
    t.r = random_float()
    t.g = random_float()
    t.b = random_float()
end

local function check_position()
    --tile one
    if tile.x + tile.size >= SCREEN_WIDTH or tile.x <= 0 then
        tile.xspeed = tile.xspeed * -1
        color_randomizer(tile)
    end

    if tile.y + tile.size >= SCREEN_HEIGHT or tile.y <= 0 then
        tile.yspeed = tile.yspeed * -1
        color_randomizer(tile)
    end

    --tile two
    if tile_two.x + tile_two.size >= SCREEN_WIDTH or tile_two.x <= 0 then
        tile_two.xspeed = tile_two.xspeed * -1
        color_randomizer(tile_two)
    end

    if tile_two.y + tile_two.size >= SCREEN_HEIGHT or tile_two.y <= 0 then
        tile_two.yspeed = tile_two.yspeed * -1
        color_randomizer(tile_two)
    end
end

local function draw_rect(t)
    love.graphics.setColor(t.r, t.g, t.b)
    love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
end

-- love2d init functions

function love.load() -- run at launch
    love.graphics.setBackgroundColor(bg_rgb.red, bg_rgb.green, bg_rgb.blue)
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
    love.graphics.print("Hello World", SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
    draw_rect(tile)
    draw_rect(tile_two)
end


