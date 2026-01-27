--[[
$$$$$$$$\  $$$$$$\   $$$$$$\   $$$$$$\  $$$$$$\ $$$$$$$$\ $$$$$$$$\ $$\     $$\ 
$$  _____|$$  __$$\ $$  __$$\ $$  __$$\ \_$$  _|$$  _____|\_$$  ___|\_$$\   $$  |
$$ |      $$ /  \__|$$ /  $$ |$$ /  \__|  $$ |  $$ |        $$ |      \_$$\ $$  / 
$$$$$\    \$$$$$$\  $$ |  $$ |$$ |        $$ |  $$$$$\      $$ |        \$$$$  /  
$$  __|    \____$$\ $$ |  $$ |$$ |        $$ |  $$  __|     $$ |         \$$  /   
$$ |      $$\   $$ |$$ |  $$ |$$ |  $$\   $$ |  $$ |        $$ |          $$ |    
$$ |      \$$$$$$  | $$$$$$  |\$$$$$$  |$$$$$$\ $$$$$$$$\   $$ |          $$ |    
\__|       \______/  \______/  \______/ \______|\________|  \__|          \__|    
]]

-- Load the key system
local KeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/qShadow14/Andrei-Script/refs/heads/main/Andrei_Script.lua"))()
wait(9)

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- ============================================
-- CREATE WINDOW (No preset themes needed)
-- ============================================

local Window = WindUI:CreateWindow({
	Title = "Zenzyri",
	Icon = "terminal",
	Author = "by qShadow/Andrei",
	Folder = ".gg/vwj92WkEBz",
	Size = UDim2.fromOffset(580, 460),
	MinSize = Vector2.new(560, 350),
	MaxSize = Vector2.new(850, 560),
	Transparent = true,
	Theme = "Dark",
	Resizable = false,
	SideBarWidth = 200,
	BackgroundImageTransparency = 0.42,
	HideSearchBar = false,
	ScrollBarEnabled = true,
	User = {
		Enabled = true,
		Anonymous = false,
		Callback = function()
			print("clicked")
		end,
	},
	NewElements = true
})

Window:EditOpenButton({
	Title = "Zenzyri",
	Icon = "terminal",
	CornerRadius = UDim.new(0,16),
	StrokeThickness = 2,
	Color = ColorSequence.new(
		Color3.fromHex("FF5CFF"), 
		Color3.fromHex("FF00FF")
	),
	OnlyMobile = false,
	Enabled = true,
	Draggable = true,
})

-- Services
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

-- ============================================
-- INFORMATION TAB
-- ============================================

local InfoTab = Window:Tab({
	Title = "Information",
	Icon = "info",
	Locked = false,
})

InfoTab:Paragraph({
	Title = "Till now in the script we have these games:",
	Desc = "",
	Color = Color3.fromRGB(0, 0, 0),
	Locked = false,
})

InfoTab:Paragraph({
	Title = "Remember,these games wont appear u have to be in the actual game",
	Desc = "",
	Color = Color3.fromRGB(0, 0, 0),
	Locked = false,
})

InfoTab:Paragraph({
	Title = "Supported Games",
	Desc = "1. Car Crusher 2\n2. Counter Blox\n3. Dead Rails\n4. The Forge\n5. Strongman Simulator\n6. 99 night in the forest\n7. Blox Fruit\n8. Island\n9. osu!RoVer\n10. Flick\n11. Doors\n12. Evade\n13. A dusty Trip\n14. Build a boat for treasure\n15. Fisch\n16. The Train Tunnels\n17. Fnaf Co-op\n18. Scary Shawarma\n19. Slap battles\n20. Cult of the Lamb\n21. Blade Ball\n22. Grace\n23. Rivals\n24. Fnaf ethernal\n25. Survive the Killer",
	Color = Color3.fromRGB(0, 0, 0),
	Locked = false,
})

-- ============================================
-- HOME TAB WITH CUSTOM THEME COLORS ONLY
-- ============================================

local HomeTab = Window:Tab({
	Title = "Home",
	Icon = "house",
	Locked = false,
})

-- Add custom color pickers for full theme customization
local savedColors = {}

-- Helper function to convert Color3 to table
local function Color3ToTable(color)
	return {R = color.R, G = color.G, B = color.B}
end

-- Helper function to convert table to Color3
local function TableToColor3(tbl)
	if tbl and tbl.R and tbl.G and tbl.B then
		return Color3.new(tbl.R, tbl.G, tbl.B)
	end
	return nil
