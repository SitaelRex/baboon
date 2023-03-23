local engineParams = {}
local engine

function love.load()
    require("utils")
    local engineInit = require("engine")
    engine = engineInit(engineParams)
    engine:CheckContent()
    engine:EmitCallback("Load")
end

function love.update(dt) engine:EmitCallback("Update", dt) end

function love.draw() engine:EmitCallback("Draw") end

function love.quit() engine:EmitCallback("Quit") end

function love.textinput(t) engine:EmitCallback("TextInput", t) end

function love.keypressed(key) engine:EmitCallback("KeyPressed", key) end

function love.keyreleased(key) engine:EmitCallback("KeyReleased", key) end

function love.mousemoved(x, y) engine:EmitCallback("MouseMoved", x, y) end

function love.mousepressed(x, y, button)
    engine:EmitCallback("MousePressed", x, y, button)
end

function love.mousereleased(x, y, button)
    engine:EmitCallback("MouseReleased", x, y, button)
end

function love.wheelmoved(x, y) engine:EmitCallback("WheelMoved", x, y) end
