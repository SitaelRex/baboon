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

---инициализатор движка 
---@param params table
---@return Engine
local function Init(params)
    ---@class Engine: Module
    local mod = SetupModule(FULLPATH)
    local params = IsCorrect(params) -- or defaultParams
    local modules = {}
    mod.CheckContent = function()
        local checkPath = params.contentPath
        local contents = love.filesystem.getDirectoryItems(checkPath)
        for _, value in pairs(contents) do
            local contentPath = checkPath .. "/" .. value
            modules[value] = require(contentPath)
        end
    end
    mod:Seal()
    return mod
end

return Init
