local FULLPATH = ...

local defaultParams = {}
defaultParams.contentPath = "content"
local function IsCorrect(params)
    local params = params
    if params then
        params.contentPath = params.contentPath or defaultParams.contentPath
        return params
    else
        return defaultParams
    end
end

local function CheckContent(params)
    local modules = {}
    local checkPath = params.contentPath
    local contents = love.filesystem.getDirectoryItems(checkPath)
    for _, value in pairs(contents) do
        local contentPath = checkPath .. "/" .. value
        modules[value] = require(contentPath)
    end
    return modules
end

local function Update(modules, dt)
    for key, mod in pairs(modules) do if mod.Update then mod.Update() end end
end

local function Draw(modules)
    for key, mod in pairs(modules) do if mod.Draw then mod.Draw() end end
end

---инициализатор движка 
---@param params table
---@return Engine
local function Init(params)
    ---@class Engine: Module
    local mod = SetupModule(FULLPATH)
    local params = IsCorrect(params) -- or defaultParams
    local engineFolder = mod:GetModPath()
    local request = require(engineFolder .. "/request")
    local modules = {}
    mod.CheckContent = function() modules = CheckContent(params) end
    mod.Update = function() Update(modules) end
    mod.Draw = function() Draw(modules) end
    mod:Seal()
    return mod
end

return Init
