local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local serverId = game.JobId ~= "" and game.JobId or "Local/Studio"
local ShopList = loadstring(game:HttpGet("https://raw.githubusercontent.com/NinR3227/VnsHub/main/ShopList.lua"))()

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GardenGameGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local minimizeButton = Instance.new("TextButton", mainFrame)
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -70, 0, 0)
minimizeButton.Text = "—"
minimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
minimizeButton.TextColor3 = Color3.new(1, 1, 1)

local closeButton = Instance.new("TextButton", mainFrame)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 0)
closeButton.Text = "✖"
closeButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeButton.TextColor3 = Color3.new(1, 1, 1)

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

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

-- MAIN TAB SECTION
local mainTab = tabFrames["Main"]

-- Toggle Buttons for INFO and SERVER HOP
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

-- Info Container
local infoContainer = Instance.new("Frame", mainTab)
infoContainer.Size = UDim2.new(1, -20, 1, -60)
infoContainer.Position = UDim2.new(0, 10, 0, 50)
infoContainer.BackgroundTransparency = 1
infoContainer.Visible = true

local displayArea = Instance.new("Frame", infoContainer)
displayArea.Size = UDim2.new(1, -20, 1, -60)
displayArea.Position = UDim2.new(0, 10, 0, 50)
displayArea.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
displayArea.BorderSizePixel = 0

local playerCountLabel = Instance.new("TextLabel", displayArea)
playerCountLabel.Size = UDim2.new(0, 200, 0, 30)
playerCountLabel.Position = UDim2.new(1, -210, 0, 10)
playerCountLabel.TextColor3 = Color3.new(1, 1, 1)
playerCountLabel.BackgroundTransparency = 1
playerCountLabel.TextXAlignment = Enum.TextXAlignment.Right
playerCountLabel.Font = Enum.Font.SourceSansBold
playerCountLabel.TextSize = 18
playerCountLabel.Text = "Players: " .. #game.Players:GetPlayers()

local infoSection = Instance.new("TextLabel", displayArea)
infoSection.Size = UDim2.new(1, -20, 1, -20)
infoSection.Position = UDim2.new(0, 10, 0, 40)
infoSection.TextColor3 = Color3.new(1, 1, 1)
infoSection.BackgroundTransparency = 1
infoSection.TextWrapped = true
infoSection.TextYAlignment = Enum.TextYAlignment.Top
infoSection.Font = Enum.Font.SourceSans
infoSection.TextSize = 16
infoSection.Text = "Player: " .. player.Name ..
    "\nServer ID: " .. serverId ..
    "\nPlace Version: " .. tostring(game.PlaceVersion)

-- SERVER HOP Container
local serverHopContainer = Instance.new("Frame", mainTab)
serverHopContainer.Size = UDim2.new(1, -20, 1, -60)
serverHopContainer.Position = UDim2.new(0, 10, 0, 50)
serverHopContainer.BackgroundTransparency = 1
serverHopContainer.Visible = false

-- Server Hop Section: Scrollable UI with all controls
local serverHopSection = Instance.new("ScrollingFrame", serverHopContainer)
serverHopSection.Size = UDim2.new(1, -20, 1, -60)
serverHopSection.Position = UDim2.new(0, 10, 0, 50)
serverHopSection.BackgroundTransparency = 1
serverHopSection.Visible = true
serverHopSection.CanvasSize = UDim2.new(0, 0, 0, 300)
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

local joinJobButton = Instance.new("TextButton", serverHopSection)
joinJobButton.Size = UDim2.new(1, -20, 0, 30)
joinJobButton.Position = UDim2.new(0, 10, 0, 80)
joinJobButton.Text = "Join JobId Server"
joinJobButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
joinJobButton.TextColor3 = Color3.new(1, 1, 1)
joinJobButton.Font = Enum.Font.GothamBold
joinJobButton.TextSize = 16

local rejoinButton = Instance.new("TextButton", serverHopSection)
rejoinButton.Size = UDim2.new(1, -20, 0, 30)
rejoinButton.Position = UDim2.new(0, 10, 0, 120)
rejoinButton.Text = "Rejoin Current Server"
rejoinButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
rejoinButton.TextColor3 = Color3.new(1, 1, 1)
rejoinButton.Font = Enum.Font.GothamBold
rejoinButton.TextSize = 16

local hopButton = Instance.new("TextButton", serverHopSection)
hopButton.Size = UDim2.new(1, -20, 0, 30)
hopButton.Position = UDim2.new(0, 10, 0, 160)
hopButton.Text = "Server Hop"
hopButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
hopButton.TextColor3 = Color3.new(1, 1, 1)
hopButton.Font = Enum.Font.GothamBold
hopButton.TextSize = 16

infoToggle.MouseButton1Click:Connect(function()
    infoContainer.Visible = true
    serverHopContainer.Visible = false
end)

serverHopToggle.MouseButton1Click:Connect(function()
    infoContainer.Visible = false
    serverHopContainer.Visible = true
end)

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

-- ========== MISC TAB ==========

local miscTab = tabFrames["Misc"]

-- ESP/Automation horizontal row at top
local espAutoRow = Instance.new("Frame", miscTab)
espAutoRow.Size = UDim2.new(1, -20, 0, 40)
espAutoRow.Position = UDim2.new(0, 10, 0, 10)
espAutoRow.BackgroundTransparency = 1

local espDropdownBtn = Instance.new("TextButton", espAutoRow)
espDropdownBtn.Size = UDim2.new(0, 140, 0, 30)
espDropdownBtn.Position = UDim2.new(0, 0, 0, 5)
espDropdownBtn.Text = "ESP"
espDropdownBtn.BackgroundColor3 = Color3.fromRGB(120, 120, 0)
espDropdownBtn.TextColor3 = Color3.new(1, 1, 1)
espDropdownBtn.Font = Enum.Font.SourceSansBold
espDropdownBtn.TextSize = 18

