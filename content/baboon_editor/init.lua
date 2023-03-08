local FULLPATH = ...
local imgui = require("imgui")
imgui.SetReturnValueLast(false)

local function Update() imgui.NewFrame() end

local function Draw()
    if imgui.BeginMainMenuBar() then
        if imgui.BeginMenu("File") then
            imgui.MenuItem("Test")
            imgui.EndMenu()
        end
        imgui.EndMainMenuBar()
    end
    imgui.Text("Hello, world!");
    imgui.Render();
end

local function Init()
    local mod = SetupModule(FULLPATH)
    mod.Update = Update
    mod.Draw = Draw
    -- print(MODNAME)
    ---должен получать реквесты на регистрацию ui от модулей
    return mod
end

return Init()
