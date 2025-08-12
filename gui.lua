-- gui.lua
-- Base frame + tab system

local utils = _G.utils
local Players = game:GetService("Players")
local player = Players.LocalPlayer

return function()
    -- Root
    local gui = Instance.new("ScreenGui")
    gui.Name = "NinToolkit"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    -- Main container
    local main = Instance.new("Frame")
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.Position = UDim2.new(0.5, 0, 0.5, 0)
    main.Size = UDim2.new(0, 480, 0, 360)
    main.BackgroundColor3 = Color3.fromRGB(18,18,18)
    utils.applyCorner(main, 12)
    utils.applyGradient(main, Color3.fromRGB(14,14,14), Color3.fromRGB(28,28,28))
    main.Parent = gui

    -- Header
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 40)
    header.BackgroundColor3 = Color3.fromRGB(24,24,24)
    utils.applyCorner(header, 12)
    header.Parent = main

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -12, 1, 0)
    title.Position = UDim2.new(0, 12, 0, 0)
    title.Text = "Nin Toolkit"
    title.TextColor3 = Color3.new(1,1,1)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.BackgroundTransparency = 1
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header

    -- Tabs row
    local tabs = Instance.new("Frame")
    tabs.Size = UDim2.new(1, 0, 0, 36)
    tabs.Position = UDim2.new(0, 0, 0, 40)
    tabs.BackgroundTransparency = 1
    tabs.Parent = main

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.Padding = UDim.new(0, 8)
    tabLayout.Parent = tabs

    -- Content container
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, 0, 1, -76)
    content.Position = UDim2.new(0, 0, 0, 76)
    content.BackgroundTransparency = 1
    content.Parent = main

    local sections = {}

    -- Tab creator function
    local function addTab(name, builder)
        local btn = utils.makeButton(tabs, name, 100, 32)
        local section = Instance.new("Frame")
        section.Size = UDim2.new(1, 0, 1, 0)
        section.BackgroundTransparency = 1
        section.Visible = false
        section.Parent = content

        builder(section)
        sections[btn] = section

        btn.MouseButton1Click:Connect(function()
            for _, frame in pairs(sections) do frame.Visible = false end
            section.Visible = true
        end)
    end

    return addTab
end
