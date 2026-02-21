--[[
    ███╗   ██╗███████╗██╗  ██╗██╗   ██╗███████╗    ██╗   ██╗██╗
    ████╗  ██║██╔════╝╚██╗██╔╝██║   ██║██╔════╝    ██║   ██║██║
    ██╔██╗ ██║█████╗   ╚███╔╝ ██║   ██║███████╗    ██║   ██║██║
    ██║╚██╗██║██╔══╝   ██╔██╗ ██║   ██║╚════██║    ██║   ██║██║
    ██║ ╚████║███████╗██╔╝ ██╗╚██████╔╝███████║    ╚██████╔╝██║
    ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝     ╚═════╝ ╚═╝
    
    NexusUI v1.0.0 — A modern, feature-rich Roblox UI Library
    
    USAGE:
        local NexusUI = require(game.ReplicatedStorage.NexusUI)
        local Window = NexusUI:CreateWindow({
            Title = "My Game",
            SubTitle = "v1.0",
            Theme = "Dark"
        })
        
        local Tab = Window:AddTab("Main", "rbxassetid://7733715400")
        
        Tab:AddButton({ Label = "Click Me!", Callback = function() print("clicked") end })
        Tab:AddToggle({ Label = "Enable Feature", Default = false, Callback = function(v) print(v) end })
        Tab:AddSlider({ Label = "Speed", Min = 0, Max = 100, Default = 50, Callback = function(v) print(v) end })
        Tab:AddDropdown({ Label = "Select Option", Options = {"One","Two","Three"}, Callback = function(v) print(v) end })
        Tab:AddInput({ Label = "Enter Name", Placeholder = "Type here...", Callback = function(v) print(v) end })
        Tab:AddColorPicker({ Label = "Pick Color", Default = Color3.fromRGB(255,100,100), Callback = function(c) print(c) end })
        Tab:AddKeybind({ Label = "Toggle Key", Default = Enum.KeyCode.RightShift, Callback = function(k) print(k) end })
        Tab:AddSection("Section Header")
        Tab:AddLabel("This is a label")
]]

local NexusUI = {}
NexusUI.__index = NexusUI

-- ─────────────────────────────────────────────
-- Services
-- ─────────────────────────────────────────────
local Players        = game:GetService("Players")
local TweenService   = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService     = game:GetService("RunService")
local HttpService    = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- ─────────────────────────────────────────────
-- Themes
-- ─────────────────────────────────────────────
local Themes = {
    Dark = {
        Background     = Color3.fromRGB(15, 15, 20),
        Surface        = Color3.fromRGB(22, 22, 30),
        SurfaceHover   = Color3.fromRGB(30, 30, 42),
        Border         = Color3.fromRGB(45, 45, 65),
        Accent         = Color3.fromRGB(100, 140, 255),
        AccentHover    = Color3.fromRGB(130, 165, 255),
        AccentDim      = Color3.fromRGB(50, 75, 160),
        Text           = Color3.fromRGB(230, 230, 240),
        TextDim        = Color3.fromRGB(130, 130, 155),
        TextDisabled   = Color3.fromRGB(70, 70, 90),
        Success        = Color3.fromRGB(80, 200, 120),
        Warning        = Color3.fromRGB(255, 190, 60),
        Error          = Color3.fromRGB(255, 80, 80),
        TabBar         = Color3.fromRGB(18, 18, 25),
        TabActive      = Color3.fromRGB(100, 140, 255),
        TabInactive    = Color3.fromRGB(60, 60, 80),
        ScrollBar      = Color3.fromRGB(60, 60, 85),
        InputBg        = Color3.fromRGB(28, 28, 38),
        SliderFill     = Color3.fromRGB(100, 140, 255),
        ToggleOff      = Color3.fromRGB(55, 55, 75),
        ToggleOn       = Color3.fromRGB(100, 140, 255),
    },
    Light = {
        Background     = Color3.fromRGB(245, 245, 252),
        Surface        = Color3.fromRGB(255, 255, 255),
        SurfaceHover   = Color3.fromRGB(238, 238, 248),
        Border         = Color3.fromRGB(210, 210, 228),
        Accent         = Color3.fromRGB(80, 110, 240),
        AccentHover    = Color3.fromRGB(60, 90, 210),
        AccentDim      = Color3.fromRGB(180, 195, 255),
        Text           = Color3.fromRGB(20, 20, 35),
        TextDim        = Color3.fromRGB(100, 100, 130),
        TextDisabled   = Color3.fromRGB(170, 170, 195),
        Success        = Color3.fromRGB(40, 170, 90),
        Warning        = Color3.fromRGB(210, 140, 20),
        Error          = Color3.fromRGB(210, 50, 50),
        TabBar         = Color3.fromRGB(235, 235, 245),
        TabActive      = Color3.fromRGB(80, 110, 240),
        TabInactive    = Color3.fromRGB(160, 160, 185),
        ScrollBar      = Color3.fromRGB(180, 180, 210),
        InputBg        = Color3.fromRGB(248, 248, 255),
        SliderFill     = Color3.fromRGB(80, 110, 240),
        ToggleOff      = Color3.fromRGB(190, 190, 215),
        ToggleOn       = Color3.fromRGB(80, 110, 240),
    },
    Neon = {
        Background     = Color3.fromRGB(5, 5, 12),
        Surface        = Color3.fromRGB(10, 10, 20),
        SurfaceHover   = Color3.fromRGB(18, 18, 35),
        Border         = Color3.fromRGB(0, 200, 180),
        Accent         = Color3.fromRGB(0, 255, 200),
        AccentHover    = Color3.fromRGB(80, 255, 220),
        AccentDim      = Color3.fromRGB(0, 100, 80),
        Text           = Color3.fromRGB(200, 255, 245),
        TextDim        = Color3.fromRGB(100, 180, 165),
        TextDisabled   = Color3.fromRGB(50, 90, 80),
        Success        = Color3.fromRGB(0, 255, 120),
        Warning        = Color3.fromRGB(255, 230, 0),
        Error          = Color3.fromRGB(255, 50, 100),
        TabBar         = Color3.fromRGB(8, 8, 18),
        TabActive      = Color3.fromRGB(0, 255, 200),
        TabInactive    = Color3.fromRGB(0, 90, 75),
        ScrollBar      = Color3.fromRGB(0, 120, 100),
        InputBg        = Color3.fromRGB(12, 12, 22),
        SliderFill     = Color3.fromRGB(0, 255, 200),
        ToggleOff      = Color3.fromRGB(30, 60, 55),
        ToggleOn       = Color3.fromRGB(0, 255, 200),
    },
    Rose = {
        Background     = Color3.fromRGB(18, 10, 14),
        Surface        = Color3.fromRGB(28, 15, 22),
        SurfaceHover   = Color3.fromRGB(40, 22, 32),
        Border         = Color3.fromRGB(180, 60, 110),
        Accent         = Color3.fromRGB(255, 90, 145),
        AccentHover    = Color3.fromRGB(255, 130, 175),
        AccentDim      = Color3.fromRGB(120, 30, 65),
        Text           = Color3.fromRGB(255, 220, 235),
        TextDim        = Color3.fromRGB(180, 120, 150),
        TextDisabled   = Color3.fromRGB(90, 50, 70),
        Success        = Color3.fromRGB(100, 220, 140),
        Warning        = Color3.fromRGB(255, 200, 80),
        Error          = Color3.fromRGB(255, 80, 80),
        TabBar         = Color3.fromRGB(20, 12, 17),
        TabActive      = Color3.fromRGB(255, 90, 145),
        TabInactive    = Color3.fromRGB(100, 40, 70),
        ScrollBar      = Color3.fromRGB(120, 50, 80),
        InputBg        = Color3.fromRGB(32, 18, 26),
        SliderFill     = Color3.fromRGB(255, 90, 145),
        ToggleOff      = Color3.fromRGB(80, 35, 55),
        ToggleOn       = Color3.fromRGB(255, 90, 145),
    },
}