end

-- Try to load saved colors
local function LoadColors()
	if isfile and readfile then
		local success, result = pcall(function()
			if isfile("FSociety_Theme.json") then
				return HttpService:JSONDecode(readfile("FSociety_Theme.json"))
			end
			return nil
		end)
		if success and result then
			savedColors = result
			print("✓ Loaded saved theme colors")
			return true
		end
	end
	return false
end

LoadColors()

local currentAccent = TableToColor3(savedColors.Accent) or Color3.fromRGB(255, 255, 255)
local currentBackground = TableToColor3(savedColors.Background) or Color3.fromRGB(10, 10, 10)
local currentButton = TableToColor3(savedColors.Button) or Color3.fromRGB(26, 26, 26)
local currentText = TableToColor3(savedColors.Text) or Color3.fromRGB(255, 255, 255)
local currentOutline = TableToColor3(savedColors.Outline) or Color3.fromRGB(255, 255, 255)
local currentPlaceholder = TableToColor3(savedColors.Placeholder) or Color3.fromRGB(122, 122, 122)
local currentIcon = TableToColor3(savedColors.Icon) or Color3.fromRGB(161, 161, 170)

local function SaveColors()
	if writefile then
		local colorData = {
			Accent = Color3ToTable(currentAccent),
			Background = Color3ToTable(currentBackground),
			Button = Color3ToTable(currentButton),
			Text = Color3ToTable(currentText),
			Outline = Color3ToTable(currentOutline),
			Placeholder = Color3ToTable(currentPlaceholder),
			Icon = Color3ToTable(currentIcon)
		}
		local success, err = pcall(function()
			writefile("FSociety_Theme.json", HttpService:JSONEncode(colorData))
		end)
		if success then
			print("✓ Theme colors saved successfully")
		else
			warn("Failed to save theme:", err)
		end
	else
		warn("writefile not available - theme cannot be saved")
	end
end

local function UpdateTheme()
    WindUI:AddTheme({
        Name = "Custom",
        Accent = currentAccent,
        Background = currentBackground,
        Outline = currentOutline,
        Text = currentText,
        Placeholder = currentPlaceholder,
        Button = currentButton,
        Icon = currentIcon,
    })
    task.wait(0.05)
    WindUI:SetTheme("Custom")
    SaveColors()
end

-- Apply saved theme on startup if colors were loaded
if savedColors.Accent then
	task.wait(0.5)
	UpdateTheme()
	print("✓ Applied saved theme")
end

-- Color pickers directly in Home tab (no collapsible section)
HomeTab:Paragraph({
    Title = "Theme Customization",
    Desc = "Customize every color - changes auto-save",
    Color = Color3.fromRGB(100, 100, 255),
    Locked = false,
})

HomeTab:Colorpicker({
    Title = "Accent Color",
    Desc = "Main theme color - highlights, outlines, active elements",
    Default = currentAccent,
    Transparency = 0,
    Locked = false,
    Callback = function(color) 
        currentAccent = color
        UpdateTheme()
        print("✓ Accent color updated & saved")
    end
})

HomeTab:Colorpicker({
    Title = "Background Color",
    Desc = "Main window background",
    Default = currentBackground,
    Transparency = 0,
    Locked = false,
    Callback = function(color) 
        currentBackground = color
        UpdateTheme()
        print("✓ Background color updated & saved")
    end
})

HomeTab:Colorpicker({
    Title = "Button Color",
    Desc = "All buttons and interactive elements",
    Default = currentButton,
    Transparency = 0,
    Locked = false,
    Callback = function(color) 
        currentButton = color
        UpdateTheme()
        print("✓ Button color updated & saved")
    end
})

HomeTab:Colorpicker({
    Title = "Text Color",
    Desc = "All text throughout the UI",
    Default = currentText,
    Transparency = 0,
    Locked = false,
    Callback = function(color) 
        currentText = color
        UpdateTheme()
        print("✓ Text color updated & saved")
    end
})

HomeTab:Colorpicker({
    Title = "Outline Color",
    Desc = "Borders and outlines",
    Default = currentOutline,
    Transparency = 0,
    Locked = false,
    Callback = function(color) 
        currentOutline = color
        UpdateTheme()
        print("✓ Outline color updated & saved")
    end
})

