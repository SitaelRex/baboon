---@param fullPath string
---@return string
---возвращает путь к папке модуля
local function GetModPath(fullPath)
    local path = fullPath:gsub('%.[^%.]+$', '')
    return path
end

---@param fullPath string
---@return string
---возвращает имя вызывающего файла
local function GetModName(fullPath)
    local fileName = fullPath:sub((fullPath:find("/") or 0) + 1, -1)
    return fileName
end

---@param self Module
---Запечатывает модуль, и делает yневозможным случайное добовление новых полей
local function Seal(self)
    local selaMetatable = {
        __newindex = function(...)
            print("unable to modify sealed module", ...)
        end,
        __index = function(...)
            print("unable to modify sealed module", ...)
        end
    }
    setmetatable(self, selaMetatable)
end

---Возвращает модуль с настроенным окружением
---@param fullPath string
---@return Module
local function SetupModule(fullPath)
    ---@class Module
    local mod = {}
    ---@private
    mod._PATH = GetModPath(fullPath)
    ---@private
    mod._MODNAME = GetModName(fullPath)
    mod.GetModPath = function(self) return self._PATH end
    mod.GetModName = function(self) return self._MODNAME end
    mod.Seal = Seal
    return mod
end

local function Init(...) _G.SetupModule = SetupModule end

return Init(...)
