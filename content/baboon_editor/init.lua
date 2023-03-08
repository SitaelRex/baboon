local FULLPATH = ...
local function Init()
    local mod = SetupModule(FULLPATH)
    local imgui = require("imgui")
    -- print(MODNAME)
    ---должен получать реквесты на регистрацию ui от модулей
    return mod
end

return Init()
