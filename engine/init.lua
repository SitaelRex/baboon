local FULLPATH = ...
local isExist = false

---список всех колбеков, для которых будут сгенерированы функции по шаблону
local CallbacksList = {
    "Quit", "TextInput", "KeyPressed", "KeyReleased", "MouseMoved",
    "MousePressed", "MouseReleased", "WheelMoved", "Load", "Update", "Draw"
}

---таблица со сгенерироваными колбеками
local Callbacs = {}

---генерация колбеков по шаблону
local function InitCallbacks()
    for _, callbackName in ipairs(CallbacksList) do
        Callbacs[callbackName] = function(modules, ...)
            for _, mod in pairs(modules) do
                if mod[callbackName] then mod[callbackName](...) end
            end
        end
    end
end

local EmitCallback = function(modules, callbackName, ...)
    if Callbacs[callbackName] then
        Callbacs[callbackName](modules, ...)
    else
        print("Engine doesn't have callback " .. callbackName)
    end
end

---@param params table
---@return Engine
--- инициализатор движка 
local function Init(params)
    assert(not isExist, "Engine can init only once")
    isExist = true
    InitCallbacks()
    local mod = SetupModule(FULLPATH) ---@class Engine: Module
    local engineFolder = mod:GetModPath()
    local utils = require(engineFolder .. "/utils")
    local request = require(engineFolder .. "/request")
    local params = utils.IsCorrect(params)
    local modulesList, packagesList = {}, {}
    local modules = {}
    mod.CheckContent = function()
        modulesList, packagesList = utils.CheckContent(params)
    end -- load from conf
    ---загрузка модулей после check content
    mod.LoadContent = function(self, config)
        -- local config = config or nil
        modules = utils.LoadContent(config, modules, modulesList, packagesList)
    end
    mod.EmitCallback = function(self, callbackName, ...)
        EmitCallback(modules, callbackName, ...)
    end
    mod:Seal()
    return mod
end

return Init
