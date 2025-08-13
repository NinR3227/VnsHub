-- gui.lua
-- ⚡ Auto-Buy Controller GUI (Seeds + Gears)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local pg = player:WaitForChild("PlayerGui")

-- Destroy existing GUI if reloaded
local oldGui = pg:FindFirstChild("AutoBuyGui")
if oldGui then
    oldGui:Destroy()
end

-- Ensure global toggles exist (adds more keys if you extend)
_G.AutoBuyToggles = _G.AutoBuyToggles or {
    Seeds = false,
    Gears = false,
}

-- Root ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoBuyGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = pg

-- Container Frame
local frame = Instance.new("Frame")
frame.Name = "Root"
frame.Size = UDim2.new(0, 300, 0, 180)
frame.Position = UDim2.new(0.5, -150, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

-- Title Bar
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -70, 0, 30)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ Auto-Buy Controller"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 16
title.Font = Enum.Font.SourceSansBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 60, 0, 30)
closeButton.Position = UDim2.new(1, -65, 0, 5)
closeButton.Text = "Close"
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 14
closeButton.AutoButtonColor = true
closeButton.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Toggle Factory
local function createToggleButton(labelText, key, yPos)
    -- Container
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -20, 0, 30)
    container.Position = UDim2.new(0, 10, 0, yPos)
    container.BackgroundTransparency = 1
    container.Parent = frame

    -- Label
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.6, 0, 1, 0)
    lbl.Position = UDim2.new(0, 0, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = Color3.new(1, 1, 1)
    lbl.TextSize = 14
    lbl.Font = Enum.Font.SourceSans
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = container

    -- Toggle Button
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 50, 1, 0)
    toggle.Position = UDim2.new(1, -50, 0, 0)
    toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggle.TextColor3 = Color3.new(1, 1, 1)
    toggle.Font = Enum.Font.SourceSansBold
    toggle.TextSize = 14
    toggle.AutoButtonColor = true
    toggle.Parent = container

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 4)
    toggleCorner.Parent = toggle

    local function updateToggleUI()
        if _G.AutoBuyToggles[key] then
            toggle.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
            toggle.Text = "ON"
        else
            toggle.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
            toggle.Text = "OFF"
        end
    end

    toggle.MouseButton1Click:Connect(function()
        _G.AutoBuyToggles[key] = not _G.AutoBuyToggles[key]
        updateToggleUI()
    end)

    -- Initialize
    updateToggleUI()
end

-- Create Toggles (stacked 40px apart)
createToggleButton("Seeds", "Seeds", 40)
createToggleButton("Gears", "Gears", 80)

return {}  -- ModuleScript pattern if you require it, otherwise ignore