-- gui.lua
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Destroy existing GUI if reloaded
local oldGui = player:WaitForChild("PlayerGui"):FindFirstChild("AutoBuyGui")
if oldGui then oldGui:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoBuyGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 180)
frame.Position = UDim2.new(0.5, -150, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

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

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 60, 0, 30)
closeButton.Position = UDim2.new(1, -65, 0, 5)
closeButton.Text = "Close"
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 14
closeButton.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Utility to create toggle buttons
local function createToggleButton(text, yPos, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 260, 0, 40)
    button.Position = UDim2.new(0, 20, 0, yPos)
    button.Text = text .. ": OFF"
    button.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 16
    button.Parent = frame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    local isActive = false
    button.MouseButton1Click:Connect(function()
        isActive = not isActive
        button.Text = text .. (isActive and ": ON" or ": OFF")
        button.BackgroundColor3 = isActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(90, 90, 90)
        callback(isActive)
    end)
end

-- Create two toggles and pass the state to main.lua via _G
_G.AutoBuyToggles = _G.AutoBuyToggles or {Seeds = false, Gears = false}

createToggleButton("Seeds", 50, function(state)
    _G.AutoBuy