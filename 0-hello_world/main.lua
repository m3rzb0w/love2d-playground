require "table.clear"
---@meta

--user input
local function user_input(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end


local function random_col()
    return math.random(0, 255)
end

--tile init
local function Tile(size, x, y, x_speed, y_speed, r, g, b)
    return {
        size = size,
        x = x,
        y = y,
        x_speed = x_speed,
        y_speed = y_speed,
        color = {
            r = r,
            g = g,
            b = b,
        },

        draw_tile = function(self)
            love.graphics.setColor(love.math.colorFromBytes(self.color.r, self.color.g, self.color.b))
            love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
        end,

        move_tile = function(self)
            self.x = self.x + self.x_speed
            self.y = self.y + self.y_speed
        end,

        check_position = function(self)
            if self.x + self.size >= SCREEN_WIDTH or self.x <= 0 then
                self.x_speed = self.x_speed * -1
                self:update_color()
            end

            if self.y + self.size >= SCREEN_HEIGHT or self.y <= 0 then
                self.y_speed = self.y_speed * -1
                self:update_color()
            end
        end,

        update_color = function(self)
            self.color.r = random_col()
            self.color.g = random_col()
            self.color.b = random_col()
        end
    }
end

local tile_count = 0
local tile = Tile(64, 128, 128, 5, 5, 255, 0, 255)
local tiles = {}
table.insert(tiles, tile)
tile_count = tile_count + 1

function love.keypressed(k)
    if k == "space" then
        t = Tile(64, math.random(1, SCREEN_WIDTH/2), math.random(1, SCREEN_HEIGHT/2), 5, 5, 255, 0, 255)
        table.insert(tiles, t)
        tile_count = tile_count + 1
    end

    if k == "r" then
        table.remove(tiles, 1)
        tile_count = tile_count - 1
    end

    if k == "d" then
        tiles = {}
        tile_count = 0
    end
end

local function demo_init()
    print("[info]: Starting demo...")
end
-- love2d init functions

function love.load() -- run at launch
    demo_init()
end

function love.update(dt) --
    -- dt delta time
    user_input(dt)
    love.keypressed()

    for _, t in ipairs(tiles) do
        t:check_position()
        t:move_tile(dt)
    end
end

function love.draw() -- draw on the screen
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
    love.graphics.printf("Press space to add tile | tile count : " .. tostring(tile_count), 10, 25, SCREEN_HEIGHT, "left")
    for _, t in ipairs(tiles) do
        t:draw_tile()
    end
end
