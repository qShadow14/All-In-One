-- ==================== FIXED CUSTOM CURSOR ====================

local Tab = Window:Tab({
    Title = "Cursor",
    Desc = "Change your Cursor type", -- optional
    Icon = "mouse-pointer-2", -- lucide icon or "rbxassetid://" or URL. optional
    IconColor = Color3.fromHex("#707070"), -- custom icon color. optional
    IconShape = "Square", -- "Square" or "Circle". optional
    IconThemed = true, -- use theme colors. optional
    Locked = false, -- disable tab interaction. optional
    ShowTabTitle = false, -- show title inside tab. optional
    Border = true, -- add border around tab. optional
})

local Dropdown = Tab:Dropdown({
    Title = "Cursor Dropdown",
    Values = {
        {
            Title = "Default",
            Desc = "Default Cursor",
            Icon = "mouse-pointer-2",
            Callback = function() 
            end
        },
        {
            Title = "Dark Cursor",
            Desc = "With Smooth Edges",
            Icon = "mouse-pointer-2",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/qShadow14/All-In-One/refs/heads/main/Cursors/Cursor_1.lua"))()
            end
        },
        {
            Title = "Orange",
            Desc = "With Smooth edges",
            Icon = "mouse-pointer-2",
            Callback = function() 
                loadstring(game:HttpGet("https://raw.githubusercontent.com/qShadow14/All-In-One/refs/heads/main/Cursors/Cursor_2.lua"))()
            end
        },
        {
            Title = "Red Cursor",
            Desc = "With Smooth Edges",
            Icon = "mouse-pointer-2",
            Callback = function() 
                loadstring(game:HttpGet("https://raw.githubusercontent.com/qShadow14/All-In-One/refs/heads/main/Cursors/Cursor_3.lua"))()
            end
        },
        {
            Title = "Green Cursor",
            Desc = "With Smooth Edges",
            Icon = "mouse-pointer-2",
            Callback = function() 
                loadstring(game:HttpGet("https://raw.githubusercontent.com/qShadow14/All-In-One/refs/heads/main/Cursors/Cursor_4.lua"))()
            end
        },
        {
            Title = "Yellow Cursor",
            Desc = "With Smooth Edges",
            Icon = "mouse-pointer-2",
            Callback = function() 
                loadstring(game:HttpGet("https://raw.githubusercontent.com/qShadow14/All-In-One/refs/heads/main/Cursors/Cursor_5.lua"))()
            end
        },
        {
            Title = "Purple",
            Desc = "With Smooth Edges",
            Icon = "mouse-pointer-2",
            Callback = function() 
                loadstring(game:HttpGet("https://raw.githubusercontent.com/qShadow14/All-In-One/refs/heads/main/Cursors/Cursor_6.lua"))()
            end
        },
        {
            Title = "Blue",
            Desc = "With Smooth Edges",
            Icon = "mouse-pointer-2",
            Callback = function() 
                loadstring(game:HttpGet("https://raw.githubusercontent.com/qShadow14/All-In-One/refs/heads/main/Cursors/Cursor_7.lua"))()
            end
        },
    }
})
