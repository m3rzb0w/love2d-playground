---@meta


local function user_input()
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

function love.load()
    images = love.graphics.newImage("assets/pictures/SMTSP_Jack_Frost.png")
end

function love.update()
    user_input()
end

function love.draw()
    love.graphics.draw(images, love.math.random(0, 800), love.math.random(0, 600))
end