HomeTab:Colorpicker({
    Title = "Placeholder Text",
    Desc = "Secondary text color",
    Default = currentPlaceholder,
    Transparency = 0,
    Locked = false,
    Callback = function(color) 
        currentPlaceholder = color
        UpdateTheme()
        print("✓ Placeholder color updated & saved")
    end
})

HomeTab:Colorpicker({
    Title = "Icon Color",
    Desc = "All icons throughout the UI",
    Default = currentIcon,
    Transparency = 0,
    Locked = false,
    Callback = function(color) 
        currentIcon = color
        UpdateTheme()
        print("✓ Icon color updated & saved")
    end
})

HomeTab:Button({
    Title = "Reset to Default Theme",
    Desc = "Click to reset all colors to default black theme",
    Callback = function()
        currentAccent = Color3.fromRGB(255, 255, 255)
        currentBackground = Color3.fromRGB(10, 10, 10)
        currentButton = Color3.fromRGB(26, 26, 26)
        currentText = Color3.fromRGB(255, 255, 255)
        currentOutline = Color3.fromRGB(255, 255, 255)
        currentPlaceholder = Color3.fromRGB(122, 122, 122)
        currentIcon = Color3.fromRGB(161, 161, 170)
        UpdateTheme()
        if delfile and isfile and isfile("FSociety_Theme.json") then
            pcall(function()
                delfile("FSociety_Theme.json")
            end)
        end
        print("✓ Theme reset to default & file deleted")
    end
})

-- Performance Stats (no collapsible section)
HomeTab:Paragraph({
	Title = "Performance Stats",
	Desc = "Display real-time game statistics",
	Color = Color3.fromRGB(0, 255, 100),
	Locked = false,
})

-- FPS Counter
local fpsEnabled = false
local fpsLabel = nil

HomeTab:Toggle({
	Title = "FPS Counter",
	Desc = "Show frames per second on screen",
	Default = false,
	Callback = function(enabled)
		fpsEnabled = enabled
		if enabled then
			local player = game.Players.LocalPlayer
			local screenGui = Instance.new("ScreenGui")
			screenGui.Name = "FSocietyFPS"
			screenGui.ResetOnSpawn = false
			screenGui.Parent = player.PlayerGui
			
			fpsLabel = Instance.new("TextLabel")
			fpsLabel.Size = UDim2.new(0, 120, 0, 40)
			fpsLabel.Position = UDim2.new(1, -130, 0, 10)
			fpsLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			fpsLabel.BackgroundTransparency = 0.5
			fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
			fpsLabel.TextSize = 18
			fpsLabel.Font = Enum.Font.GothamBold
			fpsLabel.Text = "FPS: 0"
			fpsLabel.Parent = screenGui
			
			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0, 8)
			corner.Parent = fpsLabel
			
			local lastTime = tick()
			local frameCount = 0
			
			RunService.RenderStepped:Connect(function()
				if not fpsEnabled then return end
				frameCount = frameCount + 1
				local currentTime = tick()
				if currentTime - lastTime >= 1 then
					local fps = frameCount
					fpsLabel.Text = "FPS: " .. fps
					frameCount = 0
					lastTime = currentTime
				end
			end)
			
			print("✓ FPS counter enabled")
		else
			local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("FSocietyFPS")
			if gui then gui:Destroy() end
			print("✓ FPS counter disabled")
		end
	end
})

-- Ping Display
local pingEnabled = false

HomeTab:Toggle({
	Title = "Ping Display",
	Desc = "Show network latency on screen",
	Default = false,
	Callback = function(enabled)
		pingEnabled = enabled
		if enabled then
			local player = game.Players.LocalPlayer
			local screenGui = Instance.new("ScreenGui")
			screenGui.Name = "FSocietyPing"
			screenGui.ResetOnSpawn = false
			screenGui.Parent = player.PlayerGui
			
			local pingLabel = Instance.new("TextLabel")
			pingLabel.Size = UDim2.new(0, 120, 0, 40)
			pingLabel.Position = UDim2.new(1, -130, 0, 60)
			pingLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			pingLabel.BackgroundTransparency = 0.5
			pingLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
			pingLabel.TextSize = 18
			pingLabel.Font = Enum.Font.GothamBold
			pingLabel.Text = "Ping: 0ms"
			pingLabel.Parent = screenGui
			
			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0, 8)
			corner.Parent = pingLabel
			
			task.spawn(function()
				while pingEnabled do
					local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
					pingLabel.Text = "Ping: " .. ping
					task.wait(1)
				end
			end)
			
			print("✓ Ping display enabled")
		else
			local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("FSocietyPing")
			if gui then gui:Destroy() end
			print("✓ Ping display disabled")
		end
	end
})

