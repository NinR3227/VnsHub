-- gui.lua
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoBuyGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 10)
padding.PaddingLeft = UDim.new(0, 10)
padding.PaddingRight = UDim.new(0, 10)
padding.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -70, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ Auto-Buy Controller"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 16
title.Font = Enum.Font.SourceSansBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 60, 0, 30)
closeButton.Position = UDim2.new(1, -60, 0, 0)
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

return screenGui