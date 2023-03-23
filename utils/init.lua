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

local function DeepCopy(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    local s = seen or {}
    local res = {}
    s[obj] = res
    for k, v in pairs(obj) do res[DeepCopy(k, s)] = DeepCopy(v, s) end
    return setmetatable(res, getmetatable(obj))
end

local function Copy(value)
    if type(value) == "table" then
        local result = DeepCopy(value)
        return result
    else
        return value
    end
end

---@param self Module
---Запечатывает модуль, и делает невозможным случайное добовление новых полей
local function Seal(self)
    local proxyTable = {}
    for key, v in pairs(self) do
        proxyTable[key] = Copy(self[key])
        self[key] = nil
    end
    local sealMetatable = {
        __newindex = function(...)
            print("unable to modify sealed module", ...)
        end,
        __index = function(self, key)
            local result = proxyTable[key]
            return result
        end
    }
    setmetatable(self, sealMetatable)
end

---Возвращает модуль с настроенным окружением
---@param fullPath string
---@return Module
local function SetupModule(fullPath)
    local mod = {} ---@class Module
    mod._PATH = GetModPath(fullPath) ---@private
    mod._MODNAME = GetModName(fullPath) ---@private
    mod.GetModPath = function(self) return self._PATH end
    mod.GetModName = function(self) return self._MODNAME end
    mod.Seal = Seal
    return mod
end

---загружает dll из указанной папки
local function LoadDll(dllName, path)
    if path then package.cpath = ".\\" .. path .. "\\?.dll;" .. package.cpath end
    local result = require(dllName)
    return result
end

local function Init(...)
    _G.SetupModule = SetupModule
    _G.LoadDll = LoadDll
    _G.Copy = Copy
end

return Init(...)
