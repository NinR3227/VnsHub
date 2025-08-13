-- gui.lua
-- 🖼️ Simple GUI with Close Button

local GUI = Instance.new("ScreenGui")
GUI.Name = "AutoBuyGUI"
GUI.ResetOnSpawn = false
GUI.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "AutoBuy Panel"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = Frame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 100, 0, 30)
CloseButton.Position = UDim2.new(0.5, -50, 1, -40)
CloseButton.Text = "Close"
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.Gotham
CloseButton.TextSize = 16
CloseButton.Parent = Frame

CloseButton.MouseButton1Click:Connect(function()
    GUI:Destroy()
end)

return GUI