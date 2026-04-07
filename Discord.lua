local Tab = Window:Tab({
    Title = "Discord & Support",
    Desc = "", -- optional
    Icon = "play", -- lucide icon or "rbxassetid://" or URL. optional
    IconColor = Color3.fromHex("#040e92"), -- custom icon color. optional
    IconShape = "Square", -- "Square" or "Circle". optional
    IconThemed = true, -- use theme colors. optional
    Locked = false, -- disable tab interaction. optional
    ShowTabTitle = false, -- show title inside tab. optional
    Border = true, -- add border around tab. optional
})
-- discord
local HttpService = game:GetService("HttpService")
local InviteCode = "PA7M3S9HC6"

local function JoinDiscord()
    local inviteLink = "https://discord.gg/" .. InviteCode
    local googleRedirect = "https://www.google.com/url?q=" .. inviteLink
    local opened = false

    if syn and syn.open_proto_link then
        pcall(function()
            syn.open_proto_link(googleRedirect)
            opened = true
        end)
    end

    if not opened and shellexecute then
        pcall(function()
            shellexecute(googleRedirect)
            opened = true
        end)
    end

    if not opened then
        if setclipboard then setclipboard(inviteLink) end
        WindUI:Notify({
            Title = "Join Our Discord!",
            Content = "Link copied!\n" .. inviteLink,
            Duration = 6,
        })
    else
        WindUI:Notify({
            Title = "Redirecting...",
            Content = "Opening Discord via browser!",
            Duration = 3,
        })
    end
end

local function GetDiscordInviteData(code)
    local url = "https://discord.com/api/v10/invites/" .. code .. "?with_counts=true"
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    if not success then return nil, response end

    local decoded
    success, decoded = pcall(function()
        return HttpService:JSONDecode(response)
    end)
    if not success then return nil, decoded end

    return decoded
end

local Response, Error = GetDiscordInviteData(InviteCode)

if Response and Response.guild then
    local iconUrl = nil
    local bannerUrl = nil

    if Response.guild.icon and Response.guild.icon ~= "" then
        iconUrl = "https://cdn.discordapp.com/icons/" ..
            Response.guild.id .. "/" .. Response.guild.icon .. ".png?size=1024"
    end

    if Response.guild.banner and Response.guild.banner ~= "" then
        bannerUrl = "https://cdn.discordapp.com/banners/" ..
            Response.guild.id .. "/" .. Response.guild.banner .. ".png?size=512"
    end

    Tab:Paragraph({
        Title = Response.guild.name,
        Desc =
            ' <font color="#52525b">•</font> Member Count : ' .. tostring(Response.approximate_member_count) ..
            '\n <font color="#16a34a">•</font> Online Count : ' .. tostring(Response.approximate_presence_count),
        Image = iconUrl,
        ImageSize = 42,
        Thumbnail = bannerUrl,
        Buttons = {
            {
                Title = "Join Server",
                Icon = "solar:arrow-right-bold",
                Callback = function() JoinDiscord() end
            }
        }
    })
else
    Tab:Paragraph({
        Title = "Error fetching Discord server info",
        Desc = Error and tostring(Error) or "No data returned",
        Image = "solar:info-circle-bold",
        ImageSize = 26,
        Color = "Red",
        Buttons = {
            {
                Title = "Join Anyway",
                Icon = "solar:arrow-right-bold",
                Callback = function() JoinDiscord() end
            }
        }
    })
end
