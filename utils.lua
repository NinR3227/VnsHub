-- utils.lua
-- Shared UI helpers and theme for Germa66

local utils = {}

utils.Theme = {
    Background = Color3.fromRGB(16, 16, 16),
    Panel       = Color3.fromRGB(22, 22, 22),
    Sidebar     = Color3.fromRGB(18, 18, 18),
    Header      = Color3.fromRGB(10, 10, 10),
    Text        = Color3.fromRGB(235, 235, 235),
    Muted       = Color3.fromRGB(170, 170, 170),
    Accent      = Color3.fromRGB(255, 213, 0),
    AccentText  = Color3.fromRGB(10, 10, 10),
}

function utils.roundify(instance, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = instance
    return c
end

function utils.listLayout(parent, padding, fillDir, align)
    local l = Instance.new("UIListLayout")
    l.Padding = UDim.new(0, padding or 6)
    l.FillDirection = fillDir or Enum.FillDirection.Vertical
    l.HorizontalAlignment = align or Enum.HorizontalAlignment.Center
    l.SortOrder = Enum.SortOrder.LayoutOrder
    l.Parent = parent
    return l
end

function utils.pad(parent, p)
    local ui = Instance.new("UIPadding")
    p = p or 8
    ui.PaddingTop = UDim.new(0, p)
    ui.PaddingBottom = UDim.new(0, p)
    ui.PaddingLeft = UDim.new(0, p)
    ui.PaddingRight = UDim.new(0, p)
    ui.Parent = parent
    return ui
end

function utils.makeDraggable(dragHandle, root)
    local UIS = game:GetService("UserInputService")
    local dragging, dragStart, startPos = false, nil, nil

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = root.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            root.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

function utils.createText(parent, text, size, color, bold, align)
    local t = Instance.new("TextLabel")
    t.BackgroundTransparency = 1
    t.Size = UDim2.new(1, 0, 0, (size or 16) + 10)
    t.Text = text
    t.TextColor3 = color or utils.Theme.Text
    t.Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham
    t.TextSize = size or 16
    t.TextXAlignment = align or Enum.TextXAlignment.Left
    t.Parent = parent
    return t
end

function utils.createButton(parent, label, onClick, opts)
    opts = opts or {}
    local theme = utils.Theme
    local b = Instance.new("TextButton")
    b.AutoButtonColor = false
    b.Size = opts.size or UDim2.new(1, 0, 0, 32)
    b.BackgroundColor3 = opts.bg or theme.Panel
    b.Text = label
    b.TextColor3 = opts.textColor or theme.Text
    b.Font = opts.bold and Enum.Font.GothamBold or Enum.Font.Gotham
    b.TextSize = opts.textSize or 16
    b.Parent = parent
    utils.roundify(b, opts.radius or 8)
    b.MouseEnter:Connect(function()
        if not b:GetAttribute("Active") then
            b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end
    end)
    b.MouseLeave:Connect(function()
        if not b:GetAttribute("Active") then
            b.BackgroundColor3 = opts.bg or theme.Panel
        end
    end)
    if onClick then b.MouseButton1Click:Connect(onClick) end
    return b
end

function utils.setActiveButton(btn, active)
    local theme = utils.Theme
    btn:SetAttribute("Active", active and true or false)
    if active then
        btn.BackgroundColor3 = theme.Accent
        btn.TextColor3 = theme.AccentText
        btn.Font = Enum.Font.GothamBold
    else
        btn.BackgroundColor3 = theme.Panel
        btn.TextColor3 = theme.Text
        btn.Font = Enum.Font.Gotham
    end
end

-- Collapsible section: header + content
function utils.createSection(parent, title)
    local theme = utils.Theme

    local section = Instance.new("Frame")
    section.BackgroundColor3 = theme.Panel
    section.Size = UDim2.new(1, 0, 0, 44)
    section.Parent = parent
    utils.roundify(section, 8)

    local header = Instance.new("TextButton")
    header.BackgroundTransparency = 1
    header.AutoButtonColor = false
    header.Size = UDim2.new(1, -10, 0, 44)
    header.Position = UDim2.new(0, 5, 0, 0)
    header.Text = "▸  " .. title
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.Font = Enum.Font.GothamBold
    header.TextSize = 16
    header.TextColor3 = theme.Text
    header.Parent = section

    local content = Instance.new("Frame")
    content.BackgroundTransparency = 1
    content.Visible = false
    content.Size = UDim2.new(1, -10, 0, 0)
    content.Position = UDim2.new(0, 5, 0, 44)
    content.Parent = section

    local contentLayout = utils.listLayout(content, 6)

    local function resize()
        if content.Visible then
            section.Size = UDim2.new(1, 0, 0, 44 + contentLayout.AbsoluteContentSize.Y)
            content.Size = UDim2.new(1, -10, 0, contentLayout.AbsoluteContentSize.Y)
        else
            section.Size = UDim2.new(1, 0, 0, 44)
            content.Size = UDim2.new(1, -10, 0, 0)
        end
    end

    contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(resize)

    header.MouseButton1Click:Connect(function()
        content.Visible = not content.Visible
        header.Text = (content.Visible and "▾  " or "▸  ") .. title
        resize()
    end)

    return section, content, resize
end

-- Dropdown with expandable list of options
function utils.createDropdown(parent, labelText, options, onSelect)
    options = options or {}
    local theme = utils.Theme

    local holder = Instance.new("Frame")
    holder.BackgroundColor3 = theme.Panel
    holder.Size = UDim2.new(1, 0, 0, 36)
    holder.Parent = parent
    utils.roundify(holder, 8)

    local button = Instance.new("TextButton")
    button.AutoButtonColor = false
    button.BackgroundTransparency = 1
    button.Size = UDim2.new(1, -10, 1, 0)
    button.Position = UDim2.new(0, 5, 0, 0)
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Text = labelText .. "  ▾"
    button.Font = Enum.Font.Gotham
    button.TextSize = 16
    button.TextColor3 = theme.Text
    button.Parent = holder

    local list = Instance.new("Frame")
    list.BackgroundColor3 = theme.Panel
    list.Visible = false
    list.Size = UDim2.new(1, 0, 0, 0)
    list.Parent = parent
    utils.roundify(list, 8)
    utils.pad(list, 4)

    local scroll = Instance.new("ScrollingFrame")
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.ScrollBarThickness = 4
    scroll.Parent = list

    local scrollLayout = utils.listLayout(scroll, 4)

    local function refreshHeight()
        local height = math.min(160, scrollLayout.AbsoluteContentSize.Y)
        list.Size = UDim2.new(1, 0, 0, (list.Visible and height) or 0)
        scroll.CanvasSize = UDim2.new(0, 0, 0, scrollLayout.AbsoluteContentSize.Y)
    end

    local function addItem(opt)
        local itemBtn = utils.createButton(scroll, tostring(opt), function()
            button.Text = tostring(opt) .. "  ▾"
            list.Visible = false
            refreshHeight()
            if onSelect then onSelect(opt) end
        end, { size = UDim2.new(1, 0, 0, 28) })
        itemBtn.TextXAlignment = Enum.TextXAlignment.Left
        itemBtn.TextSize = 14
    end

    for _, opt in ipairs(options) do
        addItem(opt)
    end

    scrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(refreshHeight)

    button.MouseButton1Click:Connect(function()
        list.Visible = not list.Visible
        refreshHeight()
    end)

    return {
        holder = holder,
        setOptions = function(newOptions)
            for _, c in ipairs(scroll:GetChildren()) do
                if c:IsA("TextButton") then c:Destroy() end
            end
            for _, opt in ipairs(newOptions or {}) do
                addItem(opt)
            end
            refreshHeight()
        end,
        setLabel = function(txt)
            button.Text = txt .. "  ▾"
        end,
        getButton = function() return button end
    }
end

return utils