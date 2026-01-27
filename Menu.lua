-- FSociety Script Menu - Clean Version (Fullscreen)
-- Logo visible with only "Script Menu" text below

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FSocietyMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

-- Fullscreen Background
local Background = Instance.new("Frame")
Background.Name = "Background"
Background.Size = UDim2.new(1, 0, 1, 0)
Background.Position = UDim2.new(0, 0, 0, 0)
Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Background.BorderSizePixel = 0
Background.Parent = ScreenGui

-- Container for centered content
local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Size = UDim2.new(0, 1100, 0, 750)
Container.Position = UDim2.new(0.5, -550, 0.5, -375)
Container.BackgroundTransparency = 1
Container.Parent = Background

-- Custom Logo Icon (Clean, no background)
local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Size = UDim2.new(0, 300, 0, 300)
Logo.Position = UDim2.new(0.5, -150, 0, 10)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://97712898184809" -- Your custom logo
Logo.ScaleType = Enum.ScaleType.Fit
Logo.Parent = Container

-- Tab Buttons Container
local TabButtons = Instance.new("Frame")
TabButtons.Name = "TabButtons"
TabButtons.Size = UDim2.new(1, -100, 0, 60)
TabButtons.Position = UDim2.new(0, 50, 0, 330)
TabButtons.BackgroundTransparency = 1
TabButtons.Parent = Container

-- Content Display Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -100, 0, 280)
ContentFrame.Position = UDim2.new(0, 50, 0, 400)
ContentFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
ContentFrame.BorderColor3 = Color3.fromRGB(100, 100, 100)
ContentFrame.BorderSizePixel = 2
ContentFrame.Parent = Container

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 8)
ContentCorner.Parent = ContentFrame

-- Content ScrollingFrame
local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Name = "ContentScroll"
ContentScroll.Size = UDim2.new(1, -30, 1, -20)
ContentScroll.Position = UDim2.new(0, 15, 0, 10)
ContentScroll.BackgroundTransparency = 1
ContentScroll.BorderSizePixel = 0
ContentScroll.ScrollBarThickness = 6
ContentScroll.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentScroll.Parent = ContentFrame

-- Tab system
local tabs = {}
local currentTab = nil

-- Function to create tab button
local function createTabButton(name, icon, order)
    local Button = Instance.new("TextButton")
    Button.Name = name .. "Button"
    Button.Size = UDim2.new(0, 250, 0, 55)
    Button.Position = UDim2.new(0, (order - 1) * 260, 0, 0)
    Button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Button.BorderColor3 = Color3.fromRGB(80, 80, 80)
    Button.BorderSizePixel = 2
    Button.AutoButtonColor = false
    Button.Text = "" -- REMOVED: Button text is now empty
    Button.Parent = TabButtons
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button
    
    -- Icon
    local Icon = Instance.new("TextLabel")
    Icon.Name = "Icon"
    Icon.Size = UDim2.new(0, 40, 0, 40)
    Icon.Position = UDim2.new(0, 10, 0.5, -20)
    Icon.BackgroundTransparency = 1
    Icon.Text = icon
    Icon.TextSize = 28
    Icon.Font = Enum.Font.GothamBold
    Icon.TextColor3 = Color3.fromRGB(220, 220, 220)
    Icon.Parent = Button
    
    -- Text
    local Text = Instance.new("TextLabel")
    Text.Name = "Text"
    Text.Size = UDim2.new(1, -60, 1, 0)
    Text.Position = UDim2.new(0, 55, 0, 0)
    Text.BackgroundTransparency = 1
    Text.Text = name
    Text.TextSize = 20
    Text.Font = Enum.Font.GothamSemibold
    Text.TextColor3 = Color3.fromRGB(220, 220, 220)
    Text.TextXAlignment = Enum.TextXAlignment.Left
    Text.Parent = Button
    
    -- Selected indicator (red underline)
    local Indicator = Instance.new("Frame")
    Indicator.Name = "Indicator"
    Indicator.Size = UDim2.new(1, -10, 0, 3)
    Indicator.Position = UDim2.new(0, 5, 1, -6)
    Indicator.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
    Indicator.BorderSizePixel = 0
    Indicator.Visible = false
    Indicator.Parent = Button
    
    return Button, Indicator, Icon, Text
