local FULLPATH = ...



local function Update(modules, dt)
    for key, mod in pairs(modules) do if mod.Update then mod.Update() end end
end

local function Draw(modules)
    for key, mod in pairs(modules) do if mod.Draw then mod.Draw() end end
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
    mod.Update = function() Update(modules) end
    mod.Draw = function() Draw(modules) end
    mod:Seal()
    return mod
end

return Init
