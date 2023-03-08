local engineParams = {}
local engine
function love.load()
    require("utils")
    engine = require("engine")(engineParams)
    engine.CheckContent()
end
function love.update() end
function love.draw() end