end

-- Function to create content for a tab
local function createTabContent(name)
    local Content = Instance.new("Frame")
    Content.Name = name .. "Content"
    Content.Size = UDim2.new(1, 0, 1, 0)
    Content.BackgroundTransparency = 1
    Content.Visible = false
    Content.Parent = ContentScroll
    
    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 5)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = Content
    
    -- Auto-resize canvas
    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ContentScroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 20)
    end)
    
    return Content
end

-- Create text label for content
local function createText(parent, text)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextSize = 20
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.Font = Enum.Font.Gotham
    Label.TextWrapped = true
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextYAlignment = Enum.TextYAlignment.Top
    Label.Parent = parent
    
    -- Auto-size
    Label.Size = UDim2.new(1, 0, 0, Label.TextBounds.Y + 5)
    Label:GetPropertyChangedSignal("TextBounds"):Connect(function()
        Label.Size = UDim2.new(1, 0, 0, Label.TextBounds.Y + 5)
    end)
    
    return Label
end

-- Create the 4 tabs
local tab1Button, tab1Indicator = createTabButton("How to Use It", "💡", 1)
local tab2Button, tab2Indicator = createTabButton("Info", "➕", 2)
local tab3Button, tab3Indicator = createTabButton("Credit", "🤝", 3)
local tab4Button, tab4Indicator = createTabButton("Load Script", "📤", 4)

local tab1Content = createTabContent("HowToUse")
local tab2Content = createTabContent("Info")
local tab3Content = createTabContent("Credit")
local tab4Content = createTabContent("LoadScript")

-- Store tab data
tabs["How to Use It"] = {button = tab1Button, indicator = tab1Indicator, content = tab1Content}
tabs["Info"] = {button = tab2Button, indicator = tab2Indicator, content = tab2Content}
tabs["Credit"] = {button = tab3Button, indicator = tab3Indicator, content = tab3Content}
tabs["Load Script"] = {button = tab4Button, indicator = tab4Indicator, content = tab4Content}

-- Switch tab function
local function switchTab(tabName)
    for name, data in pairs(tabs) do
        if name == tabName then
            data.indicator.Visible = true
            data.button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            data.content.Visible = true
            currentTab = name
        else
            data.indicator.Visible = false
            data.button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            data.content.Visible = false
        end
    end
end

