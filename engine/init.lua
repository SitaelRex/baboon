local FULLPATH = ...

local CallbacksList = {
    "Quit", "TextInput", "KeyPressed", "KeyReleased", "MouseMoved",
    "MousePressed", "MouseReleased", "WheelMoved", "Load", "Update", "Draw"
}
local Callbacs = {}

for _, callbackName in ipairs(CallbacksList) do
    Callbacs[callbackName] = function(modules, ...)
        for _, mod in pairs(modules) do
            if mod[callbackName] then mod[callbackName](...) end
        end
    end
end

-- Callbacs.Quit = function() end
--
-- Callbacs.Textinput = function() end
--
-- Callbacs.Keypressed = function() end
--
-- Callbacs.Keyreleased = function() end
--
-- Callbacs.Mousemoved = function() end
-- Callbacs.Mousepressed = function() end
-- Callbacs.Mousereleased = function() end
-- Callbacs.Wheelmoved = function() end
-- Callbacs.Load = function() end
--
-- Callbacs.Update = function(modules, dt)
--    for key, mod in pairs(modules) do if mod.Update then mod.Update(dt) end end
-- end
--
-- Callbacs.Draw = function(modules)
--    for key, mod in pairs(modules) do if mod.Draw then mod.Draw() end end
-- end

local EmitCallback = function(modules, callbackName, ...)
    if Callbacs[callbackName] then
        Callbacs[callbackName](modules, ...)
    else
        print("Engine doesn't have callback " .. callbackName)
    end
end

---@param params table
---@return Engine
--- инициализатор движка 
local function Init(params)
    local mod = SetupModule(FULLPATH) ---@class Engine: Module
    local engineFolder = mod:GetModPath()
    local utils = require(engineFolder .. "/utils")
    local request = require(engineFolder .. "/request")
    local params = utils.IsCorrect(params)
    local modules = {}
    mod.CheckContent = function() modules = utils.CheckContent(params) end
    mod.EmitCallback = function(self, callbackName, ...)
        EmitCallback(modules, callbackName, ...)
    end
    -- for callbackName, func in pairs(Callbacs) do
    --   mod[callbackName] = function() func(modules) end
    -- end
    -- mod.Load = function() Load(modules) end
    --  mod.Update = function() Update(modules) end
    -- mod.Draw = function() Draw(modules) end
    mod:Seal()
    return mod
end

return Init
