---стандартные параметры инициализации движка
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
    local contentPath = params.contentPath
    local modules = {}
    local mod = {}

    mod.CheckContent = function()
        local checkPath = contentPath
        local contents = love.filesystem.getDirectoryItems(checkPath)
        for key, value in pairs(contents) do print(key, value) end
    end

    return mod
end

return Init
