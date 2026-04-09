local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- =============================================
--           CURSOR SETTINGS (Edit Here)
-- =============================================

local CURSOR_IMAGE = "rbxassetid://99289185289544"
local CURSOR_SIZE  = 20

local COLOR_MODE = "static"
local STATIC_COLOR = Color3.fromHex("#ff0000")
local RAINBOW_SPEED = 0.2

-- =============================================

-- Get proper GUI parent
local guiParent
if gethui then
    guiParent = gethui()
else
    local ok, coreGui = pcall(function()
        return game:GetService("CoreGui")
    end)
    guiParent = (ok and coreGui) or playerGui
end

-- Destroy old cursor
local existing = guiParent:FindFirstChild("CustomMouseGui")
if existing then existing:Destroy() end

-- Create custom cursor GUI
local mouseGui = Instance.new("ScreenGui")
mouseGui.Name = "CustomMouseGui"
mouseGui.DisplayOrder = 2147483647
mouseGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
mouseGui.IgnoreGuiInset = true
mouseGui.ResetOnSpawn = false
mouseGui.Parent = guiParent

if protectgui then
    pcall(protectgui, mouseGui)
end

local mouseIcon = Instance.new("ImageLabel")
mouseIcon.Name = "CursorIcon"
mouseIcon.Size = UDim2.new(0, CURSOR_SIZE, 0, CURSOR_SIZE)
mouseIcon.BackgroundTransparency = 1
mouseIcon.Image = CURSOR_IMAGE
mouseIcon.ZIndex = 2147483647
mouseIcon.Parent = mouseGui

if COLOR_MODE == "static" then
    mouseIcon.ImageColor3 = STATIC_COLOR
end

-- =============================================
--      PERMANENT DEFAULT CURSOR HIDE
-- =============================================

UserInputService.MouseIconEnabled = false

-- This ensures the default cursor stays hidden even after death/respawn
local function forceHideDefaultCursor()
    UserInputService.MouseIconEnabled = false
end

-- Run every frame to make it truly permanent
local hideConnection
hideConnection = RunService.RenderStepped:Connect(forceHideDefaultCursor)

-- =============================================
--           Main Cursor Loop
-- =============================================

local hue = 0
local connection

connection = RunService.RenderStepped:Connect(function(dt)
    -- Safety check
    if not mouseGui.Parent then
        if hideConnection then
            hideConnection:Disconnect()
        end
        UserInputService.MouseIconEnabled = true
        connection:Disconnect()
        return
    end

    -- Update custom cursor position
    local mouseLocation = UserInputService:GetMouseLocation()
    mouseIcon.Position = UDim2.new(0, mouseLocation.X, 0, mouseLocation.Y)

    -- Rainbow effect
    if COLOR_MODE == "rainbow" then
        hue = (hue + dt * RAINBOW_SPEED) % 1
        mouseIcon.ImageColor3 = Color3.fromHSV(hue, 1, 1)
    end

    -- Force hide default cursor every frame (extra safety)
    UserInputService.MouseIconEnabled = false
end)

print("Custom cursor loaded with permanent default cursor hidden.")
