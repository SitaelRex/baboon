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
local function Init(params)
    local params = IsCorrect(params) -- or defaultParams
    local mod = SetupModule(FULLPATH)

    --  local contentPath = params.contentPath
    local modules = {}

    mod.CheckContent = function()
        local checkPath = params.contentPath
        local contents = love.filesystem.getDirectoryItems(checkPath)
        for _, value in pairs(contents) do
            local contentPath = checkPath .. "/" .. value
            modules[value] = require(contentPath)
        end
    end

    return mod
end

return Init
