local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local serverId = game.JobId ~= "" and game.JobId or "Local/Studio"

-- Create GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "GardenGameGUI"
screenGui.ResetOnSpawn = false

-- Main Frame
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.Visible = true

-- Minimize Button
local minimizeButton = Instance.new("TextButton", mainFrame)
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -70, 0, 0)
minimizeButton.Text = "—"
minimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
minimizeButton.TextColor3 = Color3.new(1, 1, 1)

-- Close Button
local closeButton = Instance.new("TextButton", mainFrame)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 0)
closeButton.Text = "✖"
closeButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeButton.TextColor3 = Color3.new(1, 1, 1)

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Restore Button
local restoreButton = Instance.new("TextButton", screenGui)
restoreButton.Size = UDim2.new(0, 100, 0, 30)
restoreButton.Position = UDim2.new(0, 10, 0, 10)
restoreButton.Text = "Vns"
restoreButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
restoreButton.TextColor3 = Color3.new(1, 1, 1)
restoreButton.Visible = false

minimizeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    restoreButton.Visible = true
end)

restoreButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    restoreButton.Visible = false
end)

-- Tab Buttons and Frames
local tabs = {"Main", "Misc", "Pet"}
local tabFrames = {}

for i, tabName in ipairs(tabs) do
    local tabButton = Instance.new("TextButton", mainFrame)
    tabButton.Size = UDim2.new(0, 120, 0, 25)
    tabButton.Position = UDim2.new(0, 0, 0, 30 + ((i - 1) * 30))
    tabButton.Text = tabName
    tabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    tabButton.TextColor3 = Color3.new(1, 1, 1)
    tabButton.Font = Enum.Font.SourceSans
    tabButton.TextSize = 18
    tabButton.BorderSizePixel = 0
    tabButton.AutoButtonColor = true

    local tabFrame = Instance.new("Frame", mainFrame)
    tabFrame.Size = UDim2.new(1, -130, 1, -30)
    tabFrame.Position = UDim2.new(0, 130, 0, 30)
    tabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tabFrame.Visible = (i == 1)
    tabFrames[tabName] = tabFrame

    tabButton.MouseButton1Click:Connect(function()
        for _, frame in pairs(tabFrames) do
            frame.Visible = false
        end
        tabFrame.Visible = true
    end)
end

-- 🌐 Main Tab Content
local mainTab = tabFrames["Main"]

-- Toggle Buttons
local infoToggle = Instance.new("TextButton", mainTab)
infoToggle.Size = UDim2.new(0, 100, 0, 30)
infoToggle.Position = UDim2.new(0, 10, 0, 10)
infoToggle.Text = "INFO"
infoToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
infoToggle.TextColor3 = Color3.new(1, 1, 1)
infoToggle.Font = Enum.Font.GothamBold
infoToggle.TextSize = 18

local serverHopToggle = Instance.new("TextButton", mainTab)
serverHopToggle.Size = UDim2.new(0, 120, 0, 30)
serverHopToggle.Position = UDim2.new(0, 120, 0, 10)
serverHopToggle.Text = "SERVER HOP"
serverHopToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
serverHopToggle.TextColor3 = Color3.new(1, 1, 1)
serverHopToggle.Font = Enum.Font.GothamBold
serverHopToggle.TextSize = 18

-- Display Area
local displayArea = Instance.new("Frame", mainTab)
displayArea.Size = UDim2.new(1, -20, 1, -60)
displayArea.Position = UDim2.new(0, 10, 0, 50)
displayArea.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
displayArea.BorderSizePixel = 0

-- Player Count Label
local playerCountLabel = Instance.new("TextLabel", displayArea)
playerCountLabel.Size = UDim2.new(0, 200, 0, 30)
playerCountLabel.Position = UDim2.new(1, -210, 0, 10)
playerCountLabel.TextColor3 = Color3.new(1, 1, 1)
playerCountLabel.BackgroundTransparency = 1
playerCountLabel.TextXAlignment = Enum.TextXAlignment.Right
playerCountLabel.Font = Enum.Font.SourceSansBold
playerCountLabel.TextSize = 18
playerCountLabel.Text = "Players: " .. #game.Players:GetPlayers()

-- Info Container
local infoContainer = Instance.new("Frame")
infoContainer.Name = "InfoContainer"
infoContainer.Parent = displayArea
infoContainer.Size = UDim2.new(1, -20, 0, 100)
infoContainer.Position = UDim2.new(0, 10, 0, 50)
infoContainer.BackgroundTransparency = 1

-- Layout for stacking info rows
local layout = Instance.new("UIListLayout")
layout.Parent = infoContainer
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 6)