-- Connect tab buttons
for name, data in pairs(tabs) do
    data.button.MouseButton1Click:Connect(function()
        switchTab(name)
    end)
    
    -- Hover effect
    data.button.MouseEnter:Connect(function()
        if currentTab ~= name then
            TweenService:Create(data.button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
        end
    end)
    
    data.button.MouseLeave:Connect(function()
        if currentTab ~= name then
            TweenService:Create(data.button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
        end
    end)
end

-- Populate "How to Use It" tab (EXACT text from image)
createText(tab1Content, "To use the FsSociety script menu, navigate through the tabs to find the options you need.")
createText(tab1Content, "")
createText(tab1Content, "Be sure you have the latest version of the script. To load a script, click the \"Load Script\" tab,")
createText(tab1Content, "")
createText(tab1Content, "and then select the script file you want to run. For additional information, click the \"Info\"")
createText(tab1Content, "")
createText(tab1Content, "tab, and to see credits, click the \"Credit\" tab.")

-- Populate "Info" tab
createText(tab2Content, "FSociety Script Menu")
createText(tab2Content, "Version: 1.0.0")
createText(tab2Content, "")
createText(tab2Content, "This is a fullscreen script menu interface for Roblox.")
createText(tab2Content, "")
createText(tab2Content, "Features:")
createText(tab2Content, "• Fullscreen interface")
createText(tab2Content, "• Tab navigation system")
createText(tab2Content, "• Script loading capabilities")
createText(tab2Content, "• Clean, modern design")
createText(tab2Content, "")
createText(tab2Content, "Menu will close after executing a script.")

-- Populate "Credit" tab
createText(tab3Content, "FSociety Script Menu")
createText(tab3Content, "")
createText(tab3Content, "Created by: [Your Name Here]")
createText(tab3Content, "Version: 1.0.0")
createText(tab3Content, "Release Date: January 2026")
createText(tab3Content, "")
createText(tab3Content, "Special Thanks:")
createText(tab3Content, "• qShadow Ui Designer/Scripter/CyberSecurity")
createText(tab3Content, "• And the text and logo are inspired by the Movie Mr.Robot")
createText(tab3Content, "• All testers and contributors")

-- Populate "Load Script" tab with buttons
local function createScriptButton(parent, text, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -10, 0, 45)
    Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Button.BorderColor3 = Color3.fromRGB(100, 100, 100)
    Button.BorderSizePixel = 1
    Button.Text = text
    Button.TextSize = 18
    Button.TextColor3 = Color3.fromRGB(220, 220, 220)
    Button.Font = Enum.Font.GothamSemibold
    Button.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Button
    
    Button.MouseButton1Click:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
        wait(0.15)
        Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        if callback then callback() end
        
        -- Cool glitch exit animation
        local function glitchEffect()
            -- Create "SCRIPT EXECUTED" text
            local ExecutedText = Instance.new("TextLabel")
            ExecutedText.Size = UDim2.new(0, 600, 0, 100)
            ExecutedText.Position = UDim2.new(0.5, -300, 0.5, -50)
            ExecutedText.BackgroundTransparency = 1
            ExecutedText.Text = "SCRIPT EXECUTED"
            ExecutedText.TextSize = 48
            ExecutedText.Font = Enum.Font.GothamBold
            ExecutedText.TextColor3 = Color3.fromRGB(0, 255, 0)
            ExecutedText.TextTransparency = 1
            ExecutedText.Parent = Background
            
            -- Fade in executed text
            TweenService:Create(ExecutedText, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
            
            -- Glitch effect on container
            for i = 1, 8 do
                wait(0.05)
                Container.Position = UDim2.new(0.5, -550 + math.random(-20, 20), 0.5, -375 + math.random(-20, 20))
                Container.Rotation = math.random(-5, 5)
            end
            
            -- Flash background red
            Background.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
            wait(0.1)
            Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            wait(0.1)
            Background.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
            wait(0.1)
            Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            
            -- Fade out executed text
            TweenService:Create(ExecutedText, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
            
            -- Zoom out and fade
            TweenService:Create(Container, TweenInfo.new(0.5), {
                Size = UDim2.new(0, 1500, 0, 1000),
                Position = UDim2.new(0.5, -750, 0.5, -500),
                Rotation = 0
            }):Play()
            
            TweenService:Create(Background, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            
            wait(0.6)
            Background.Visible = false
        end
        
        glitchEffect()
    end)
    
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
    end)
    
    return Button
end

createText(tab4Content, "Load your favorite scripts:")
createText(tab4Content, "")

createScriptButton(tab4Content, "🔧 Infinite Yield (Admin Commands)", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

createScriptButton(tab4Content, "🔍 Dark Dex V3 (Explorer)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua"))()
end)

createScriptButton(tab4Content, "🕵️ Simple Spy (Remote Spy)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
end)

createScriptButton(tab4Content, "🎮 Universal ESP", function()
    print("ESP Script - Add your script URL here")
end)

createScriptButton(tab4Content, "⚡ Universal Fly", function()
    print("Fly Script - Add your script URL here")
end)

-- Set initial tab
switchTab("How to Use It")

-- Fade in animation on load
Background.BackgroundTransparency = 1
Container.Position = UDim2.new(0.5, -550, 0.5, -450)

TweenService:Create(Background, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
TweenService:Create(Container, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
    {Position = UDim2.new(0.5, -550, 0.5, -375)}):Play()

print("✅ FSociety Script Menu loaded successfully!")
print("📌 Menu will close after executing a script")
