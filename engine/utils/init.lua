local defaultParams = {}
defaultParams.contentPath = "content"
---Проверка параметров движка
---@param params table
---@return table
local function IsCorrect(params)
    local params = params
    if params then
        params.contentPath = params.contentPath or defaultParams.contentPath
        return params
    else
        return defaultParams
    end
end

-- TODO следить за порядком добавления модулей и соблюдением зависимостей, сортировать модули
---@param params table
---@return Module[] 
---Подключает модули
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

local function Init(...)
    local mod = {}
    mod.IsCorrect = IsCorrect
    mod.CheckContent = CheckContent
    return mod
end

return Init(...)
