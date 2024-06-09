---@meta

SCREEN_WIDTH = 1024
SCREEN_HEIGHT = 750

function love.conf(t)
    t.window.width = SCREEN_WIDTH
    t.window.height = SCREEN_HEIGHT
    t.title = "Hello_World"
end