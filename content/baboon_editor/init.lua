local FULLPATH = ...

local imgui = LoadDll("imgui", FULLPATH)

local function Update() imgui.NewFrame() end

local function Draw()
    imgui.SetNextWindowPos(0, 0)
    imgui.SetNextWindowSize(love.graphics.getWidth(), love.graphics.getHeight())
    if imgui.Begin("DockArea", nil, {
        "ImGuiWindowFlags_NoTitleBar", "ImGuiWindowFlags_NoResize",
        "ImGuiWindowFlags_NoMove", "ImGuiWindowFlags_NoBringToFrontOnFocus"
    }) then
        imgui.BeginDockspace()

        -- Create 10 docks
        for i = 1, 10 do
            if imgui.BeginDock("dock_" .. i) then
                imgui.Text("Hello, dock " .. i .. "!");
            end
            imgui.EndDock()
        end

        imgui.EndDockspace()
    end
    imgui.End()

    love.graphics.clear(0.2, 0.2, 0.2)
    imgui.Render();
end

local function MouseMoved(x, y) imgui.MouseMoved(x, y) end

local function MousePressed(x, y, button) imgui.MousePressed(button) end

local function MouseReleased(x, y, button) imgui.MouseReleased(button) end

local function WheelMoved(x, y) imgui.WheelMoved(y) end

local function KeyPressed(key) imgui.KeyPressed(key) end

local function KeyReleased(key) imgui.KeyReleased(key) end

local function TextInput(t) imgui.TextInput(t) end

local function Init()
    imgui.SetReturnValueLast(false)
    local mod = SetupModule(FULLPATH)
    mod.Update = Update
    mod.Draw = Draw
    mod.MouseMoved = MouseMoved
    mod.MousePressed = MousePressed
    mod.MouseReleased = MouseReleased
    mod.WheelMoved = WheelMoved
    mod.KeyPressed = KeyPressed
    mod.KeyReleased = KeyReleased
    mod.TextInput = TextInput
    return mod
end

return Init()
