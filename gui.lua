-- gui.lua (module-style return)
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoBuyGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Parent = screenGui

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 60, 0, 30)
closeButton.Position = UDim2.new(1, -65, 0, 5)
closeButton.Text = "Close"
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Parent = frame

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

return screenGui