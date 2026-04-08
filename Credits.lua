-- Create Credits Tab (use :CreateTab not :Tab)
local InfoTab = Window:CreateTab({
    Title = "Credits",
    Desc = "Who helped with the script",
    Icon = "crown",
    IconColor = Color3.fromHex("#ffe600"),
    IconShape = "Square",
    IconThemed = true,
    Locked = false,
    ShowTabTitle = false,
    Border = true,
})

-- All paragraphs use InfoTab, not Tab
InfoTab:Paragraph({
    Title = "👑 Owner",
    Desc = "[1] qShadow / Vexor",
    Color = Color3.fromRGB(255, 80, 255),
    Locked = false,
})
InfoTab:Paragraph({
    Title = "💻 Developer",
    Desc = "[1] TeoNair\n[2] H1NEXX\n[3] Dreezy",
    Color = Color3.fromRGB(80, 255, 160),
    Locked = false,
})
InfoTab:Paragraph({
    Title = "⚡ Head Admin",
    Desc = "[1] .ftgs\n[2] CM KALAN",
    Color = Color3.fromRGB(255, 160, 40),
    Locked = false,
})
InfoTab:Paragraph({
    Title = "🛡️ Admin",
    Desc = "[1] d\n[2] SSHRK\n[3] Dinga",
    Color = Color3.fromRGB(80, 180, 255),
    Locked = false,
})
InfoTab:Paragraph({
    Title = "🔧 Moderator",
    Desc = "[1] K I R A\n[2] Hi\n[3] CM KALAN",
    Color = Color3.fromRGB(255, 220, 80),
    Locked = false,
})
InfoTab:Paragraph({
    Title = "🎨 Designer",
    Desc = "[1] BirdBall\n[2] Dreezy\n[3] Teo\n[4] H1NEXX",
    Color = Color3.fromRGB(80, 180, 255),
    Locked = false,
})
