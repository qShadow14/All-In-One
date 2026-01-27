local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
Junkie.service = "FSociety"
Junkie.identifier = "1006951"
Junkie.provider = "FSociety"

local result = (function()
    getgenv().UI_CLOSED = false
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local Lighting = game:GetService("Lighting")
    
    -- FSociety Red Theme Colors (matching loading screen)
    local Colors = {
        background = Color3.fromRGB(45, 48, 63),
        surface = Color3.fromRGB(30, 33, 45),
        surfaceLight = Color3.fromRGB(38, 41, 53),
        primary = Color3.fromRGB(220, 53, 69),
        primaryDark = Color3.fromRGB(180, 33, 49),
        primaryGlow = Color3.fromRGB(255, 100, 100),
        accent = Color3.fromRGB(220, 53, 69),
        success = Color3.fromRGB(220, 53, 69),
        successDark = Color3.fromRGB(180, 33, 49),
        successGlow = Color3.fromRGB(255, 100, 100),
        error = Color3.fromRGB(180, 33, 49),
        textPrimary = Color3.fromRGB(230, 237, 243),
        textSecondary = Color3.fromRGB(139, 148, 158),
        textMuted = Color3.fromRGB(110, 118, 129),
        border = Color3.fromRGB(30, 30, 40),
        borderLight = Color3.fromRGB(63, 71, 79),
        glass = Color3.fromRGB(255, 255, 255),
        neonRed = Color3.fromRGB(220, 53, 69),
        darkRed = Color3.fromRGB(180, 33, 49)
    }
    
    local function hasFileSystemSupport()
        local hasWritefile = pcall(function() return type(writefile) == "function" end)
        local hasReadfile = pcall(function() return type(readfile) == "function" end)
        local hasIsfile = pcall(function() return type(isfile) == "function" end)
        return hasWritefile and hasReadfile and hasIsfile
    end
    
    local fileSystemSupported = hasFileSystemSupport()
    
    local function saveVerifiedKey(key)
        if not fileSystemSupported then return false end
        local ok = pcall(function()
            writefile("verified_key.txt", key)
        end)
        return ok
    end
    
    local function loadVerifiedKey()
        if not fileSystemSupported then 
            return nil 
        end
        
        local ok, content = pcall(function()
            return readfile("verified_key.txt")
        end)
        
        if not ok or not content then 
            return nil 
        end
        return content
    end
    
    local function clearSavedKey()
        if not fileSystemSupported then return false end
        local ok = pcall(function() delfile("verified_key.txt") end)
        return ok
    end

    -- Loading Screen Function (UNCHANGED)
    local function showLoadingScreen()
        local player = Players.LocalPlayer
        local playerGui = player:WaitForChild("PlayerGui")

        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "FSocietyLoader"
        screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        screenGui.ResetOnSpawn = false
        screenGui.IgnoreGuiInset = true
        screenGui.Parent = playerGui

        local screen1 = Instance.new("Frame")
        screen1.Name = "Screen1"
        screen1.Size = UDim2.new(0, 400, 0, 250)
        screen1.Position = UDim2.new(0.5, -200, 0.5, -125)
        screen1.BackgroundColor3 = Color3.fromRGB(45, 48, 63)
        screen1.BorderSizePixel = 0
        screen1.Parent = screenGui

        local corner1 = Instance.new("UICorner")
        corner1.CornerRadius = UDim.new(0, 8)
        corner1.Parent = screen1

        local loadingBarBg = Instance.new("Frame")
        loadingBarBg.Name = "LoadingBarBg"
        loadingBarBg.Size = UDim2.new(1, 0, 0, 3)
        loadingBarBg.Position = UDim2.new(0, 0, 0, 0)
        loadingBarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        loadingBarBg.BorderSizePixel = 0
        loadingBarBg.Parent = screen1

        local loadingBarFill = Instance.new("Frame")
        loadingBarFill.Name = "LoadingBarFill"
        loadingBarFill.Size = UDim2.new(0, 0, 1, 0)
        loadingBarFill.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
        loadingBarFill.BorderSizePixel = 0
        loadingBarFill.Parent = loadingBarBg

        local letterF = Instance.new("TextLabel")
        letterF.Name = "LetterF"
        letterF.Size = UDim2.new(0, 150, 0, 180)
        letterF.Position = UDim2.new(0.5, -75, 0.5, -90)
        letterF.BackgroundTransparency = 1
        letterF.Text = "F"
        letterF.Font = Enum.Font.GothamBold
        letterF.TextSize = 140
        letterF.TextColor3 = Color3.fromRGB(220, 53, 69)
        letterF.TextScaled = false
        letterF.TextTransparency = 0
        letterF.TextStrokeTransparency = 1
        letterF.TextStrokeColor3 = Color3.fromRGB(255, 100, 100)
        letterF.ZIndex = 10
        letterF.Parent = screenGui

        local screen2 = Instance.new("Frame")
        screen2.Name = "Screen2"
        screen2.Size = UDim2.new(1, 0, 1, 0)
        screen2.Position = UDim2.new(0, 0, 0, 0)
        screen2.BackgroundTransparency = 1
        screen2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        screen2.BorderSizePixel = 0
        screen2.Visible = false
        screen2.ZIndex = 1
        screen2.Parent = screenGui

        local blurEffect = Instance.new("BlurEffect")
        blurEffect.Size = 15
        blurEffect.Parent = Lighting
        blurEffect.Name = "FSocietyBlur"

        local textContainer = Instance.new("Frame")
        textContainer.Name = "TextContainer"
        textContainer.Size = UDim2.new(1, 0, 0, 300)
        textContainer.Position = UDim2.new(0, 0, 0.5, -150)
        textContainer.BackgroundTransparency = 1
        textContainer.ZIndex = 5
        textContainer.Parent = screen2

        local fullText = "FSOCIETY"
        local letters = {}
        local letterWidth = 110
        local letterSpacing = 15
        local totalWidth = (#fullText * letterWidth) + ((#fullText - 1) * letterSpacing)

        for i = 2, #fullText do
            local letter = Instance.new("TextLabel")
            letter.Name = "Letter" .. i
            letter.Size = UDim2.new(0, letterWidth, 0, 150)
            local xOffset = -totalWidth / 2 + (i - 1) * (letterWidth + letterSpacing)
            letter.Position = UDim2.new(0.5, xOffset, 0.5, 250)
            letter.BackgroundTransparency = 1
            letter.Text = fullText:sub(i, i)
            letter.Font = Enum.Font.GothamBold
            letter.TextSize = 120
            letter.TextColor3 = Color3.fromRGB(220, 53, 69)
            letter.TextStrokeTransparency = 0.3
            letter.TextStrokeColor3 = Color3.fromRGB(255, 100, 100)
            letter.ZIndex = 10
            letter.Parent = textContainer
            letter.TextTransparency = 1
            letters[i] = letter
        end

        local function animateScreen1()
            spawn(function()
                while screen1.Visible do
                    local glowUp = TweenService:Create(letterF, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextStrokeTransparency = 0})
                    glowUp:Play()
                    glowUp.Completed:Wait()
                    wait(0.3)
                    local glowDown = TweenService:Create(letterF, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextStrokeTransparency = 1})
                    glowDown:Play()
                    glowDown.Completed:Wait()
                    wait(0.3)
                end
            end)

            local loadTween = TweenService:Create(loadingBarFill, TweenInfo.new(4, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)})
            loadTween:Play()
            return loadTween
        end

        local function transitionToScreen2()
            local fadeTween = TweenService:Create(screen1, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
            fadeTween:Play()
            TweenService:Create(loadingBarBg, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
            TweenService:Create(loadingBarFill, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
            fadeTween.Completed:Wait()

            screen2.Visible = true
            local colorChange = TweenService:Create(letterF, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextStrokeTransparency = 0.3, TextSize = 120})
            colorChange:Play()
            colorChange.Completed:Wait()

            local firstLetterXOffset = -totalWidth / 2
            local moveF = TweenService:Create(letterF, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, firstLetterXOffset, 0.5, -75), Size = UDim2.new(0, letterWidth, 0, 150)})
            moveF:Play()

            if Lighting:FindFirstChild("FSocietyBlur") then
                local blurTween = TweenService:Create(Lighting.FSocietyBlur, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 15})
                Lighting.FSocietyBlur.Size = 0
                blurTween:Play()
            end

            return moveF
        end

        local function animateLetters()
            for i = 2, #fullText do
                local letter = letters[i]
                if letter then
                    wait(0.08)
                    local xOffset = -totalWidth / 2 + (i - 1) * (letterWidth + letterSpacing)
                    local slideUp = TweenService:Create(letter, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, xOffset, 0.5, -75)})
                    local fadeIn = TweenService:Create(letter, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0})
                    slideUp:Play()
                    fadeIn:Play()
                end
            end
        end

        local function fadeOutEverything()
            wait(1.5)
            local fadeInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

            if Lighting:FindFirstChild("FSocietyBlur") then
                TweenService:Create(Lighting.FSocietyBlur, fadeInfo, {Size = 0}):Play()
            end

            TweenService:Create(letterF, fadeInfo, {TextTransparency = 1}):Play()

            for _, item in pairs(screen2:GetDescendants()) do
                if item:IsA("TextLabel") then
                    TweenService:Create(item, fadeInfo, {TextTransparency = 1}):Play()
                elseif item:IsA("ImageLabel") then
                    TweenService:Create(item, fadeInfo, {ImageTransparency = 1}):Play()
                elseif item:IsA("Frame") then
                    TweenService:Create(item, fadeInfo, {BackgroundTransparency = 1}):Play()
                end
            end

            wait(0.8)

            if Lighting:FindFirstChild("FSocietyBlur") then
                Lighting.FSocietyBlur:Destroy()
            end

            screenGui:Destroy()
        end

        spawn(function()
            wait(0.2)
            local loadTween = animateScreen1()
            loadTween.Completed:Wait()
            wait(0.3)
            local moveTween = transitionToScreen2()
            moveTween.Completed:Wait()
            wait(0.2)
            animateLetters()
            fadeOutEverything()
            wait(3)

            print("[FSociety] Loading main script...")
            local success, err = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/qShadow14/FSociety/refs/heads/main/FSociety-Main.lua"))()
            end)

            if not success then
                warn("[FSociety] Failed to load main script:", err)
            else
                print("[FSociety] Main script loaded successfully!")
            end
        end)
    end

    local function loadUIFactory()
        return function(Colors, Players, TweenService, UserInputService, Lighting)
        local IconAssets = {
            shield = 84528813312016,
            x = 73070135088117,
            key = 128426502701541,
            link = 73034596791310,
            check = 83827110621355
        }
        
        local function createIconImage(name, size, color)
            local id = IconAssets[name]
            if id then
                local img = Instance.new("ImageLabel")
                img.BackgroundTransparency = 1
                img.Size = UDim2.new(0, size or 18, 0, size or 18)
                img.Image = "rbxassetid://" .. tostring(id)
                img.ImageColor3 = color or Color3.fromRGB(255, 255, 255)
                img.ScaleType = Enum.ScaleType.Fit
                if img:IsA("ImageLabel") and img.ResampleMode ~= nil then
                    img.ResampleMode = Enum.ResamplerMode.Default
                end
                return img
            end

            local lbl = Instance.new("TextLabel")
            lbl.BackgroundTransparency = 1
            lbl.Size = UDim2.new(0, size or 18, 0, size or 18)
            lbl.TextScaled = true
            lbl.Font = Enum.Font.SourceSansBold
            lbl.TextColor3 = color or Color3.fromRGB(255, 255, 255)
            lbl.Text = ({ shield = "🛡️", key = "🔑", link = "🔗", x = "✕", check = "✓" })[name] or "🔘"
            return lbl
        end
        
        return function(self)
            if self.gui then
                self.gui:Destroy()
            end
            
            self.gui = Instance.new("ScreenGui")
            self.gui.Name = "FSocietyKeySystem"
            self.gui.ResetOnSpawn = false
            self.gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            self.gui.IgnoreGuiInset = true
            
            local backdrop = Instance.new("Frame")
            backdrop.Name = "Backdrop"
            backdrop.Size = UDim2.new(1, 0, 1, 0)
            backdrop.Position = UDim2.new(0, 0, 0, 0)
            backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            backdrop.BackgroundTransparency = 0.4
            backdrop.BorderSizePixel = 0
            backdrop.Parent = self.gui
            
            local blur = Instance.new("BlurEffect")
            blur.Size = 16
            blur.Name = "FSocietyKeyBlur"
            blur.Parent = Lighting
            
            local container = Instance.new("Frame")
            container.Name = "Container"
            container.Size = UDim2.new(0, 700, 0, 420)
            container.Position = UDim2.new(0.5, -350, 0.5, -210)
            container.BackgroundColor3 = Colors.background
            container.BorderSizePixel = 0
            container.Parent = backdrop
            
            local containerCorner = Instance.new("UICorner")
            containerCorner.CornerRadius = UDim.new(0, 8)
            containerCorner.Parent = container
            
            -- Left Panel (User Details)
            local leftPanel = Instance.new("Frame")
            leftPanel.Name = "LeftPanel"
            leftPanel.Size = UDim2.new(0, 280, 1, 0)
            leftPanel.Position = UDim2.new(0, 0, 0, 0)
            leftPanel.BackgroundColor3 = Colors.surface
            leftPanel.BorderSizePixel = 0
            leftPanel.Parent = container
            
            local leftCorner = Instance.new("UICorner")
            leftCorner.CornerRadius = UDim.new(0, 8)
            leftCorner.Parent = leftPanel
            
            local divider = Instance.new("Frame")
            divider.Name = "Divider"
            divider.Size = UDim2.new(0, 2, 1, 0)
            divider.Position = UDim2.new(0, 280, 0, 0)
            divider.BackgroundColor3 = Colors.border
            divider.BorderSizePixel = 0
            divider.Parent = container
            
            -- User Info Section
            local userInfoContainer = Instance.new("Frame")
            userInfoContainer.Name = "UserInfoContainer"
            userInfoContainer.Size = UDim2.new(1, -30, 0, 350)
            userInfoContainer.Position = UDim2.new(0, 15, 0, 50)
            userInfoContainer.BackgroundTransparency = 1
            userInfoContainer.Parent = leftPanel
            
            local userTitle = Instance.new("TextLabel")
            userTitle.Name = "UserTitle"
            userTitle.Size = UDim2.new(1, 0, 0, 30)
            userTitle.Position = UDim2.new(0, 0, 0, 0)
            userTitle.BackgroundTransparency = 1
            userTitle.Text = "USER DETAILS"
            userTitle.TextColor3 = Colors.primary
            userTitle.TextSize = 14
            userTitle.Font = Enum.Font.GothamBold
            userTitle.TextXAlignment = Enum.TextXAlignment.Left
            userTitle.Parent = userInfoContainer
            
            -- Get user info
            local player = Players.LocalPlayer
            local username = player.Name
            local displayName = player.DisplayName
            local userId = tostring(player.UserId)
            local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
            
            local function createInfoRow(label, value, yPos)
                local rowFrame = Instance.new("Frame")
                rowFrame.Size = UDim2.new(1, 0, 0, 50)
                rowFrame.Position = UDim2.new(0, 0, 0, yPos)
                rowFrame.BackgroundTransparency = 1
                rowFrame.Parent = userInfoContainer
                
                local labelText = Instance.new("TextLabel")
                labelText.Size = UDim2.new(1, 0, 0, 16)
                labelText.Position = UDim2.new(0, 0, 0, 0)
                labelText.BackgroundTransparency = 1
                labelText.Text = label
                labelText.TextColor3 = Colors.textMuted
                labelText.TextSize = 11
                labelText.Font = Enum.Font.Gotham
                labelText.TextXAlignment = Enum.TextXAlignment.Left
                labelText.Parent = rowFrame
                
                local valueText = Instance.new("TextLabel")
                valueText.Size = UDim2.new(1, 0, 0, 20)
                valueText.Position = UDim2.new(0, 0, 0, 18)
                valueText.BackgroundTransparency = 1
                valueText.Text = value
                valueText.TextColor3 = Colors.textPrimary
                valueText.TextSize = 13
                valueText.Font = Enum.Font.GothamMedium
                valueText.TextXAlignment = Enum.TextXAlignment.Left
                valueText.TextTruncate = Enum.TextTruncate.AtEnd
                valueText.Parent = rowFrame
                
                return rowFrame
            end
            
            createInfoRow("USERNAME", username, 40)
            createInfoRow("DISPLAY NAME", displayName, 95)
            createInfoRow("USER ID", userId, 150)
            createInfoRow("HWID", hwid:sub(1, 20) .. "...", 205)
            
            -- Status indicator at bottom
            local statusIndicator = Instance.new("Frame")
            statusIndicator.Name = "StatusIndicator"
            statusIndicator.Size = UDim2.new(1, -30, 0, 60)
            statusIndicator.Position = UDim2.new(0, 15, 1, -70)
            statusIndicator.BackgroundColor3 = Colors.surfaceLight
            statusIndicator.BorderSizePixel = 0
            statusIndicator.Parent = leftPanel
            
            local statusCorner = Instance.new("UICorner")
            statusCorner.CornerRadius = UDim.new(0, 6)
            statusCorner.Parent = statusIndicator
            
            local statusDot = Instance.new("Frame")
            statusDot.Size = UDim2.new(0, 8, 0, 8)
            statusDot.Position = UDim2.new(0, 12, 0, 26)
            statusDot.BackgroundColor3 = Colors.primary
            statusDot.BorderSizePixel = 0
            statusDot.Parent = statusIndicator
            
            local statusDotCorner = Instance.new("UICorner")
            statusDotCorner.CornerRadius = UDim.new(1, 0)
            statusDotCorner.Parent = statusDot
            
            local statusLabel = Instance.new("TextLabel")
            statusLabel.Size = UDim2.new(1, -35, 0, 16)
            statusLabel.Position = UDim2.new(0, 28, 0, 15)
            statusLabel.BackgroundTransparency = 1
            statusLabel.Text = "SYSTEM STATUS"
            statusLabel.TextColor3 = Colors.textMuted
            statusLabel.TextSize = 10
            statusLabel.Font = Enum.Font.Gotham
            statusLabel.TextXAlignment = Enum.TextXAlignment.Left
            statusLabel.Parent = statusIndicator
            
            local statusValue = Instance.new("TextLabel")
            statusValue.Size = UDim2.new(1, -35, 0, 18)
            statusValue.Position = UDim2.new(0, 28, 0, 30)
            statusValue.BackgroundTransparency = 1
            statusValue.Text = "Awaiting Verification"
            statusValue.TextColor3 = Colors.textPrimary
            statusValue.TextSize = 12
            statusValue.Font = Enum.Font.GothamMedium
            statusValue.TextXAlignment = Enum.TextXAlignment.Left
            statusValue.Parent = statusIndicator
            
            -- Pulsing animation for status dot
            spawn(function()
                while statusDot and statusDot.Parent do
                    TweenService:Create(statusDot, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        BackgroundTransparency = 0.3
                    }):Play()
                    wait(1)
                    TweenService:Create(statusDot, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        BackgroundTransparency = 0
                    }):Play()
                    wait(1)
                end
            end)
            
            local loadingBarBg = Instance.new("Frame")
            loadingBarBg.Name = "LoadingBarBg"
            loadingBarBg.Size = UDim2.new(0, 420, 0, 3)
            loadingBarBg.Position = UDim2.new(0, 280, 0, 0)
            loadingBarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            loadingBarBg.BorderSizePixel = 0
            loadingBarBg.Parent = container
            
            local loadingBarFill = Instance.new("Frame")
            loadingBarFill.Name = "LoadingBarFill"
            loadingBarFill.Size = UDim2.new(0, 0, 1, 0)
            loadingBarFill.BackgroundColor3 = Colors.primary
            loadingBarFill.BorderSizePixel = 0
            loadingBarFill.Parent = loadingBarBg
            
            spawn(function()
                TweenService:Create(loadingBarFill, TweenInfo.new(2, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)}):Play()
            end)
            
            local closeButton = Instance.new("TextButton")
            closeButton.Name = "CloseButton"
            closeButton.Size = UDim2.new(0, 30, 0, 30)
            closeButton.Position = UDim2.new(1, -40, 0, 10)
            closeButton.BackgroundColor3 = Colors.error
            closeButton.BackgroundTransparency = 0.8
            closeButton.BorderSizePixel = 0
            closeButton.Text = ""
            closeButton.AutoButtonColor = false
            closeButton.ZIndex = 11
            closeButton.Parent = container
            
            local closeCorner = Instance.new("UICorner")
            closeCorner.CornerRadius = UDim.new(0, 8)
            closeCorner.Parent = closeButton

            local closeIcon = createIconImage("x", 16, Colors.textPrimary)
            closeIcon.AnchorPoint = Vector2.new(0.5, 0.5)
            closeIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
            closeIcon.ZIndex = 12
            closeIcon.Parent = closeButton
            
            local logoText = Instance.new("TextLabel")
            logoText.Name = "LogoText"
            logoText.Size = UDim2.new(0, 300, 0, 60)
            logoText.Position = UDim2.new(0, 340, 0, 25)
            logoText.BackgroundTransparency = 1
            logoText.Text = "FSOCIETY"
            logoText.Font = Enum.Font.GothamBold
            logoText.TextSize = 32
            logoText.TextColor3 = Colors.primary
            logoText.TextStrokeTransparency = 0.3
            logoText.TextStrokeColor3 = Colors.primaryGlow
            logoText.Parent = container
            
            local subtitleText = Instance.new("TextLabel")
            subtitleText.Name = "SubtitleText"
            subtitleText.Size = UDim2.new(0, 380, 0, 20)
            subtitleText.Position = UDim2.new(0, 300, 0, 85)
            subtitleText.BackgroundTransparency = 1
            subtitleText.Text = "KEY VERIFICATION SYSTEM"
            subtitleText.TextColor3 = Colors.textSecondary
            subtitleText.TextSize = 13
            subtitleText.TextXAlignment = Enum.TextXAlignment.Center
            subtitleText.Font = Enum.Font.Gotham
            subtitleText.Parent = container
            
            local inputSection = Instance.new("Frame")
            inputSection.Name = "InputSection"
            inputSection.Size = UDim2.new(0, 360, 0, 50)
            inputSection.Position = UDim2.new(0, 310, 0, 150)
            inputSection.BackgroundColor3 = Colors.surfaceLight
            inputSection.BorderSizePixel = 0
            inputSection.Parent = container
            
            local inputCorner = Instance.new("UICorner")
            inputCorner.CornerRadius = UDim.new(0, 10)
            inputCorner.Parent = inputSection
            
            local inputStroke = Instance.new("UIStroke")
            inputStroke.Color = Colors.border
            inputStroke.Thickness = 1
            inputStroke.Transparency = 0.5
            inputStroke.Parent = inputSection
            
            local keyIcon = createIconImage("key", 18, Colors.primary)
            keyIcon.AnchorPoint = Vector2.new(0, 0.5)
            keyIcon.Position = UDim2.new(0, 14, 0.5, 0)
            keyIcon.Parent = inputSection
            
            local keyInput = Instance.new("TextBox")
            keyInput.Name = "KeyInput"
            keyInput.Size = UDim2.new(1, -50, 1, 0)
            keyInput.Position = UDim2.new(0, 40, 0, 0)
            keyInput.BackgroundTransparency = 1
            keyInput.PlaceholderText = "Enter your verification key"
            keyInput.PlaceholderColor3 = Colors.textMuted
            keyInput.Text = ""
            keyInput.TextColor3 = Colors.textPrimary
            keyInput.TextSize = 14
            keyInput.TextXAlignment = Enum.TextXAlignment.Left
            keyInput.TextTruncate = Enum.TextTruncate.AtEnd
            keyInput.Font = Enum.Font.Gotham
            keyInput.ClearTextOnFocus = false
            keyInput.Parent = inputSection
            
            local buttonSection = Instance.new("Frame")
            buttonSection.Name = "ButtonSection"
            buttonSection.Size = UDim2.new(0, 360, 0, 46)
            buttonSection.Position = UDim2.new(0, 310, 0, 220)
            buttonSection.BackgroundTransparency = 1
            buttonSection.Parent = container
            
            local getLinkButton = Instance.new("TextButton")
            getLinkButton.Name = "GetLinkButton"
            getLinkButton.Size = UDim2.new(0.48, 0, 1, 0)
            getLinkButton.Position = UDim2.new(0, 0, 0, 0)
            getLinkButton.BackgroundColor3 = Colors.primary
            getLinkButton.Text = ""
            getLinkButton.Font = Enum.Font.GothamSemibold
            getLinkButton.TextSize = 14
            getLinkButton.BorderSizePixel = 0
            getLinkButton.AutoButtonColor = false
            getLinkButton.Parent = buttonSection

            local getLinkCorner = Instance.new("UICorner")
            getLinkCorner.CornerRadius = UDim.new(0, 10)
            getLinkCorner.Parent = getLinkButton

            local getLinkIcon = createIconImage("link", 16, Color3.fromRGB(255, 255, 255))
            getLinkIcon.AnchorPoint = Vector2.new(0, 0.5)
            getLinkIcon.Position = UDim2.new(0, 12, 0.5, 0)
            getLinkIcon.Parent = getLinkButton

            local getLinkText = Instance.new("TextLabel")
            getLinkText.Name = "ButtonText"
            getLinkText.Size = UDim2.new(1, 0, 1, 0)
            getLinkText.Position = UDim2.new(0, 0, 0, 0)
            getLinkText.BackgroundTransparency = 1
            getLinkText.Text = "Get Link"
            getLinkText.TextColor3 = Color3.fromRGB(255, 255, 255)
            getLinkText.Font = Enum.Font.GothamSemibold
            getLinkText.TextSize = 14
            getLinkText.TextXAlignment = Enum.TextXAlignment.Center
            getLinkText.Parent = getLinkButton

            local verifyButton = Instance.new("TextButton")
            verifyButton.Name = "VerifyButton"
            verifyButton.Size = UDim2.new(0.48, 0, 1, 0)
            verifyButton.Position = UDim2.new(0.52, 0, 0, 0)
            verifyButton.BackgroundColor3 = Colors.success
            verifyButton.BorderSizePixel = 0
            verifyButton.Text = ""
            verifyButton.TextSize = 14
            verifyButton.Font = Enum.Font.GothamSemibold
            verifyButton.AutoButtonColor = false
            verifyButton.Parent = buttonSection

            local verifyCorner = Instance.new("UICorner")
            verifyCorner.CornerRadius = UDim.new(0, 10)
            verifyCorner.Parent = verifyButton

            local verifyIcon = createIconImage("check", 16, Color3.fromRGB(255, 255, 255))
            verifyIcon.AnchorPoint = Vector2.new(0, 0.5)
            verifyIcon.Position = UDim2.new(0, 12, 0.5, 0)
            verifyIcon.Parent = verifyButton

            local verifyText = Instance.new("TextLabel")
            verifyText.Name = "ButtonText"
            verifyText.Size = UDim2.new(1, 0, 1, 0)
            verifyText.Position = UDim2.new(0, 0, 0, 0)
            verifyText.BackgroundTransparency = 1
            verifyText.Text = "Verify Key"
            verifyText.TextColor3 = Color3.fromRGB(255, 255, 255)
            verifyText.Font = Enum.Font.GothamSemibold
            verifyText.TextSize = 14
            verifyText.TextXAlignment = Enum.TextXAlignment.Center
            verifyText.Parent = verifyButton
            
            local statusText = Instance.new("TextLabel")
            statusText.Name = "StatusText"
            statusText.BackgroundTransparency = 1
            statusText.Text = ""
            statusText.TextColor3 = Colors.textSecondary
            statusText.Font = Enum.Font.Gotham
            statusText.TextSize = 12
            statusText.TextXAlignment = Enum.TextXAlignment.Center
            statusText.Size = UDim2.new(0, 360, 0, 20)
            statusText.Position = UDim2.new(0, 310, 0, 290)
            statusText.Visible = false
            statusText.Parent = container
            
            local statusBar = Instance.new("Frame")
            statusBar.Name = "StatusBar"
            statusBar.Size = UDim2.new(0, 360, 0, 2)
            statusBar.Position = UDim2.new(0, 310, 1, -20)
            statusBar.BackgroundColor3 = Colors.border
            statusBar.BorderSizePixel = 0
            statusBar.Parent = container

            self.elements = {
                backdrop = backdrop,
                container = container,
                leftPanel = leftPanel,
                userInfoContainer = userInfoContainer,
                statusIndicator = statusIndicator,
                brandLogo = logoText,
                title = logoText,
                subtitle = subtitleText,
                getLinkButton = getLinkButton,
                inputContainer = inputSection,
                inputFrame = inputSection,
                keyInput = keyInput,
                verifyButton = verifyButton,
                statusBar = statusBar,
                statusText = statusText,
                inputStroke = inputStroke,
                closeButton = closeButton,
                loadingBarFill = loadingBarFill,
                buttonSection = buttonSection
            }
            
            local function setupAnimations()
                if closeButton then
                    closeButton.MouseEnter:Connect(function()
                        TweenService:Create(closeButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
                    end)
                    
                    closeButton.MouseLeave:Connect(function()
                        TweenService:Create(closeButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.8}):Play()
                    end)
                end
                
                if getLinkButton then
                    getLinkButton.MouseEnter:Connect(function()
                        TweenService:Create(getLinkButton, TweenInfo.new(0.2), {
                            BackgroundColor3 = Colors.primaryGlow,
                            Size = UDim2.new(0.48, 2, 1, 2),
                            Position = UDim2.new(0, -1, 0, -1)
                        }):Play()
                    end)
                    
                    getLinkButton.MouseLeave:Connect(function()
                        TweenService:Create(getLinkButton, TweenInfo.new(0.2), {
                            BackgroundColor3 = Colors.primary,
                            Size = UDim2.new(0.48, 0, 1, 0),
                            Position = UDim2.new(0, 0, 0, 0)
                        }):Play()
                    end)
                end
                
                if verifyButton then
                    verifyButton.MouseEnter:Connect(function()
                        TweenService:Create(verifyButton, TweenInfo.new(0.2), {
                            BackgroundColor3 = Colors.successGlow,
                            Size = UDim2.new(0.48, 2, 1, 2),
                            Position = UDim2.new(0.52, -1, 0, -1)
                        }):Play()
                    end)
                    
                    verifyButton.MouseLeave:Connect(function()
                        TweenService:Create(verifyButton, TweenInfo.new(0.2), {
                            BackgroundColor3 = Colors.success,
                            Size = UDim2.new(0.48, 0, 1, 0),
                            Position = UDim2.new(0.52, 0, 0, 0)
                        }):Play()
                    end)
                end
                
                if keyInput and inputStroke then
                    keyInput.Focused:Connect(function()
                        TweenService:Create(inputStroke, TweenInfo.new(0.2), {
                            Color = Colors.primary,
                            Thickness = 2,
                            Transparency = 0
                        }):Play()
                    end)
                    
                    keyInput.FocusLost:Connect(function()
                        TweenService:Create(inputStroke, TweenInfo.new(0.2), {
                            Color = Colors.border,
                            Thickness = 1,
                            Transparency = 0.5
                        }):Play()
                    end)
                end
            end
            
            self.gui.Parent = game:GetService("CoreGui")
            
            self.gui.AncestryChanged:Connect(function(_, parent)
                if parent == nil then
                    local blur = Lighting:FindFirstChild("FSocietyKeyBlur")
                    if blur then blur:Destroy() end
                end
            end)
            
            self.showSuccess = function(self, message)
                if not self.elements then return end
                self:updateStatus(message or "Verified!", Colors.success, 0)
                task.wait(0.8)
            end
            
            self.updateStatus = function(self, message, color, duration)
                local statusText = self.elements.statusText
                local statusBar = self.elements.statusBar
                
                if statusText then
                    statusText.Text = message
                    statusText.TextColor3 = color or Colors.textSecondary
                    statusText.Visible = true
                    
                    if statusBar then
                        TweenService:Create(statusBar, TweenInfo.new(0.2), {
                            BackgroundColor3 = color or Colors.border,
                            Size = UDim2.new(0, 360, 0, 3)
                        }):Play()
                    end
                    
                    if duration and duration > 0 then
                        task.delay(duration, function()
                            if statusText and statusText.Text == message then
                                statusText.Visible = false
                                if statusBar then
                                    TweenService:Create(statusBar, TweenInfo.new(0.2), {
                                        BackgroundColor3 = Colors.border,
                                        Size = UDim2.new(0, 360, 0, 2)
                                    }):Play()
                                end
                            end
                        end)
                    end
                end
            end
            
            self.shakeInput = function(self)
                local frame = self.elements.inputFrame
                if not frame then return end
                
                local orig = frame.Position
                
                for i = 1, 3 do
                    TweenService:Create(frame, TweenInfo.new(0.05), {
                        Position = UDim2.new(orig.X.Scale, orig.X.Offset - 8, orig.Y.Scale, orig.Y.Offset)
                    }):Play()
                    task.wait(0.05)
                    TweenService:Create(frame, TweenInfo.new(0.05), {
                        Position = UDim2.new(orig.X.Scale, orig.X.Offset + 8, orig.Y.Scale, orig.Y.Offset)
                    }):Play()
                    task.wait(0.05)
                end
                
                frame.Position = orig
            end
            
            -- SMOOTH TRANSITION ANIMATION
            self.smoothTransition = function(self)
                if not self.gui or not self.elements then return end
                
                local container = self.elements.container
                local backdrop = self.elements.backdrop
                local blur = Lighting:FindFirstChild("FSocietyKeyBlur")
                
                -- Stage 1: Fade out status (0.25s)
                if self.elements.statusText and self.elements.statusBar then
                    TweenService:Create(self.elements.statusText, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        TextTransparency = 1
                    }):Play()
                    TweenService:Create(self.elements.statusBar, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        BackgroundTransparency = 1
                    }):Play()
                end
                
                wait(0.1)
                
                -- Stage 2: Slide out and fade buttons (0.4s)
                if self.elements.buttonSection then
                    for _, child in pairs(self.elements.buttonSection:GetChildren()) do
                        if child:IsA("TextButton") then
                            TweenService:Create(child, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                                BackgroundTransparency = 1,
                                Position = UDim2.new(child.Position.X.Scale, child.Position.X.Offset, 0, 50)
                            }):Play()
                            
                            for _, descendant in pairs(child:GetDescendants()) do
                                if descendant:IsA("TextLabel") then
                                    TweenService:Create(descendant, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
                                elseif descendant:IsA("ImageLabel") then
                                    TweenService:Create(descendant, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
                                end
                            end
                        end
                    end
                end
                
                wait(0.15)
                
                -- Stage 3: Slide out input section and left panel content (0.4s)
                if self.elements.inputFrame then
                    TweenService:Create(self.elements.inputFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 310, 0, 120)
                    }):Play()
                    
                    for _, child in pairs(self.elements.inputFrame:GetDescendants()) do
                        if child:IsA("TextBox") or child:IsA("TextLabel") then
                            TweenService:Create(child, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
                        elseif child:IsA("ImageLabel") then
                            TweenService:Create(child, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
                        elseif child:IsA("UIStroke") then
                            TweenService:Create(child, TweenInfo.new(0.3), {Transparency = 1}):Play()
                        end
                    end
                end
                
                -- Fade left panel content
                if self.elements.userInfoContainer then
                    for _, child in pairs(self.elements.userInfoContainer:GetDescendants()) do
                        if child:IsA("TextLabel") then
                            TweenService:Create(child, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
                        end
                    end
                end
                
                if self.elements.statusIndicator then
                    TweenService:Create(self.elements.statusIndicator, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
                    for _, child in pairs(self.elements.statusIndicator:GetDescendants()) do
                        if child:IsA("TextLabel") then
                            TweenService:Create(child, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
                        elseif child:IsA("Frame") then
                            TweenService:Create(child, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
                        end
                    end
                end
                
                wait(0.15)
                
                -- Stage 4: Fade subtitle, close button, and divider (0.35s)
                if self.elements.subtitle then
                    TweenService:Create(self.elements.subtitle, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        TextTransparency = 1
                    }):Play()
                end
                
                if self.elements.closeButton then
                    TweenService:Create(self.elements.closeButton, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, 0, 0, 0)
                    }):Play()
                    
                    for _, child in pairs(self.elements.closeButton:GetDescendants()) do
                        if child:IsA("ImageLabel") then
                            TweenService:Create(child, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
                        end
                    end
                end
                
                -- Fade divider
                if container:FindFirstChild("Divider") then
                    TweenService:Create(container.Divider, TweenInfo.new(0.35), {BackgroundTransparency = 1}):Play()
                end
                
                wait(0.2)
                
                -- Stage 5: Scale and fade logo + panels (0.6s)
                if self.elements.brandLogo then
                    TweenService:Create(self.elements.brandLogo, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                        TextTransparency = 1,
                        TextStrokeTransparency = 1,
                        TextSize = 48
                    }):Play()
                end
                
                if self.elements.leftPanel then
                    TweenService:Create(self.elements.leftPanel, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                        BackgroundTransparency = 1
                    }):Play()
                end
                
                TweenService:Create(container, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 300, 0, 200)
                }):Play()
                
                if self.elements.loadingBarFill and self.elements.loadingBarFill.Parent then
                    TweenService:Create(self.elements.loadingBarFill.Parent, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
                    TweenService:Create(self.elements.loadingBarFill, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
                end
                
                wait(0.4)
                
                -- Stage 6: Final fade backdrop and blur (0.4s)
                TweenService:Create(backdrop, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 1
                }):Play()
                
                if blur then
                    TweenService:Create(blur, TweenInfo.new(0.4), {Size = 0}):Play()
                end
                
                wait(0.4)
                
                -- Cleanup
                if blur then blur:Destroy() end
                self.gui:Destroy()
                self.gui = nil
            end
            
            self.close = function(self)
                if not self.gui then return end
                getgenv().UI_CLOSED = true
                local container = self.elements.container
                local backdrop = self.elements.backdrop
                local blur = Lighting:FindFirstChild("FSocietyKeyBlur")
                
                TweenService:Create(container, TweenInfo.new(0.2), {
                    BackgroundTransparency = 1
                }):Play()
                
                TweenService:Create(backdrop, TweenInfo.new(0.2), {
                    BackgroundTransparency = 1
                }):Play()
                
                task.wait(0.2)
                
                if blur then blur:Destroy() end
                self.gui:Destroy()
                self.gui = nil
            end
            
            self.setLoadingState = function(self, isLoading, message)
                if isLoading then
                    self:updateStatus(message or "Loading...", Colors.primary, 0)
                else
                    self.elements.statusText.Visible = false
                end
            end
            
            setupAnimations()
            
            return self.gui
        end
        end 
    end 
    
    local UI = {}
    UI.__index = UI
    
    function UI.new(options)
        local self = setmetatable({}, UI)
        
        self.options = options or {}
        self.title = self.options.title or "FSOCIETY"
        self.subtitle = self.options.subtitle or "KEY VERIFICATION SYSTEM"
        self.description = self.options.description or "Please complete the key verification to continue"
        
        self.lastRequestTime = 0
        self.requestCooldown = 15
        self.maxAttempts = 5
        self.currentAttempts = 0
        
        self.player = Players.LocalPlayer
        self.gui = nil
        self.hwid = game:GetService("RbxAnalyticsService"):GetClientId()
        
        self._connections = {}
        
        return self
    end
    
    UI.createUI = function(self)
        local UIFactory = loadUIFactory()
        
        if UIFactory then
            local uiBuilder = UIFactory(Colors, Players, TweenService, UserInputService, Lighting)
            if uiBuilder then
                uiBuilder(self)
            else
                error("UI builder initialization failed")
                return
            end
        else
            error("Failed to load UI factory")
            return
        end
        
        if self.elements and self.elements.closeButton then
            table.insert(self._connections, self.elements.closeButton.MouseButton1Click:Connect(function()
                self:close()
            end))
        end
        
        if self.elements and self.elements.getLinkButton then
            table.insert(self._connections, self.elements.getLinkButton.MouseButton1Click:Connect(function()
                self:handleGetLink()
            end))
        end
        
        if self.elements and self.elements.verifyButton then
            table.insert(self._connections, self.elements.verifyButton.MouseButton1Click:Connect(function()
                self:handleVerifyKey()
            end))
        end
        
        if self.elements and self.elements.keyInput then
            table.insert(self._connections, self.elements.keyInput.FocusLost:Connect(function(enterPressed)
                if enterPressed then
                    self:handleVerifyKey()
                end
            end))
        end
        
        return self.gui
    end
    
    function UI:close()
        getgenv().UI_CLOSED = true
        for _, conn in ipairs(self._connections or {}) do
            pcall(function() conn:Disconnect() end)
        end
        self._connections = {}
        if self.gui then self.gui:Destroy() end
        return getgenv().SCRIPT_KEY
    end
    
    function UI:handleGetLink()
        local secureGetKeyLink = Junkie.get_key_link()
        if not secureGetKeyLink then
            self:updateStatus("System not initialized", Colors.error, 3)
            return
        end
        local link = secureGetKeyLink
        
        if link then
            if setclipboard then
                setclipboard(link)
                self:updateStatus("Link copied to clipboard!", Colors.success, 3)
            else
                self:updateStatus("Get link: " .. link, Colors.primary, 10)
            end
        else
            self:updateStatus("Failed to get link", Colors.error, 3)
        end
    end
    
    function UI:handleVerifyKey()
        local key = self.elements.keyInput.Text:gsub("%s+", "")
        
        if key == "" then
            self:updateStatus("Please enter a key", Colors.error, 3)
            self:shakeInput()
            return
        end
        
        self:updateStatus("Verifying...", Colors.primary, 0)
        
        if self.elements.keyInput.Interactable ~= nil then
            self.elements.keyInput.Interactable = false
        end
        
        local result = Junkie.check_key(key)
        
        if result and result.valid then
            saveVerifiedKey(key)
            self:updateStatus("Key verified!", Colors.success, 0)
            
            task.wait(0.6)
            getgenv().SCRIPT_KEY = key
            getgenv().UI_CLOSED = true
            
            -- Use smooth transition
            self:smoothTransition()
            showLoadingScreen()
            return 
        else
            self:updateStatus("Invalid key", Colors.error, 3)
            if self.shakeInput then self:shakeInput() end
            
            if self.elements.keyInput.Interactable ~= nil then
                self.elements.keyInput.Interactable = true
            end
        end
    end

    local ui = UI.new(options)
    ui:createUI()

    if ui.setLoadingState then
        ui:setLoadingState(true, "Checking verification...")
    end

    local savedKey = loadVerifiedKey()
    local keyToCheck = savedKey
    if not keyToCheck then
        keyToCheck = getgenv().SCRIPT_KEY
    end
    
    local result = Junkie.check_key(keyToCheck)
    if result and result.valid then
        if result.message == "KEYLESS" then
            if ui.showSuccess then
                ui:showSuccess("Keyless Mode ✓")
            end
            getgenv().SCRIPT_KEY = "KEYLESS"
            task.wait(0.6)
            getgenv().UI_CLOSED = true
            if ui.smoothTransition then 
                ui:smoothTransition()
            else
                ui:close()
            end
            showLoadingScreen()
            return
        end
        
        if result.message == "KEY_VALID" then
            if not savedKey and keyToCheck then
                saveVerifiedKey(keyToCheck)
            end
            
            if ui.showSuccess then
                local successMsg = savedKey and "Saved Key Verified ✓" or "Key Verified ✓"
                ui:showSuccess(successMsg)
            end
            getgenv().SCRIPT_KEY = keyToCheck
            task.wait(0.6)
            getgenv().UI_CLOSED = true
            if ui.smoothTransition then 
                ui:smoothTransition()
            else
                ui:close()
            end
            showLoadingScreen()
            return
        end
        
        if savedKey and not result.key_valid then
            clearSavedKey()
        end
        
    end
    
    if ui.setLoadingState then
        ui:setLoadingState(false)
    end

    while not getgenv().UI_CLOSED do
        task.wait(0.1)
    end
    return getgenv().SCRIPT_KEY
end)()
