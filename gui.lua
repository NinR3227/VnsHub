-- gui.lua
-- Base window + header + sidebar/content for Germa66

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Gui = {}
local utils, theme

local state = {
    screenGui = nil,
    window = nil,
    header = nil,
    body = nil,
    sidebar = nil,
    content = nil,
    panels = {},
    menuButtons = {},
    minimized = false,
}

local function createHeader()
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.BackgroundColor3 = theme.Header
    header.Size = UDim2.new(1, 0, 0, 44)
    header.Parent = state.window

    -- Left: Minimize
    local btnMin = Instance.new("TextButton")
    btnMin.Name = "Minimize"
    btnMin.AutoButtonColor = false
    btnMin.BackgroundTransparency = 1
    btnMin.Size = UDim2.new(0, 44, 1, 0)
    btnMin.Text = "–"
    btnMin.Font = Enum.Font.GothamBold
    btnMin.TextSize = 20
    btnMin.TextColor3 = theme.Text
    btnMin.Parent = header

    -- Center: Title
    local title = Instance.new("TextLabel")
    title.BackgroundTransparency = 1
    title.AnchorPoint = Vector2.new(0.5, 0.5)
    title.Position = UDim2.new(0.5, 0, 0.5, 0)
    title.Size = UDim2.new(0, 240, 1, -8)
    title.Text = "Germa66"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.TextColor3 = theme.Accent
    title.Parent = header

    -- Right: Close
    local btnClose = Instance.new("TextButton")
    btnClose.Name = "Close"
    btnClose.AutoButtonColor = false
    btnClose.BackgroundTransparency = 1
    btnClose.Size = UDim2.new(0, 44, 1, 0)
    btnClose.Position = UDim2.new(1, -44, 0, 0)
    btnClose.Text = "×"
    btnClose.Font = Enum.Font.GothamBold
    btnClose.TextSize = 20
    btnClose.TextColor3 = theme.Text
    btnClose.Parent = header

    -- Interactions
    btnMin.MouseButton1Click:Connect(function()
        state.minimized = not state.minimized
        state.body.Visible = not state.minimized
    end)
    btnClose.MouseButton1Click:Connect(function()
        if state.screenGui then state.screenGui:Destroy() end
    end)

    utils.makeDraggable(header, state.window)
    return header
end

local function createBody()
    local body = Instance.new("Frame")
    body.Name = "Body"
    body.BackgroundColor3 = theme.Background
    body.Size = UDim2.new(1, 0, 1, -44)
    body.Position = UDim2.new(0, 0, 0, 44)
    body.Parent = state.window

    -- Sidebar (1/3 from left)
    local sidebarWrap = Instance.new("Frame")
    sidebarWrap.BackgroundTransparency = 1
    sidebarWrap.Size = UDim2.new(0.33, -8, 1, -8)
    sidebarWrap.Position = UDim2.new(0, 8, 0, 4)
    sidebarWrap.Parent = body

    local sidebar = Instance.new("Frame")
    sidebar.Name = "Sidebar"
    sidebar.BackgroundColor3 = theme.Sidebar
    sidebar.Size = UDim2.new(1, 0, 1, 0)
    sidebar.Parent = sidebarWrap
    utils.roundify(sidebar, 10)
    utils.pad(sidebar, 8)

    local menu = Instance.new("Frame")
    menu.BackgroundTransparency = 1
    menu.Size = UDim2.new(1, 0, 1, 0)
    menu.Parent = sidebar
    utils.listLayout(menu, 8)

    -- Content (2/3)
    local content = Instance.new("Frame")
    content.Name = "Content"
    content.BackgroundColor3 = theme.Panel
    content.Size = UDim2.new(0.67, -16, 1, -8)
    content.Position = UDim2.new(0.33, 8, 0, 4)
    content.Parent = body
    utils.roundify(content, 10)
    utils.pad(content, 10)

    state.body = body
    state.sidebar = menu
    state.content = content
end

function Gui.init(U)
    utils = U
    theme = utils.Theme

    local screen = Instance.new("ScreenGui")
    screen.Name = "Germa66UI"
    screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screen.ResetOnSpawn = false
    screen.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    state.screenGui = screen

    local window = Instance.new("Frame")
    window.Name = "Window"
    window.BackgroundColor3 = theme.Background
    window.BorderSizePixel = 0
    window.Size = UDim2.new(0, 720, 0, 460)
    window.Position = UDim2.new(0.5, -360, 0.5, -230)
    window.Parent = screen
    utils.roundify(window, 12)

    state.window = window
    state.header = createHeader()
    createBody()
end

function Gui.createPanel(name)
    local panel = Instance.new("Frame")
    panel.Name = name
    panel.BackgroundTransparency = 1
    panel.Size = UDim2.new(1, 0, 1, 0)
    panel.Visible = false
    panel.Parent = state.content
    utils.listLayout(panel, 8)
    state.panels[name] = panel
    return panel
end

function Gui.showPanel(name)
    for key, frame in pairs(state.panels) do
        frame.Visible = (key == name)
    end
    for _, info in ipairs(state.menuButtons) do
        utils.setActiveButton(info.button, info.name == name and not info.disabled)
    end
end

function Gui.addMenuItem(opts)
    local label = opts.label or "Menu"
    local name = opts.name or label
    local disabled = opts.disabled and true or false

    local btn = utils.createButton(state.sidebar, label, function()
        if disabled then return end
        if opts.onClick then opts.onClick() end
        if state.panels[name] then Gui.showPanel(name) end
        for _, info in ipairs(state.menuButtons) do
            utils.setActiveButton(info.button, info.button == btn and not info.disabled)
        end
    end, { size = UDim2.new(1, 0, 0, 36) })
    btn.TextXAlignment = Enum.TextXAlignment.Left
    if disabled then btn.TextColor3 = theme.Muted end

    table.insert(state.menuButtons, { button = btn, name = name, disabled = disabled })
    return btn
end

function Gui.getRoot()
    return state
end

return Gui