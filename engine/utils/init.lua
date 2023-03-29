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
----@return Module[] 
---Подключает модули
local function CheckContent(params)
    local modules, packages = {}, {}
    local checkPath = params.contentPath
    local contents = love.filesystem.getDirectoryItems(checkPath)
    for _, value in pairs(contents) do
        local contentPath = checkPath .. "/" .. value
        local isModule = love.filesystem.getInfo(contentPath .. "/init.lua")
        if isModule then
            modules[value] = contentPath
        else
            packages[value] = contentPath
        end
    end
    return modules, packages
end

local function ReadConfig(path)
    local fullaPath = path
    local result = {}
    for line in love.filesystem.lines(fullaPath) do
        table.insert(result, line)
    end
    return result
end

local function LoadModule(modules, path, name) modules[name] = require(path) end

local function LoadPackage(modules, path, modulesList, packagesList)
    local configData = ReadConfig(path .. "/module_list.txt")
    for key, value in pairs(configData) do
        for key, value in pairs(configData) do
            local packagePath = packagesList[value]
            local modulePath = modulesList[value]
            local isPackage = packagePath and true or false
            local path = packagePath or modulePath
            if path then
                if isPackage then
                    LoadPackage(modules, packagePath)
                else
                    LoadModule(modules, modulePath, value)
                end
            else
                error(value .. " not exist")
            end
        end
    end
end

---загружает модули из конфига
local function LoadContent(config, modules, modulesList, packagesList)
    local config = config or "config/runConf.txt" -- или стандартный конфиг
    local configData = ReadConfig(config)
    for key, value in pairs(configData) do
        local packagePath = packagesList[value]
        local modulePath = modulesList[value]
        local isPackage = packagePath and true or false
        local path = packagePath or modulePath
        if path then
            if isPackage then
                LoadPackage(modules, packagePath, modulesList, packagesList)
            else
                LoadModule(modules, modulePath, value)
            end
        else
            error(value .. " not exist")
        end
    end
    return modules
end

local function Init(...)
    local mod = {}
    mod.IsCorrect = IsCorrect
    mod.CheckContent = CheckContent
    mod.LoadContent = LoadContent
    return mod
end

return Init(...)