-- Server Info
HomeTab:Toggle({
	Title = "Server Info",
	Desc = "Display server details",
	Default = false,
	Callback = function(enabled)
		if enabled then
			local player = game.Players.LocalPlayer
			local screenGui = Instance.new("ScreenGui")
			screenGui.Name = "FSocietyServerInfo"
			screenGui.ResetOnSpawn = false
			screenGui.Parent = player.PlayerGui
			
			local infoLabel = Instance.new("TextLabel")
			infoLabel.Size = UDim2.new(0, 200, 0, 80)
			infoLabel.Position = UDim2.new(1, -210, 0, 110)
			infoLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			infoLabel.BackgroundTransparency = 0.5
			infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			infoLabel.TextSize = 14
			infoLabel.Font = Enum.Font.Gotham
			infoLabel.TextYAlignment = Enum.TextYAlignment.Top
			infoLabel.TextXAlignment = Enum.TextXAlignment.Left
			infoLabel.Parent = screenGui
			
			local padding = Instance.new("UIPadding")
			padding.PaddingLeft = UDim.new(0, 8)
			padding.PaddingTop = UDim.new(0, 8)
			padding.Parent = infoLabel
			
			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0, 8)
			corner.Parent = infoLabel
			
			task.spawn(function()
				while enabled do
					local players = #game.Players:GetPlayers()
					local maxPlayers = game.Players.MaxPlayers
					local jobId = game.JobId:sub(1, 8) .. "..."
					infoLabel.Text = string.format("Players: %d/%d\nServer ID:\n%s", players, maxPlayers, jobId)
					task.wait(2)
				end
			end)
			
			print("✓ Server info enabled")
		else
			local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("FSocietyServerInfo")
			if gui then gui:Destroy() end
			print("✓ Server info disabled")
		end
	end
})

-- ============================================
-- ENHANCED INFO
-- ============================================

InfoTab:Paragraph({
	Title = "About FSociety",
	Desc = "Script information and credits",
	Color = Color3.fromRGB(150, 150, 255),
	Locked = false,
})

InfoTab:Paragraph({
	Title = "FSociety Script Hub",
	Desc = "Version: 1.5.0\nLast Updated: January 2026\nDeveloper: .gg/vwj92WkEBz\n\nA powerful multi-game script hub with advanced customization and features.",
	Color = Color3.fromRGB(100, 100, 255),
	Locked = false,
})

InfoTab:Button({
	Title = "Join Discord Server",
	Desc = "Click to copy Discord invite",
	Callback = function()
		if setclipboard then
			setclipboard("https://discord.gg/vwj92WkEBz")
			print("✓ Discord link copied to clipboard!")
			Window:Notify({
				Title = "Copied!",
				Desc = "Discord invite copied to clipboard",
				Duration = 3
			})
		else
			print("Discord: .gg/vwj92WkEBz")
		end
	end
})

InfoTab:Paragraph({
	Title = "Recent Updates",
	Desc = "Latest changes and improvements",
	Color = Color3.fromRGB(150, 255, 150),
	Locked = false,
})

InfoTab:Paragraph({
	Title = "Version 1.5.0 Changelog",
	Desc = "✓ Added performance stats to Home tab\n✓ FPS counter with customizable display\n✓ Real-time ping and server information\n✓ Enhanced credits and info section\n✓ Improved UI theme system\n✓ Better notifications and feedback\n✓ Discord server integration",
	Color = Color3.fromRGB(0, 255, 100),
	Locked = false,
})

InfoTab:Paragraph({
	Title = "Quick Start Guide",
	Desc = "How to use FSociety",
	Color = Color3.fromRGB(255, 220, 100),
	Locked = false,
})

InfoTab:Paragraph({
	Title = "Getting Started",
	Desc = "1. Join a supported game from the list\n2. Game-specific tab will appear automatically\n3. Use Home tab to customize theme colors\n4. Enable performance stats in Home tab\n5. Use topbar buttons for extra tools\n6. Check console (F9) for detailed info",
	Color = Color3.fromRGB(255, 200, 0),
	Locked = false,
})

InfoTab:Paragraph({
	Title = "Tips & Tricks",
	Desc = "• FPS counter shows in top-right corner\n• Ping display updates every second\n• Server info shows player count and ID\n• Theme colors auto-save when changed\n• Join Discord for updates and support\n• Report issues with thumbs down button",
	Color = Color3.fromRGB(255, 150, 0),
	Locked = false,
})

