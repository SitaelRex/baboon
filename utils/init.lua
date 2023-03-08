---возвращает путь к папке модуля
---@param fullPath string
---@return string
local function GetModPath(fullPath)
    local path = fullPath:gsub('%.[^%.]+$', '')
    return path
end

---возвращает имя вызывающего файла
---@param fullPath string
---@return string
local function GetModName(fullPath)
    local fileName = fullPath:sub((fullPath:find("/") or 0) + 1, -1)
    return fileName
end

---comment
---@param fullPath string
---@return Module
local function SetupModule(fullPath)
    ---@class Module
    local mod = {}
    mod._PATH = GetModPath(fullPath)
    mod._MODNAME = GetModName(fullPath)
    return mod
end

local function Init(...)
    _G.SetupModule = SetupModule
    -- _G.GetModPath = GetModPath
    -- _G.GetModName = GetModName
end

return Init(...)
