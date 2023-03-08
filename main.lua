local engineParams = {}
local engine
function love.load()
    engine = require("engine")(engineParams)
    engine.CheckContent()
end
function love.update() end
function love.draw() end