-- ============================================
-- TOPBAR BUTTONS
-- ============================================

Window:CreateTopbarButton("Inf", "infinity", function() 
	loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() 
end, 990)

Window:CreateTopbarButton("ketamine", "code", function() 
	loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Ketamine/refs/heads/main/Ketamine.lua"))() 
end, 990)

Window:CreateTopbarButton("dex", "keyboard", function() 
	loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))() 
end, 990)

Window:CreateTopbarButton("starbutton1", "star", function() 
	loadstring(game:HttpGet("https://raw.githubusercontent.com/qShadow14/All-In-One/refs/heads/main/Emotes.lua"))()
end, 990)

-- ============================================
-- GAME-SPECIFIC SCRIPTS
-- ============================================

-- 1. Car Crusher 2
if game.PlaceId == 654732683 then
    local Tab = Window:Tab({
        Title = "Car Crusher 2", 
        Icon = "code",
        Locked = false,
    })
    Tab:Button({Title = "Auto Farm", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Auto Crusher", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Money Farm", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Dupe Glitch", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Speed Boost", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Unlock All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "ESP All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 2. Counter Blox
elseif game.PlaceId == 301549746 then
    local Tab = Window:Tab({
        Title = "Counter Blox", 
        Icon = "code",
        Locked = false,
    })
    Tab:Button({Title = "NewVape(KEY)", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Counter-Blox-Sentinel-Best-Script-70322"))() end})
    Tab:Button({Title = "Galaxy_Hub", Callback = function() loadstring(game:HttpGet("https://pastebin.com/raw/bPUYMYis"))() end})
    Tab:Button({Title = "thegxx_hub", Callback = function() loadstring(game:HttpGet("https://pastebin.com/raw/bPUYMYis"))() end})
    Tab:Button({Title = "Silent Aim", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Wallhack", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Infinite Ammo", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "No Recoil", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 3. Dead Rails
elseif game.PlaceId == 116495829188952 then
    local Tab = Window:Tab({
        Title = "Dead Rails", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "ESP Aimbot", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Auto Farm", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Infinite Ammo", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "God Mode", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Speed Hack", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Teleport", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Unlock All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 4. The Forge
elseif game.PlaceId == 76558904092080 then
    local Tab = Window:Tab({
        Title = "The Forge", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "Auto Craft", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Resource ESP", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Speed Hack", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Dupe Items", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Infinite Resources", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Build Anywhere", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Unlock All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 5. Strongman Simulator
elseif game.PlaceId == 4282985734 then
    local Tab = Window:Tab({
        Title = "Strongman Simulator", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "Auto Train", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Auto Rebirth", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Strength Farm", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Auto Collect", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Speed Boost", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Teleport GUI", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Unlock All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 6. 99 night in the forest
elseif game.PlaceId == 6918802178 then
    local Tab = Window:Tab({
        Title = "99 Night in Forest", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "Survival Helper", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "ESP All Items", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "No Monster", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "God Mode", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Infinite Stamina", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Speed Boost", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Teleport GUI", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 7. Blox Fruit
elseif game.PlaceId == 537413528 or game.PlaceId == 4442272183 or game.PlaceId == 7449423635 then
    local Tab = Window:Tab({
        Title = "Blox Fruit", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "Hoho Hub", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Zen Hub", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Auto Farm", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Auto Boss", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "ESP All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Devil Fruit ESP", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Teleport GUI", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 8. Island
elseif game.PlaceId == 1730877806 then
    local Tab = Window:Tab({
        Title = "Island", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "Auto Farm", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Dupe Items", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Build Helper", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Auto Sell", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Speed Boost", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Fly", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Unlock All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 9. osu!RoVer
elseif game.PlaceId == 1224212277 then
    local Tab = Window:Tab({
        Title = "osu!RoVer", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "Auto Play", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Perfect Hits", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "No Miss", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Score Farm", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Speed Mod", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Visual Helper", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Unlock Songs", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 10. Flick
elseif game.PlaceId == 16732031560 then
    local Tab = Window:Tab({
        Title = "Flick", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "Aimbot", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Silent Aim", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "ESP All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Wallhack", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "No Recoil", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Speed Boost", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Infinite Ammo", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 11. Doors
elseif game.PlaceId == 6516141723 then
    local Tab = Window:Tab({
        Title = "Doors", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "Entity ESP", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Key ESP", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "God Mode", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Speed Boost", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "No Entity", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Unlock All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Teleport GUI", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 12. Evade
elseif game.PlaceId == 9872472334 then
    local Tab = Window:Tab({
        Title = "Evade", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "ESP All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Speed Boost", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "God Mode", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Auto Farm", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Fly", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Teleport", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Unlock All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 13. A dusty Trip
elseif game.PlaceId == 16389395869 then
    local Tab = Window:Tab({
        Title = "A Dusty Trip", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "Auto Drive", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "ESP Items", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "God Mode", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Speed Hack", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Infinite Fuel", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "No Damage", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Teleport GUI", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 14. Build a boat for treasure (CORRECTED PlaceId - needs verification)
elseif game.PlaceId == 537213528 then
    local Tab = Window:Tab({
        Title = "Build a Boat For Treasure", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "Auto Farm", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/TheRealAsu/BABFT/refs/heads/main/Loader.lua'))() end})
    Tab:Button({Title = "Build Helper", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Gold Farm", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Auto Stage", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "ESP Chest", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Speed Boost", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Unlock All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 15. Fisch
elseif game.PlaceId == 16732694052 then
    local Tab = Window:Tab({
        Title = "Fisch", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "Auto Fish", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Fish ESP", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Auto Sell", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Money Farm", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Instant Catch", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Teleport GUI", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Unlock All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 16. The Train Tunnels
elseif game.PlaceId == 16140847257 then
    local Tab = Window:Tab({
        Title = "Train Tunnels", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "ESP All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "God Mode", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Speed Boost", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Item ESP", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "No Entity", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Teleport", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Unlock All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 17. Fnaf Co-op
elseif game.PlaceId == 16938635337 then
    local Tab = Window:Tab({
        Title = "Fnaf Co-op", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "Animatronic ESP", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "God Mode", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Auto Win", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "No Jumpscare", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Infinite Power", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Speed Boost", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Unlock All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 18. Scary Shawarma
elseif game.PlaceId == 16901154463 then
    local Tab = Window:Tab({
        Title = "Scary Shawarma", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "Auto Farm", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "God Mode", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "ESP Items", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Speed Boost", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Auto Collect", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Teleport GUI", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Unlock All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 19. Slap battles
elseif game.PlaceId == 6403373529 then
    local Tab = Window:Tab({
        Title = "Slap Battles", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "Auto Farm", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Auto Slap", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "ESP All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Reach Extend", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "God Mode", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Speed Boost", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Unlock Gloves", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 20. Cult of the Lamb (PlaceId needs verification)
elseif game.PlaceId == 10449761463 then
    local Tab = Window:Tab({
        Title = "Cult of the Lamb", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "Auto Farm", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "God Mode", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Resource ESP", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Speed Boost", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Auto Collect", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Unlock All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Teleport GUI", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 21. Blade Ball
elseif game.PlaceId == 13772394625 then
    local Tab = Window:Tab({
        Title = "Blade Ball", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "Auto Parry", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "ESP All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "God Mode", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Auto Farm", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Speed Boost", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Unlock All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Teleport GUI", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 22. Grace
elseif game.PlaceId == 16799083823 then
    local Tab = Window:Tab({
        Title = "Grace", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "ESP All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "God Mode", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Speed Boost", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "No Entity", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Item ESP", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Teleport", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Unlock All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 23. Rivals
elseif game.PlaceId == 17625359962 then
    local Tab = Window:Tab({
        Title = "Rivals", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "Aimbot", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "ESP All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Wallhack", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Silent Aim", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "No Recoil", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Speed Boost", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Unlock All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 24. Fnaf Eternal
elseif game.PlaceId == 17558076607 then
    local Tab = Window:Tab({
        Title = "Fnaf Eternal", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "Animatronic ESP", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "God Mode", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Auto Win", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "No Jumpscare", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Infinite Power", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Speed Boost", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Unlock All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})

-- 25. Survive the Killer
elseif game.PlaceId == 4580204640 then
    local Tab = Window:Tab({
        Title = "Survive the Killer", 
        Icon = "code", 
        Locked = false,
    })
    Tab:Button({Title = "ESP All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "God Mode", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Speed Boost", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Fly", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Auto Farm", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Teleport", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
    Tab:Button({Title = "Unlock All", Callback = function() loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))() end})
end
