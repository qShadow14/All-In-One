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

-- ================================================
-- GET PLAYER ROLE & SEND WINDUI NOTIFICATION
-- ================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local userId = LocalPlayer.UserId
local role = PlayerRoles[userId] or "User"

WindUI:Notify({
    Title = "Role Detected",
    Content = "You are: " .. role,
    Duration = 3
})
