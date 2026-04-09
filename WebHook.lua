-- ==================== SIMPLE DISCORD WEBHOOK (No Images) - Xeno Compatible ====================

local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

-- ⚠️ CHANGE THIS TO YOUR REAL WEBHOOK URL ⚠️
local WEBHOOK_URL = "https://discord.com/api/webhooks/1491799455287214160/PYXZedGdOzFZm3CUQC2IYf6fDHB0YxM4ub7XxWvWqpdMVkS6889jRscCZ4Zt7h_FgsWM"

local function SendPlayerWebhook()
    local player = Players.LocalPlayer
    if not player then return end

    local userId = player.UserId
    local username = player.Name
    local displayName = player.DisplayName

    local accountAgeDays = math.floor(player.AccountAge)

    local gameName = "Unknown Game"
    pcall(function()
        gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
    end)

    local executionTime = os.date("%Y-%m-%d %H:%M:%S")

    local embed = {
        {
            title = "🟢 FSociety Script Executed",
            description = "**New Execution Detected**",
            color = 0x00ff00,
            author = {
                name = displayName .. " (@" .. username .. ")",
                url = "https://www.roblox.com/users/" .. userId .. "/profile"
            },
            fields = {
                { name = "👤 Username",      value = "`" .. username .. "`", inline = true },
                { name = "📛 Display Name",  value = "`" .. displayName .. "`", inline = true },
                { name = "🔢 User ID",       value = "`" .. userId .. "`", inline = true },
                { name = "⏳ Account Age",   value = accountAgeDays .. " days", inline = true },
                { name = "🕒 Executed At",   value = executionTime, inline = false },
                { name = "🎮 Game",          value = gameName, inline = false },
                { name = "🔗 Profile",       value = "https://www.roblox.com/users/" .. userId .. "/profile", inline = false },
            },
            footer = { text = "FSociety v2.0 • Xeno" },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }
    }

    local data = {
        content = "**FSociety Execution**",
        embeds = embed,
        username = "FSociety Logger"
    }

    -- Send instantly
    local success, err = pcall(function()
        local json = game:GetService("HttpService"):JSONEncode(data)
        
        if syn and syn.request then
            syn.request({Url = WEBHOOK_URL, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = json})
        elseif request then
            request({Url = WEBHOOK_URL, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = json})
        elseif http_request then
            http_request({Url = WEBHOOK_URL, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = json})
        else
            game:GetService("HttpService"):PostAsync(WEBHOOK_URL, json)
        end
    end)

    if success then
        print("✅ Webhook sent successfully for " .. username)
    else
        warn("❌ Webhook failed: " .. tostring(err))
    end
end

-- ==================== AUTO SEND INSTANTLY ====================
SendPlayerWebhook()
