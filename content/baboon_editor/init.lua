local FULLPATH = ...
local imgui = require("imgui")

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
    imgui.SetReturnValueLast(false)
    local mod = SetupModule(FULLPATH)
    mod.Update = Update
    mod.Draw = Draw
    return mod
end

return Init()
