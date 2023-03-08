local engineParams = {}
local engine

function love.load()
    require("utils")
    local engineInit = require("engine")
    engine = engineInit(engineParams)
    engine.CheckContent()
end

function love.update() end

function love.draw() end
