local PlayerRoles = {
    -- OWNERS
    [4154408422] = "Owner",
    -- CO-OWNERS
    [111111111] = "CoOwner",
    -- LEAD DEVELOPERS
    [222222222] = "LeadDeveloper",
    -- SR DEVELOPERS
    [333333333] = "SrDeveloper",
    -- DEVELOPERS
    [444444444] = "Developer",
    -- HEAD MANAGERS
    [555555555] = "HeadManager",
    -- MANAGERS
    [666666666] = "Manager",
    -- HEAD ADMINS
    [777777777] = "HeadAdmin",
    -- SR ADMINS
    [888888888] = "SrAdmin",
    -- ADMINS
    [999999999] = "Admin",
    -- JR ADMINS
    [101010101] = "JrAdmin",
    -- SR MODERATORS
    [121212121] = "SrModerator",
    -- MODERATORS
    [131313131] = "Moderator",
    -- SUPPORT
    [141414141] = "Support",
    -- HELPERS
    [151515151] = "Helper",
    -- TRIALISTS
    [161616161] = "Trialist",
    -- TESTERS
    [171717171] = "Tester",
    -- DESIGNERS
    [181818181] = "Designer",
    -- SCRIPTERS
    [191919191] = "Scripter",
    -- BUILDERS
    [202020202] = "Builder",
    -- BOOSTERS
    [212121212] = "Booster",
    -- DONATORS
    [222222223] = "Donator",
    -- VIP
    [232323232] = "VIP",
    -- TRUSTED
    [242424242] = "Trusted",
    -- VERIFIED
    [252525252] = "Verified",
    -- MUTED
    [262626262] = "Muted",
    -- BANNED
    [272727272] = "Banned",
}

local WelcomeMessages = {
    ["Owner"]         = "Welcome back, Owner. You have full control of this game.",
    ["CoOwner"]       = "Welcome, Co-Owner. All systems are available to you.",
    ["LeadDeveloper"] = "Lead Developer detected. Deploy access is now active.",
    ["SrDeveloper"]   = "Sr. Developer recognized. Script management unlocked.",
    ["Developer"]     = "Developer recognized. Dev tools are now unlocked.",
    ["HeadManager"]   = "Head Manager online. Full management access granted.",
    ["Manager"]       = "Manager online. Event management unlocked.",
    ["HeadAdmin"]     = "Head Admin active. Promotion rights are now granted.",
    ["SrAdmin"]       = "Sr. Admin active. Staff management is now enabled.",
    ["Admin"]         = "Admin active. Ban and unban access granted.",
    ["JrAdmin"]       = "Jr. Admin active. Admin panel is now unlocked.",
    ["SrModerator"]   = "Sr. Moderator active. Temp-ban access granted.",
    ["Moderator"]     = "Moderator active. Kick and mute rights granted.",
    ["Support"]       = "Support active. Report access is now granted.",
    ["Helper"]        = "Helper recognized. Mute access granted.",
    ["Trialist"]      = "Trialist — staff access has been granted.",
    ["Tester"]        = "Tester recognized. Test server access granted.",
    ["Designer"]      = "Designer recognized. Design tools are now unlocked.",
    ["Scripter"]      = "Scripter recognized. Script access granted.",
    ["Builder"]       = "Builder recognized. Build zone is now unlocked.",
    ["Booster"]       = "Thank you for boosting! Your perks are active.",
    ["Donator"]       = "Thank you for donating! Donator perks are now active.",
    ["VIP"]           = "VIP access granted. Enjoy your exclusive perks!",
    ["Trusted"]       = "Trusted member recognized. Welcome!",
    ["Verified"]      = "Verified member recognized. Welcome!",
    ["Muted"]         = "You are currently muted in this game.",
    ["Banned"]        = "You are banned from this game.",
    ["User"]          = "Welcome! You are logged in as a regular user.",
}

-- ================================================
-- GET PLAYER ROLE
-- ================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local userId = LocalPlayer.UserId
local role = PlayerRoles[userId] or "User"
local data = RoleData[role] or RoleData["User"]