-- ─────────────────────────────────────────────
-- Utility Functions
-- ─────────────────────────────────────────────
local function Tween(obj, props, duration, style, direction)
    local info = TweenInfo.new(
        duration or 0.2,
        style or Enum.EasingStyle.Quart,
        direction or Enum.EasingDirection.Out
    )
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

local function Lerp(a, b, t)
    return a + (b - a) * t
end

local function Create(class, props, children)
    local inst = Instance.new(class)
    for k, v in pairs(props or {}) do
        if k ~= "Parent" then
            inst[k] = v
        end
    end
    for _, child in ipairs(children or {}) do
        child.Parent = inst
    end
    if props and props.Parent then
        inst.Parent = props.Parent
    end
    return inst
end

local function MakeDraggable(frame, handle)
    handle = handle or frame
    local dragging, dragInput, dragStart, startPos

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

local function HoverEffect(button, theme, normalColor, hoverColor)
    button.MouseEnter:Connect(function()
        Tween(button, { BackgroundColor3 = hoverColor or theme.SurfaceHover }, 0.15)
    end)
    button.MouseLeave:Connect(function()
        Tween(button, { BackgroundColor3 = normalColor or theme.Surface }, 0.15)
    end)
end

-- ─────────────────────────────────────────────
-- Window Constructor
-- ─────────────────────────────────────────────
function NexusUI:CreateWindow(config)
    config = config or {}
    local Title       = config.Title or "NexusUI"
    local SubTitle    = config.SubTitle or ""
    local ThemeName   = config.Theme or "Dark"
    local Size        = config.Size or UDim2.new(0, 560, 0, 420)
    local Position    = config.Position or UDim2.new(0.5, -280, 0.5, -210)
    local MinimizeKey = config.MinimizeKey or Enum.KeyCode.RightControl

    local theme = Themes[ThemeName] or Themes.Dark
    local tabs = {}
    local activeTab = nil
    local minimized = false
    local windowOpen = true

    -- Screen GUI
    local ScreenGui = Create("ScreenGui", {
        Name = "NexusUI_" .. Title,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 100,
        Parent = LocalPlayer:WaitForChild("PlayerGui"),
    })

    -- Main Frame
    local MainFrame = Create("Frame", {
        Name = "MainFrame",
        Size = Size,
        Position = Position,
        BackgroundColor3 = theme.Background,
        BorderSizePixel = 0,
        Parent = ScreenGui,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = MainFrame })
    Create("UIStroke", {
        Color = theme.Border,
        Thickness = 1,
        Transparency = 0.4,
        Parent = MainFrame,
    })

    -- Drop shadow (using a slightly larger ImageLabel behind)
    local Shadow = Create("ImageLabel", {
        Name = "Shadow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 6),
        Size = UDim2.new(1, 30, 1, 30),
        ZIndex = 0,
        Image = "rbxassetid://5554236805",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = 0.65,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(23, 23, 277, 277),
        Parent = MainFrame,
    })

    -- Title Bar
    local TitleBar = Create("Frame", {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 48),
        BackgroundColor3 = theme.Surface,
        BorderSizePixel = 0,
        ZIndex = 2,
        Parent = MainFrame,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = TitleBar })
    -- Bottom fill to flatten lower corners
    Create("Frame", {
        Size = UDim2.new(1, 0, 0.5, 0),
        Position = UDim2.new(0, 0, 0.5, 0),
        BackgroundColor3 = theme.Surface,
        BorderSizePixel = 0,
        ZIndex = 1,
        Parent = TitleBar,
    })

    -- Accent bar
    Create("Frame", {
        Name = "AccentBar",
        Size = UDim2.new(0, 3, 0, 24),
        Position = UDim2.new(0, 14, 0.5, -12),
        BackgroundColor3 = theme.Accent,
        BorderSizePixel = 0,
        ZIndex = 3,
        Parent = TitleBar,
    })
    Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = TitleBar:FindFirstChild("AccentBar") })

    local TitleLabel = Create("TextLabel", {
        Name = "Title",
        Size = UDim2.new(0, 300, 1, 0),
        Position = UDim2.new(0, 26, 0, 0),
        BackgroundTransparency = 1,
        Text = Title,
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        TextColor3 = theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 3,
        Parent = TitleBar,
    })

    if SubTitle ~= "" then
        local SubLabel = Create("TextLabel", {
            Size = UDim2.new(0, 200, 1, 0),
            Position = UDim2.new(0, 26 + TitleLabel.TextBounds.X + 8, 0, 0),
            BackgroundTransparency = 1,
            Text = "— " .. SubTitle,
            Font = Enum.Font.Gotham,
            TextSize = 12,
            TextColor3 = theme.TextDim,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 3,
            Parent = TitleBar,
        })
    end

    -- Window controls
    local function MakeControlBtn(icon, color, xOffset, callback)
        local btn = Create("TextButton", {
            Size = UDim2.new(0, 14, 0, 14),
            Position = UDim2.new(1, xOffset, 0.5, -7),
            BackgroundColor3 = color,
            BorderSizePixel = 0,
            Text = "",
            ZIndex = 4,
            Parent = TitleBar,
        })
        Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = btn })
        btn.MouseButton1Click:Connect(callback)
        btn.MouseEnter:Connect(function() Tween(btn, {Size = UDim2.new(0,16,0,16), Position = UDim2.new(1,xOffset-1,0.5,-8)}, 0.1) end)
        btn.MouseLeave:Connect(function() Tween(btn, {Size = UDim2.new(0,14,0,14), Position = UDim2.new(1,xOffset,0.5,-7)}, 0.1) end)
        return btn
    end

    -- Close button
    MakeControlBtn("✕", Color3.fromRGB(255, 80, 80), -18, function()
        windowOpen = false
        Tween(MainFrame, { Size = UDim2.new(0, Size.X.Offset, 0, 0), Position = UDim2.new(Position.X.Scale, Position.X.Offset, Position.Y.Scale, Position.Y.Offset + Size.Y.Offset/2) }, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.delay(0.35, function() ScreenGui:Destroy() end)
    end)

    -- Minimize button
    local ContentFrame
    MakeControlBtn("─", Color3.fromRGB(255, 190, 60), -38, function()
        minimized = not minimized
        if minimized then
            Tween(MainFrame, { Size = UDim2.new(0, Size.X.Offset, 0, 48) }, 0.25, Enum.EasingStyle.Quart)
        else
            Tween(MainFrame, { Size = Size }, 0.25, Enum.EasingStyle.Quart)
        end
    end)

    MakeDraggable(MainFrame, TitleBar)

    -- Tab Bar
    local TabBar = Create("Frame", {
        Name = "TabBar",
        Size = UDim2.new(0, 140, 1, -48),
        Position = UDim2.new(0, 0, 0, 48),
        BackgroundColor3 = theme.TabBar,
        BorderSizePixel = 0,
        ZIndex = 2,
        Parent = MainFrame,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = TabBar })
    -- Fill top-right corners
    Create("Frame", {
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        BackgroundColor3 = theme.TabBar,
        BorderSizePixel = 0,
        ZIndex = 1,
        Parent = TabBar,
    })
    Create("Frame", {
        Size = UDim2.new(1, 0, 0, 10),
        BackgroundColor3 = theme.TabBar,
        BorderSizePixel = 0,
        ZIndex = 1,
        Parent = TabBar,
    })

    local TabList = Create("ScrollingFrame", {
        Name = "TabList",
        Size = UDim2.new(1, 0, 1, -10),
        Position = UDim2.new(0, 0, 0, 10),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = theme.ScrollBar,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ZIndex = 3,
        Parent = TabBar,
    })
    Create("UIListLayout", {
        Padding = UDim.new(0, 4),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Parent = TabList,
    })
    Create("UIPadding", {
        PaddingTop = UDim.new(0, 8),
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8),
        Parent = TabList,
    })

    -- Content area
    ContentFrame = Create("Frame", {
        Name = "ContentFrame",
        Size = UDim2.new(1, -148, 1, -56),
        Position = UDim2.new(0, 144, 0, 52),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 2,
        Parent = MainFrame,
    })

    -- Animate in
    MainFrame.Size = UDim2.new(0, Size.X.Offset, 0, 0)
    Tween(MainFrame, { Size = Size }, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

    -- Toggle visibility hotkey
    UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == MinimizeKey then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)

    -- ─────────────────────────────────────────
    -- Window Object
    -- ─────────────────────────────────────────
    local WindowObj = {}

    function WindowObj:AddTab(name, icon)
        -- Tab button in sidebar
        local tabBtn = Create("TextButton", {
            Name = "Tab_" .. name,
            Size = UDim2.new(1, 0, 0, 36),
            BackgroundColor3 = theme.Surface,
            BorderSizePixel = 0,
            Text = "",
            ZIndex = 4,
            Parent = TabList,
        })
        Create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = tabBtn })

        local activeIndicator = Create("Frame", {
            Name = "Indicator",
            Size = UDim2.new(0, 3, 0.6, 0),
            Position = UDim2.new(0, 0, 0.2, 0),
            BackgroundColor3 = theme.Accent,
            BorderSizePixel = 0,
            Transparency = 1,
            ZIndex = 5,
            Parent = tabBtn,
        })
        Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = activeIndicator })

        local tabIcon = Create("ImageLabel", {
            Size = UDim2.new(0, 18, 0, 18),
            Position = UDim2.new(0, 10, 0.5, -9),
            BackgroundTransparency = 1,
            Image = icon or "",
            ImageColor3 = theme.TabInactive,
            ZIndex = 5,
            Parent = tabBtn,
        })

        local tabLabel = Create("TextLabel", {
            Size = UDim2.new(1, -36, 1, 0),
            Position = UDim2.new(0, icon and 32 or 12, 0, 0),
            BackgroundTransparency = 1,
            Text = name,
            Font = Enum.Font.Gotham,
            TextSize = 13,
            TextColor3 = theme.TabInactive,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 5,
            Parent = tabBtn,
        })

        -- Tab content page
        local tabPage = Create("ScrollingFrame", {
            Name = "Page_" .. name,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = theme.ScrollBar,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            ZIndex = 3,
            Parent = ContentFrame,
        })
        local pageLayout = Create("UIListLayout", {
            Padding = UDim.new(0, 6),
            Parent = tabPage,
        })
        Create("UIPadding", {
            PaddingTop = UDim.new(0, 4),
            PaddingRight = UDim.new(0, 6),
            Parent = tabPage,
        })

        -- Auto-update canvas
        pageLayout.Changed:Connect(function()
            tabPage.CanvasSize = UDim2.new(0, 0, 0, pageLayout.AbsoluteContentSize.Y + 10)
        end)

        -- Update tab list canvas
        local listLayout = TabList:FindFirstChildOfClass("UIListLayout")
        if listLayout then
            TabList.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 20)
        end

        local function ActivateTab()
            for _, t in ipairs(tabs) do
                t.page.Visible = false
                Tween(t.label, { TextColor3 = theme.TabInactive }, 0.15)
                Tween(t.icon, { ImageColor3 = theme.TabInactive }, 0.15)
                Tween(t.btn, { BackgroundColor3 = theme.Surface }, 0.15)
                t.indicator.Visible = false
            end
            tabPage.Visible = true
            activeTab = name
            Tween(tabLabel, { TextColor3 = theme.Text }, 0.15)
            Tween(tabIcon, { ImageColor3 = theme.Accent }, 0.15)
            Tween(tabBtn, { BackgroundColor3 = theme.SurfaceHover }, 0.15)
            activeIndicator.Visible = true
            tabLabel.Font = Enum.Font.GothamBold
        end

        tabBtn.MouseButton1Click:Connect(ActivateTab)
        tabBtn.MouseEnter:Connect(function()
            if activeTab ~= name then
                Tween(tabBtn, { BackgroundColor3 = theme.SurfaceHover }, 0.1)
            end
        end)
        tabBtn.MouseLeave:Connect(function()
            if activeTab ~= name then
                Tween(tabBtn, { BackgroundColor3 = theme.Surface }, 0.1)
            end
        end)

        local tabEntry = {
            name = name,
            page = tabPage,
            btn = tabBtn,
            label = tabLabel,
            icon = tabIcon,
            indicator = activeIndicator,
        }
        table.insert(tabs, tabEntry)

        if #tabs == 1 then ActivateTab() end

        -- ─────────────────────────────────────
        -- Component Helpers
        -- ─────────────────────────────────────
        local function MakeItem(height)
            local item = Create("Frame", {
                Size = UDim2.new(1, 0, 0, height or 42),
                BackgroundColor3 = theme.Surface,
                BorderSizePixel = 0,
                ZIndex = 4,
                Parent = tabPage,
            })
            Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = item })
            return item
        end

        local function MakeLabel(parent, text, font, size, color, xAlign, pos, sz)
            return Create("TextLabel", {
                Size = sz or UDim2.new(1, -16, 1, 0),
                Position = pos or UDim2.new(0, 12, 0, 0),
                BackgroundTransparency = 1,
                Text = text,
                Font = font or Enum.Font.Gotham,
                TextSize = size or 13,
                TextColor3 = color or theme.Text,
                TextXAlignment = xAlign or Enum.TextXAlignment.Left,
                ZIndex = 5,
                Parent = parent,
            })
        end

        -- ─────────────────────────────────────
        -- Tab API
        -- ─────────────────────────────────────
        local TabObj = {}

        -- SECTION
        function TabObj:AddSection(title)
            local s = Create("Frame", {
                Size = UDim2.new(1, 0, 0, 28),
                BackgroundTransparency = 1,
                ZIndex = 4,
                Parent = tabPage,
            })
            Create("TextLabel", {
                Size = UDim2.new(1, -12, 1, 0),
                Position = UDim2.new(0, 8, 0, 0),
                BackgroundTransparency = 1,
                Text = title:upper(),
                Font = Enum.Font.GothamBold,
                TextSize = 10,
                TextColor3 = theme.Accent,
                TextXAlignment = Enum.TextXAlignment.Left,
                LetterSpacing = 2,
                ZIndex = 5,
                Parent = s,
            })
            Create("Frame", {
                Size = UDim2.new(1, -12, 0, 1),
                Position = UDim2.new(0, 8, 1, -1),
                BackgroundColor3 = theme.Border,
                BorderSizePixel = 0,
                ZIndex = 4,
                Parent = s,
            })
        end

        -- LABEL
        function TabObj:AddLabel(text)
            local item = MakeItem(36)
            MakeLabel(item, text, Enum.Font.Gotham, 12, theme.TextDim)
        end

        -- BUTTON
        function TabObj:AddButton(config)
            config = config or {}
            local item = MakeItem(42)
            HoverEffect(item, theme)

            local icon = config.Icon and Create("ImageLabel", {
                Size = UDim2.new(0, 18, 0, 18),
                Position = UDim2.new(0, 12, 0.5, -9),
                BackgroundTransparency = 1,
                Image = config.Icon,
                ImageColor3 = theme.Accent,
                ZIndex = 5,
                Parent = item,
            }) or nil

            MakeLabel(item, config.Label or "Button",
                Enum.Font.Gotham, 13, theme.Text, Enum.TextXAlignment.Left,
                UDim2.new(0, icon and 38 or 12, 0, 0))

            -- Right arrow indicator
            Create("TextLabel", {
                Size = UDim2.new(0, 20, 1, 0),
                Position = UDim2.new(1, -28, 0, 0),
                BackgroundTransparency = 1,
                Text = "›",
                Font = Enum.Font.GothamBold,
                TextSize = 20,
                TextColor3 = theme.TextDim,
                ZIndex = 5,
                Parent = item,
            })

            local clickbtn = Create("TextButton", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 6,
                Parent = item,
            })
            clickbtn.MouseButton1Click:Connect(function()
                Tween(item, { BackgroundColor3 = theme.AccentDim }, 0.1)
                task.delay(0.1, function()
                    Tween(item, { BackgroundColor3 = theme.SurfaceHover }, 0.15)
                end)
                if config.Callback then config.Callback() end
            end)

            return { SetLabel = function(t) end }
        end

        -- TOGGLE
        function TabObj:AddToggle(config)
            config = config or {}
            local value = config.Default or false
            local item = MakeItem(42)
            HoverEffect(item, theme)

            MakeLabel(item, config.Label or "Toggle")

            local track = Create("Frame", {
                Size = UDim2.new(0, 40, 0, 22),
                Position = UDim2.new(1, -52, 0.5, -11),
                BackgroundColor3 = value and theme.ToggleOn or theme.ToggleOff,
                BorderSizePixel = 0,
                ZIndex = 5,
                Parent = item,
            })
            Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = track })

            local knob = Create("Frame", {
                Size = UDim2.new(0, 16, 0, 16),
                Position = UDim2.new(0, value and 20 or 3, 0.5, -8),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                ZIndex = 6,
                Parent = track,
            })
            Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = knob })

            local function SetValue(v, silent)
                value = v
                Tween(track, { BackgroundColor3 = v and theme.ToggleOn or theme.ToggleOff }, 0.2)
                Tween(knob, { Position = UDim2.new(0, v and 21 or 3, 0.5, -8) }, 0.2)
                if not silent and config.Callback then config.Callback(v) end
            end

            local clickbtn = Create("TextButton", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 7,
                Parent = item,
            })
            clickbtn.MouseButton1Click:Connect(function()
                SetValue(not value)
            end)

            return {
                SetValue = SetValue,
                GetValue = function() return value end,
            }
        end

        -- SLIDER
        function TabObj:AddSlider(config)
            config = config or {}
            local min = config.Min or 0
            local max = config.Max or 100
            local default = config.Default or min
            local value = default
            local decimals = config.Decimals or 0
            local item = MakeItem(58)
            HoverEffect(item, theme)

            MakeLabel(item, config.Label or "Slider",
                Enum.Font.Gotham, 13, theme.Text, nil,
                UDim2.new(0, 12, 0, 4), UDim2.new(1, -80, 0, 20))

            local valueLabel = Create("TextLabel", {
                Size = UDim2.new(0, 60, 0, 20),
                Position = UDim2.new(1, -68, 0, 4),
                BackgroundTransparency = 1,
                Text = tostring(value),
                Font = Enum.Font.GothamBold,
                TextSize = 13,
                TextColor3 = theme.Accent,
                TextXAlignment = Enum.TextXAlignment.Right,
                ZIndex = 5,
                Parent = item,
            })

            local track = Create("Frame", {
                Size = UDim2.new(1, -24, 0, 6),
                Position = UDim2.new(0, 12, 0, 34),
                BackgroundColor3 = theme.Border,
                BorderSizePixel = 0,
                ZIndex = 5,
                Parent = item,
            })
            Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = track })

            local fill = Create("Frame", {
                Size = UDim2.new((value - min) / (max - min), 0, 1, 0),
                BackgroundColor3 = theme.SliderFill,
                BorderSizePixel = 0,
                ZIndex = 6,
                Parent = track,
            })
            Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = fill })

            local knob = Create("Frame", {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Size = UDim2.new(0, 14, 0, 14),
                Position = UDim2.new((value - min) / (max - min), 0, 0.5, 0),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                ZIndex = 7,
                Parent = track,
            })
            Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = knob })
            Create("UIStroke", { Color = theme.Accent, Thickness = 2, Parent = knob })

            local dragging = false

            local function UpdateSlider(inputX)
                local trackPos = track.AbsolutePosition.X
                local trackSize = track.AbsoluteSize.X
                local rel = math.clamp((inputX - trackPos) / trackSize, 0, 1)
                local raw = min + (max - min) * rel
                local mult = 10 ^ decimals
                value = math.floor(raw * mult + 0.5) / mult
                valueLabel.Text = tostring(value)
                Tween(fill, { Size = UDim2.new(rel, 0, 1, 0) }, 0.05)
                Tween(knob, { Position = UDim2.new(rel, 0, 0.5, 0) }, 0.05)
                if config.Callback then config.Callback(value) end
            end

            track.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    UpdateSlider(input.Position.X)
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    UpdateSlider(input.Position.X)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)

            return {
                SetValue = function(v)
                    value = math.clamp(v, min, max)
                    local rel = (value - min) / (max - min)
                    valueLabel.Text = tostring(value)
                    Tween(fill, { Size = UDim2.new(rel, 0, 1, 0) }, 0.15)
                    Tween(knob, { Position = UDim2.new(rel, 0, 0.5, 0) }, 0.15)
                end,
                GetValue = function() return value end,
            }
        end

        -- DROPDOWN
        function TabObj:AddDropdown(config)
            config = config or {}
            local options = config.Options or {}
            local selected = config.Default or options[1] or "Select..."
            local open = false
            local itemHeight = 42

            local container = Create("Frame", {
                Size = UDim2.new(1, 0, 0, itemHeight),
                BackgroundTransparency = 1,
                ZIndex = 4,
                ClipsDescendants = false,
                Parent = tabPage,
            })

            local item = MakeItem(itemHeight)
            item.Parent = container
            item.ClipsDescendants = false
            HoverEffect(item, theme)

            MakeLabel(item, config.Label or "Dropdown")

            local selectedLabel = Create("TextLabel", {
                Size = UDim2.new(0, 120, 1, 0),
                Position = UDim2.new(1, -132, 0, 0),
                BackgroundTransparency = 1,
                Text = selected,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                TextColor3 = theme.TextDim,
                TextXAlignment = Enum.TextXAlignment.Right,
                ZIndex = 5,
                Parent = item,
            })

            local arrow = Create("TextLabel", {
                Size = UDim2.new(0, 18, 1, 0),
                Position = UDim2.new(1, -22, 0, 0),
                BackgroundTransparency = 1,
                Text = "▾",
                Font = Enum.Font.GothamBold,
                TextSize = 14,
                TextColor3 = theme.TextDim,
                ZIndex = 5,
                Parent = item,
            })

            local dropFrame = Create("Frame", {
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 1, 4),
                BackgroundColor3 = theme.InputBg,
                BorderSizePixel = 0,
                ZIndex = 10,
                ClipsDescendants = true,
                Parent = item,
            })
            Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = dropFrame })
            Create("UIStroke", { Color = theme.Border, Thickness = 1, Transparency = 0.4, Parent = dropFrame })

            local optLayout = Create("UIListLayout", {
                Padding = UDim.new(0, 2),
                Parent = dropFrame,
            })
            Create("UIPadding", {
                PaddingTop = UDim.new(0, 4),
                PaddingBottom = UDim.new(0, 4),
                PaddingLeft = UDim.new(0, 4),
                PaddingRight = UDim.new(0, 4),
                Parent = dropFrame,
            })

            local function SelectOption(opt)
                selected = opt
                selectedLabel.Text = opt
                if config.Callback then config.Callback(opt) end
            end

            for _, opt in ipairs(options) do
                local optBtn = Create("TextButton", {
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundColor3 = theme.Surface,
                    BorderSizePixel = 0,
                    Text = opt,
                    Font = Enum.Font.Gotham,
                    TextSize = 12,
                    TextColor3 = theme.Text,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 11,
                    Parent = dropFrame,
                })
                Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = optBtn })
                Create("UIPadding", { PaddingLeft = UDim.new(0, 10), Parent = optBtn })
                HoverEffect(optBtn, theme)

                optBtn.MouseButton1Click:Connect(function()
                    SelectOption(opt)
                    -- close
                    open = false
                    Tween(dropFrame, { Size = UDim2.new(1, 0, 0, 0) }, 0.2)
                    Tween(container, { Size = UDim2.new(1, 0, 0, itemHeight) }, 0.2)
                    arrow.Text = "▾"
                end)
            end

            local totalH = optLayout.AbsoluteContentSize.Y + 8
            task.defer(function()
                totalH = optLayout.AbsoluteContentSize.Y + 8
            end)

            local clickbtn = Create("TextButton", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 6,
                Parent = item,
            })
            clickbtn.MouseButton1Click:Connect(function()
                open = not open
                local targetH = open and (optLayout.AbsoluteContentSize.Y + 8) or 0
                arrow.Text = open and "▴" or "▾"
                Tween(dropFrame, { Size = UDim2.new(1, 0, 0, targetH) }, 0.2)
                Tween(container, { Size = UDim2.new(1, 0, 0, itemHeight + (open and targetH + 4 or 0)) }, 0.2)
            end)

            return {
                SetValue = function(v) SelectOption(v) end,
                GetValue = function() return selected end,
                SetOptions = function(newOpts)
                    -- clear and rebuild
                    for _, c in ipairs(dropFrame:GetChildren()) do
                        if c:IsA("TextButton") then c:Destroy() end
                    end
                    options = newOpts
                    for _, opt in ipairs(options) do
                        local ob = Create("TextButton", {
                            Size = UDim2.new(1, 0, 0, 30),
                            BackgroundColor3 = theme.Surface,
                            BorderSizePixel = 0,
                            Text = opt, Font = Enum.Font.Gotham, TextSize = 12,
                            TextColor3 = theme.Text, TextXAlignment = Enum.TextXAlignment.Left,
                            ZIndex = 11, Parent = dropFrame,
                        })
                        Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = ob })
                        Create("UIPadding", { PaddingLeft = UDim.new(0, 10), Parent = ob })
                        HoverEffect(ob, theme)
                        ob.MouseButton1Click:Connect(function()
                            SelectOption(opt)
                            open = false
                            Tween(dropFrame, { Size = UDim2.new(1, 0, 0, 0) }, 0.2)
                            Tween(container, { Size = UDim2.new(1, 0, 0, itemHeight) }, 0.2)
                            arrow.Text = "▾"
                        end)
                    end
                end,
            }
        end

        -- INPUT
        function TabObj:AddInput(config)
            config = config or {}
            local value = config.Default or ""
            local item = MakeItem(54)

            MakeLabel(item, config.Label or "Input",
                Enum.Font.Gotham, 13, theme.Text, nil,
                UDim2.new(0, 12, 0, 2), UDim2.new(1, -24, 0, 20))

            local inputBg = Create("Frame", {
                Size = UDim2.new(1, -24, 0, 26),
                Position = UDim2.new(0, 12, 0, 22),
                BackgroundColor3 = theme.InputBg,
                BorderSizePixel = 0,
                ZIndex = 5,
                Parent = item,
            })
            Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = inputBg })
            Create("UIStroke", { Color = theme.Border, Thickness = 1, Transparency = 0.5, Parent = inputBg })

            local inputBox = Create("TextBox", {
                Size = UDim2.new(1, -16, 1, 0),
                Position = UDim2.new(0, 8, 0, 0),
                BackgroundTransparency = 1,
                Text = value,
                PlaceholderText = config.Placeholder or "Enter value...",
                Font = Enum.Font.Gotham,
                TextSize = 12,
                TextColor3 = theme.Text,
                PlaceholderColor3 = theme.TextDisabled,
                ClearTextOnFocus = config.ClearOnFocus ~= false,
                ZIndex = 6,
                Parent = inputBg,
            })

            inputBox.Focused:Connect(function()
                Tween(inputBg, { BackgroundColor3 = theme.Surface }, 0.15)
                Tween(inputBg:FindFirstChildOfClass("UIStroke"), { Color = theme.Accent }, 0.15)
            end)
            inputBox.FocusLost:Connect(function(enter)
                value = inputBox.Text
                Tween(inputBg, { BackgroundColor3 = theme.InputBg }, 0.15)
                Tween(inputBg:FindFirstChildOfClass("UIStroke"), { Color = theme.Border }, 0.15)
                if config.Callback then config.Callback(value, enter) end
            end)

            return {
                SetValue = function(v) inputBox.Text = v; value = v end,
                GetValue = function() return value end,
            }
        end

        -- COLOR PICKER
        function TabObj:AddColorPicker(config)
            config = config or {}
            local value = config.Default or Color3.fromRGB(255, 100, 100)
            local open = false
            local hue, sat, val = value:ToHSV()
            local itemHeight = 42

            local container = Create("Frame", {
                Size = UDim2.new(1, 0, 0, itemHeight),
                BackgroundTransparency = 1,
                ZIndex = 4,
                Parent = tabPage,
            })

            local item = MakeItem(itemHeight)
            item.Parent = container
            item.ClipsDescendants = false
            HoverEffect(item, theme)

            MakeLabel(item, config.Label or "Color Picker")

            local preview = Create("Frame", {
                Size = UDim2.new(0, 22, 0, 22),
                Position = UDim2.new(1, -34, 0.5, -11),
                BackgroundColor3 = value,
                BorderSizePixel = 0,
                ZIndex = 5,
                Parent = item,
            })
            Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = preview })
            Create("UIStroke", { Color = theme.Border, Thickness = 1, Parent = preview })

            -- Picker panel
            local pickerPanel = Create("Frame", {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0, 0, 1, 4),
                BackgroundColor3 = theme.InputBg,
                BorderSizePixel = 0,
                ZIndex = 10,
                ClipsDescendants = true,
                Parent = item,
            })
            Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = pickerPanel })
            Create("UIStroke", { Color = theme.Border, Thickness = 1, Transparency = 0.4, Parent = pickerPanel })

            local PANEL_W = 220
            local PANEL_H = 180

            -- SV box
            local svBox = Create("ImageLabel", {
                Size = UDim2.new(0, PANEL_W - 16, 0, 110),
                Position = UDim2.new(0, 8, 0, 8),
                BackgroundColor3 = Color3.fromHSV(hue, 1, 1),
                Image = "rbxassetid://4155801252",
                ZIndex = 11,
                Parent = pickerPanel,
            })
            Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = svBox })

            local svKnob = Create("Frame", {
                Size = UDim2.new(0, 10, 0, 10),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(sat, 0, 1 - val, 0),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                ZIndex = 12,
                Parent = svBox,
            })
            Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = svKnob })
            Create("UIStroke", { Color = Color3.fromRGB(0,0,0), Thickness = 1.5, Parent = svKnob })

            -- Hue strip
            local hueStrip = Create("ImageLabel", {
                Size = UDim2.new(0, PANEL_W - 16, 0, 14),
                Position = UDim2.new(0, 8, 0, 124),
                Image = "rbxassetid://698512038",
                ZIndex = 11,
                Parent = pickerPanel,
            })
            Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = hueStrip })

            local hueKnob = Create("Frame", {
                Size = UDim2.new(0, 8, 1, 4),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(hue, 0, 0.5, 0),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                ZIndex = 12,
                Parent = hueStrip,
            })
            Create("UICorner", { CornerRadius = UDim.new(0, 3), Parent = hueKnob })

            -- Hex display
            local hexBox = Create("TextBox", {
                Size = UDim2.new(0, PANEL_W - 16, 0, 24),
                Position = UDim2.new(0, 8, 0, 146),
                BackgroundColor3 = theme.Surface,
                BorderSizePixel = 0,
                Text = string.format("#%02X%02X%02X", math.floor(value.R*255), math.floor(value.G*255), math.floor(value.B*255)),
                Font = Enum.Font.Code,
                TextSize = 12,
                TextColor3 = theme.Text,
                ZIndex = 12,
                Parent = pickerPanel,
            })
            Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = hexBox })

            local function UpdateColor()
                value = Color3.fromHSV(hue, sat, val)
                preview.BackgroundColor3 = value
                svBox.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
                svKnob.Position = UDim2.new(sat, 0, 1 - val, 0)
                hueKnob.Position = UDim2.new(hue, 0, 0.5, 0)
                hexBox.Text = string.format("#%02X%02X%02X", math.floor(value.R*255), math.floor(value.G*255), math.floor(value.B*255))
                if config.Callback then config.Callback(value) end
            end

            local function DragSV(inputX, inputY)
                local pos = svBox.AbsolutePosition
                local sz = svBox.AbsoluteSize
                sat = math.clamp((inputX - pos.X) / sz.X, 0, 1)
                val = 1 - math.clamp((inputY - pos.Y) / sz.Y, 0, 1)
                UpdateColor()
            end

            local function DragHue(inputX)
                local pos = hueStrip.AbsolutePosition
                local sz = hueStrip.AbsoluteSize
                hue = math.clamp((inputX - pos.X) / sz.X, 0, 1)
                UpdateColor()
            end

            local dragSV, dragHue = false, false
            svBox.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragSV = true; DragSV(i.Position.X, i.Position.Y) end end)
            hueStrip.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragHue = true; DragHue(i.Position.X) end end)
            UserInputService.InputChanged:Connect(function(i)
                if i.UserInputType ~= Enum.UserInputType.MouseMovement then return end
                if dragSV then DragSV(i.Position.X, i.Position.Y) end
                if dragHue then DragHue(i.Position.X) end
            end)
            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then dragSV = false; dragHue = false end
            end)

            local clickbtn = Create("TextButton", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 6,
                Parent = item,
            })
            clickbtn.MouseButton1Click:Connect(function()
                open = not open
                if open then
                    Tween(pickerPanel, { Size = UDim2.new(0, PANEL_W, 0, PANEL_H) }, 0.2, Enum.EasingStyle.Back)
                    Tween(container, { Size = UDim2.new(1, 0, 0, itemHeight + PANEL_H + 4) }, 0.2)
                else
                    Tween(pickerPanel, { Size = UDim2.new(0, 0, 0, 0) }, 0.15)
                    Tween(container, { Size = UDim2.new(1, 0, 0, itemHeight) }, 0.15)
                end
            end)

            return {
                SetValue = function(c)
                    value = c
                    hue, sat, val = c:ToHSV()
                    UpdateColor()
                end,
                GetValue = function() return value end,
            }
        end

        -- KEYBIND
        function TabObj:AddKeybind(config)
            config = config or {}
            local value = config.Default or Enum.KeyCode.Unknown
            local listening = false
            local item = MakeItem(42)
            HoverEffect(item, theme)

            MakeLabel(item, config.Label or "Keybind")

            local keyBtn = Create("TextButton", {
                Size = UDim2.new(0, 80, 0, 26),
                Position = UDim2.new(1, -92, 0.5, -13),
                BackgroundColor3 = theme.InputBg,
                BorderSizePixel = 0,
                Text = value.Name,
                Font = Enum.Font.GothamBold,
                TextSize = 12,
                TextColor3 = theme.Text,
                ZIndex = 5,
                Parent = item,
            })
            Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = keyBtn })
            Create("UIStroke", { Color = theme.Border, Thickness = 1, Transparency = 0.5, Parent = keyBtn })

            keyBtn.MouseButton1Click:Connect(function()
                listening = true
                keyBtn.Text = "..."
                Tween(keyBtn, { BackgroundColor3 = theme.AccentDim }, 0.1)
            end)

            UserInputService.InputBegan:Connect(function(input, gpe)
                if not listening then return end
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    value = input.KeyCode
                    keyBtn.Text = value.Name
                    listening = false
                    Tween(keyBtn, { BackgroundColor3 = theme.InputBg }, 0.1)
                    if config.Callback then config.Callback(value) end
                end
            end)

            return {
                SetValue = function(k) value = k; keyBtn.Text = k.Name end,
                GetValue = function() return value end,
            }
        end

        -- NOTIFICATION (Window-level, returns for use in tab)
        function TabObj:Notify(config)
            WindowObj:Notify(config)
        end

        return TabObj
    end

    -- ─────────────────────────────────────────
    -- Notifications
    -- ─────────────────────────────────────────
    local notifFrame = Create("Frame", {
        Size = UDim2.new(0, 280, 1, 0),
        Position = UDim2.new(1, 10, 0, 0),
        BackgroundTransparency = 1,
        ZIndex = 20,
        Parent = MainFrame,
    })
    Create("UIListLayout", {
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        Padding = UDim.new(0, 6),
        Parent = notifFrame,
    })
    Create("UIPadding", { PaddingBottom = UDim.new(0, 8), Parent = notifFrame })

    function WindowObj:Notify(config)
        config = config or {}
        local typeColor = ({
            Success = theme.Success,
            Warning = theme.Warning,
            Error   = theme.Error,
            Info    = theme.Accent,
        })[config.Type or "Info"] or theme.Accent

        local notif = Create("Frame", {
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundColor3 = theme.Surface,
            BorderSizePixel = 0,
            ClipsDescendants = true,
            ZIndex = 21,
            Parent = notifFrame,
        })
        Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = notif })
        Create("UIStroke", { Color = typeColor, Thickness = 1, Transparency = 0.5, Parent = notif })

        local accent = Create("Frame", {
            Size = UDim2.new(0, 3, 1, 0),
            BackgroundColor3 = typeColor,
            BorderSizePixel = 0,
            ZIndex = 22,
            Parent = notif,
        })
        Create("UICorner", { CornerRadius = UDim.new(0, 3), Parent = accent })

        Create("TextLabel", {
            Size = UDim2.new(1, -16, 0, 22),
            Position = UDim2.new(0, 14, 0, 6),
            BackgroundTransparency = 1,
            Text = config.Title or "Notification",
            Font = Enum.Font.GothamBold,
            TextSize = 13,
            TextColor3 = theme.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 22,
            Parent = notif,
        })

        if config.Message then
            Create("TextLabel", {
                Size = UDim2.new(1, -16, 0, 0),
                Position = UDim2.new(0, 14, 0, 26),
                BackgroundTransparency = 1,
                Text = config.Message,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                TextColor3 = theme.TextDim,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                AutomaticSize = Enum.AutomaticSize.Y,
                ZIndex = 22,
                Parent = notif,
            })
        end

        local targetH = config.Message and 60 or 36
        Tween(notif, { Size = UDim2.new(1, 0, 0, targetH) }, 0.25, Enum.EasingStyle.Back)

        -- Progress bar
        local progBg = Create("Frame", {
            Size = UDim2.new(1, 0, 0, 2),
            Position = UDim2.new(0, 0, 1, -2),
            BackgroundColor3 = theme.Border,
            BorderSizePixel = 0,
            ZIndex = 22,
            Parent = notif,
        })
        local prog = Create("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = typeColor,
            BorderSizePixel = 0,
            ZIndex = 23,
            Parent = progBg,
        })
        local dur = config.Duration or 4
        Tween(prog, { Size = UDim2.new(0, 0, 1, 0) }, dur, Enum.EasingStyle.Linear)

        task.delay(dur, function()
            Tween(notif, { Size = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1 }, 0.2)
            task.delay(0.25, function() notif:Destroy() end)
        end)
    end

    function WindowObj:SetTheme(newTheme)
        theme = Themes[newTheme] or theme
    end

    function WindowObj:Destroy()
        ScreenGui:Destroy()
    end

    return WindowObj
end

-- ─────────────────────────────────────────────
-- Expose Themes
-- ─────────────────────────────────────────────
NexusUI.Themes = Themes

return NexusUI