-- Function to create labeled info rows
local function createInfoRow(labelText, valueText)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 24)
    row.BackgroundTransparency = 1

    local label = Instance.new("TextLabel")
    label.Parent = row
    label.Size = UDim2.new(0.3, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left

    local value = Instance.new("TextLabel")
    value.Parent = row
    value.Size = UDim2.new(0.7, 0, 1, 0)
    value.Position = UDim2.new(0.3, 0, 0, 0)
    value.BackgroundTransparency = 1
    value.Text = valueText
    value.TextColor3 = Color3.new(1, 1, 1)
    value.Font = Enum.Font.Gotham
    value.TextSize = 16
    value.TextXAlignment = Enum.TextXAlignment.Left

    row.Parent = infoContainer
end

-- Add info rows
createInfoRow("Player:", player.Name)
createInfoRow("Server ID:", serverId)
createInfoRow("Place Version:", tostring(game.PlaceVersion))

-- Server Hop Section
local serverHopSection = Instance.new("ScrollingFrame", mainTab)
serverHopSection.Size = UDim2.new(1, -20, 1, -60)
serverHopSection.Position = UDim2.new(0, 10, 0, 50)
serverHopSection.BackgroundTransparency = 1
serverHopSection.Visible = false
serverHopSection.CanvasSize = UDim2.new(0, 0, 0, 300) -- Adjust height as needed
serverHopSection.ScrollBarThickness = 6
serverHopSection.ScrollingDirection = Enum.ScrollingDirection.Y
serverHopSection.AutomaticCanvasSize = Enum.AutomaticSize.Y
serverHopSection.CanvasPosition = Vector2.new(0, 0)
serverHopSection.ClipsDescendants = true

local versionLabel = Instance.new("TextLabel", serverHopSection)
versionLabel.Size = UDim2.new(1, 0, 0, 30)
versionLabel.Position = UDim2.new(0, 0, 0, 0)
versionLabel.Text = "Place Version: " .. tostring(game.PlaceVersion)
versionLabel.TextColor3 = Color3.new(1, 1, 1)
versionLabel.BackgroundTransparency = 1
versionLabel.Font = Enum.Font.SourceSansBold
versionLabel.TextSize = 18

local jobIdBox = Instance.new("TextBox", serverHopSection)
jobIdBox.Size = UDim2.new(1, -20, 0, 30)
jobIdBox.Position = UDim2.new(0, 10, 0, 40)
jobIdBox.PlaceholderText = "Enter JobId / ServerId"
jobIdBox.TextColor3 = Color3.new(1, 1, 1)
jobIdBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
jobIdBox.Font = Enum.Font.SourceSans
jobIdBox.TextSize = 16

-- Join JobId Server Button
local joinJobButton = Instance.new("TextButton", serverHopSection)
joinJobButton.Size = UDim2.new(1, -20, 0, 30)
joinJobButton.Position = UDim2.new(0, 10, 0, 80)
joinJobButton.Text = "Join JobId Server"
joinJobButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
joinJobButton.TextColor3 = Color3.new(1, 1, 1)
joinJobButton.Font = Enum.Font.GothamBold
joinJobButton.TextSize = 16

-- Rejoin Button
local rejoinButton = Instance.new("TextButton", serverHopSection)
rejoinButton.Size = UDim2.new(1, -20, 0, 30)
rejoinButton.Position = UDim2.new(0, 10, 0, 120)
rejoinButton.Text = "Rejoin Current Server"
rejoinButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
rejoinButton.TextColor3 = Color3.new(1, 1, 1)
rejoinButton.Font = Enum.Font.GothamBold
rejoinButton.TextSize = 16

-- Server Hop Button
local hopButton = Instance.new("TextButton", serverHopSection)
hopButton.Size = UDim2.new(1, -20, 0, 30)
hopButton.Position = UDim2.new(0, 10, 0, 160)
hopButton.Text = "Server Hop"
hopButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
hopButton.TextColor3 = Color3.new(1, 1, 1)
hopButton.Font = Enum.Font.GothamBold
hopButton.TextSize = 16

-- Toggle Logic
infoToggle.MouseButton1Click:Connect(function()
    infoSection.Visible = true
    serverHopSection.Visible = false
end)

serverHopToggle.MouseButton1Click:Connect(function()
    infoSection.Visible = false
    serverHopSection.Visible = true
end)

-- Server Actions
joinJobButton.MouseButton1Click:Connect(function()
    local jobId = jobIdBox.Text
    if jobId and jobId ~= "" then
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, jobId, player)
    end
end)

rejoinButton.MouseButton1Click:Connect(function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, serverId, player)
end)

hopButton.MouseButton1Click:Connect(function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, player)
end)

-- 🚀 Misc Tab Content
local miscTab = tabFrames["Misc"]

local toggleTeleportUI = Instance.new("TextButton", miscTab)
toggleTeleportUI.Size = UDim2.new(0, 200, 0, 40)
toggleTeleportUI.Position = UDim2.new(0.5, -100, 0.3, -20)
toggleTeleportUI.Text = "Show Event Button: OFF"
toggleTeleportUI.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
toggleTeleportUI.TextColor3 = Color3.new(1, 1, 1)
toggleTeleportUI.Font = Enum.Font.SourceSans
toggleTeleportUI.TextSize = 18

-- 🎯 Event Button
local teleportButton = Instance.new("TextButton", screenGui)
teleportButton.Size = UDim2.new(0, 150, 0, 40)
teleportButton.Position = UDim2.new(0.5, -75, 0, 60)
teleportButton.Text = "EVENT"
teleportButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
teleportButton.TextColor3 = Color3.new(1, 1, 1)
teleportButton.Font = Enum.Font.GothamBold
teleportButton.TextSize = 24
teleportButton.Visible = false

teleportButton.MouseButton1Click:Connect(function()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart", 5)
    if hrp then
        hrp.CFrame = CFrame.new(-100, 3, -10)
    end
end)

toggleTeleportUI.MouseButton1Click:Connect(function()
    teleportButton.Visible = not teleportButton.Visible
    if teleportButton.Visible then
        toggleTeleportUI.Text = "Show Event Button: ON"
        toggleTeleportUI.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    else
        toggleTeleportUI.Text = "Show Event Button: OFF"
        toggleTeleportUI.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    end
end)

-- 🐾 Pet Tab (Placeholder)
local petTab = tabFrames["Pet"]

local petLabel = Instance.new("TextLabel", petTab)
petLabel.Size = UDim2.new(1, -20, 1, -20)
petLabel.Position = UDim2.new(0, 10, 0, 10)
petLabel.Text = "Pet features coming soon!"
petLabel.TextColor3 = Color3.new(1, 1, 1)
petLabel.BackgroundTransparency = 1
petLabel.Font = Enum.Font.SourceSansItalic
petLabel.TextSize = 20
petLabel.TextWrapped = true

