-- automation.lua
-- Automation Panel with "Auto Buy" section for Seeds / Gears / Eggs

local Utils

local function createCategory(parent, categoryName, items, callbacks)
    local theme = Utils.Theme

    local block = Instance.new("Frame")
    block.BackgroundColor3 = theme.Background
    block.Size = UDim2.new(1, 0, 0, 36)
    block.Parent = parent
    Utils.roundify(block, 8)
    Utils.pad(block, 8)
    Utils.listLayout(block, 8)

    local selected

    local dd = Utils.createDropdown(block, "Select " .. categoryName, items, function(choice)
        selected = choice
    end)

    local row = Instance.new("Frame")
    row.BackgroundTransparency = 1
    row.Size = UDim2.new(1, 0, 0, 36)
    row.Parent = block

    local grid = Instance.new("UIGridLayout")
    grid.CellPadding = UDim2.new(0, 8, 0, 0)
    grid.CellSize = UDim2.new(0.5, -4, 1, 0)
    grid.FillDirectionMaxCells = 2
    grid.SortOrder = Enum.SortOrder.LayoutOrder
    grid.Parent = row

    Utils.createButton(row, "Buy " .. categoryName, function()
        if selected and callbacks.buyOne then callbacks.buyOne(selected) end
    end, { bold = true })

    Utils.createButton(row, "Buy All " .. categoryName, function()
        if callbacks.buyAll then callbacks.buyAll() end
    end, {})

    return {
        setItems = function(newItems) dd.setOptions(newItems) end,
        setSelected = function(label) dd.setLabel(label) end,
        getSelected = function() return selected end,
    }
end

local function buildAutomationPanel(Gui, U)
    Utils = U
    local panel = Gui.createPanel("Automation Panel")

    local section, content = Utils.createSection(panel, "Auto Buy")

    -- Sample item lists (replace with real lists later)
    local seeds = { "Wheat", "Corn", "Carrot", "Potato", "Tomato" }
    local gears = { "Wrench", "Hammer", "Pulley", "Gear A", "Gear B" }
    local eggs  = { "Red Egg", "Blue Egg", "Golden Egg", "Mystic Egg" }

    local function notify(msg) print("[Germa66] " .. msg) end

    createCategory(content, "Seeds", seeds, {
        buyOne = function(item) notify("Buying Seed: " .. tostring(item)) end,
        buyAll = function() notify("Buying all Seeds in stock") end
    })

    createCategory(content, "Gears", gears, {
        buyOne = function(item) notify("Buying Gear: " .. tostring(item)) end,
        buyAll = function() notify("Buying all Gears in stock") end
    })

    createCategory(content, "Eggs", eggs, {
        buyOne = function(item) notify("Buying Egg: " .. tostring(item)) end,
        buyAll = function() notify("Buying all Eggs in stock") end
    })

    -- Expand section by default
    task.defer(function()
        -- trigger header click
        for _, child in ipairs(panel:GetChildren()) do
            local headerBtn = child:FindFirstChildWhichIsA("TextButton")
            if headerBtn then
                headerBtn:Activate()
                break
            end
        end
    end)

    return panel
end

return buildAutomationPanel