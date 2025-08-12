-- gui.lua
-- Base GUI layout for Nin Toolkit

local function createGui()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NinToolkit"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Header
    local header = Instance.new("Frame")
    header.Size = UDim2.new(0, 400, 0, 40)
    header.Position = UDim2.new(0.5, -200, 0, 50)
    header.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    header.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 1, 0)
    title.Text = "Nin Toolkit"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.Parent = header

    -- Tab container
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, 0, 0, 360)
    tabContainer.Position = UDim2.new(0, 0, 0, 40)
    tabContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    tabContainer.Parent = header

    return function(tabName, builder)
        local container = Instance.new("Frame")
        container.Size = UDim2.new(1, 0, 1, 0)
        container.BackgroundTransparency = 1
        container.Parent = tabContainer
        builder(container)
    end
end

return createGui()