local automationDropdownBtn = Instance.new("TextButton", espAutoRow)
automationDropdownBtn.Size = UDim2.new(0, 140, 0, 30)
automationDropdownBtn.Position = UDim2.new(0, 160, 0, 5)
automationDropdownBtn.Text = "Automation"
automationDropdownBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
automationDropdownBtn.TextColor3 = Color3.new(1, 1, 1)
automationDropdownBtn.Font = Enum.Font.SourceSansBold
automationDropdownBtn.TextSize = 18

-- ESP Section
local espContainer = Instance.new("Frame", miscTab)
espContainer.Size = UDim2.new(1, -20, 1, -60)
espContainer.Position = UDim2.new(0, 10, 0, 60)
espContainer.BackgroundTransparency = 1
espContainer.Visible = true

local toggleTeleportUI = Instance.new("TextButton", espContainer)
toggleTeleportUI.Size = UDim2.new(0, 200, 0, 40)
toggleTeleportUI.Position = UDim2.new(0.5, -100, 0.2, 0)
toggleTeleportUI.Text = "Show Event Button: OFF"
toggleTeleportUI.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
toggleTeleportUI.TextColor3 = Color3.new(1, 1, 1)
toggleTeleportUI.Font = Enum.Font.SourceSans
toggleTeleportUI.TextSize = 18

-- EVENT Button (teleport)
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

-- Automation Section
local automationContainer = Instance.new("Frame", miscTab)
automationContainer.Size = UDim2.new(1, -20, 1, -60)
automationContainer.Position = UDim2.new(0, 10, 0, 60)
automationContainer.BackgroundTransparency = 1
automationContainer.Visible = false

local autoBuyLabel = Instance.new("TextLabel", automationContainer)
autoBuyLabel.Size = UDim2.new(1, -20, 0, 30)
autoBuyLabel.Position = UDim2.new(0, 10, 0, 0)
autoBuyLabel.Text = "Auto Buy Panel"
autoBuyLabel.TextColor3 = Color3.new(1, 1, 1)
autoBuyLabel.BackgroundTransparency = 1
autoBuyLabel.Font = Enum.Font.SourceSansBold
autoBuyLabel.TextSize = 20

local function createAutoBuySection(parent, labelName, y)
    local container = Instance.new("Frame", parent)
    container.Size = UDim2.new(1, -20, 0, 50)
    container.Position = UDim2.new(0, 10, 0, y)
    container.BackgroundTransparency = 1

    local lbl = Instance.new("TextLabel", container)
    lbl.Size = UDim2.new(0, 80, 0, 30)
    lbl.Position = UDim2.new(0, 0, 0, 0)
    lbl.Text = labelName
    lbl.TextColor3 = Color3.new(1, 1, 1)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextSize = 18

    local autoBuySelectedBtn = Instance.new("TextButton", container)
    autoBuySelectedBtn.Size = UDim2.new(0, 120, 0, 30)
    autoBuySelectedBtn.Position = UDim2.new(0, 90, 0, 0)
    autoBuySelectedBtn.Text = "Auto Buy Selected"
    autoBuySelectedBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
    autoBuySelectedBtn.TextColor3 = Color3.new(1, 1, 1)
    autoBuySelectedBtn.Font = Enum.Font.SourceSans
    autoBuySelectedBtn.TextSize = 16

    local autoBuyAllBtn = Instance.new("TextButton", container)
    autoBuyAllBtn.Size = UDim2.new(0, 120, 0, 30)
    autoBuyAllBtn.Position = UDim2.new(0, 220, 0, 0)
    autoBuyAllBtn.Text = "Auto Buy All"
    autoBuyAllBtn.BackgroundColor3 = Color3.fromRGB(120, 120, 0)
    autoBuyAllBtn.TextColor3 = Color3.new(1, 1, 1)
    autoBuyAllBtn.Font = Enum.Font.SourceSans
    autoBuyAllBtn.TextSize = 16

    autoBuySelectedBtn.MouseButton1Click:Connect(function()
        print("Auto Buy Selected " .. labelName)
        -- Insert your buy selected logic here
    end)
    
    autoBuyAllBtn.MouseButton1Click:Connect(function()
    print("Auto Buy All " .. labelName)
    local list = ShopList[labelName]
    if list then
        for _, item in ipairs(list) do
            buyItem(item)
            task.wait(0.2) -- optional delay
        end
    else
        warn("No list found for " .. labelName)
    end
end)

local function buyItem(itemName)
    local shopRemote = game:GetService("ReplicatedStorage"):FindFirstChild("ShopRemote") -- adjust if needed
    if shopRemote then
        shopRemote:FireServer(itemName)
    else
        warn("ShopRemote not found")
    end
end

createAutoBuySection(automationContainer, "Seeds", 40)
createAutoBuySection(automationContainer, "Gears", 100)
createAutoBuySection(automationContainer, "Eggs", 160)

espDropdownBtn.MouseButton1Click:Connect(function()
    espContainer.Visible = true
    automationContainer.Visible = false
    espDropdownBtn.BackgroundColor3 = Color3.fromRGB(120, 120, 0)
    automationDropdownBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
end)
automationDropdownBtn.MouseButton1Click:Connect(function()
    espContainer.Visible = false
    automationContainer.Visible = true
    automationDropdownBtn.BackgroundColor3 = Color3.fromRGB(120, 120, 0)
    espDropdownBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
end)

espContainer.Visible = true
automationContainer.Visible = false
espDropdownBtn.BackgroundColor3 = Color3.fromRGB(120, 120, 0)
automationDropdownBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)

-- ========== PET TAB ==========
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