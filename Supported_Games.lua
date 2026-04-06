local Tab = Window:Tab({
    Title = "Supported Games",
    Icon = "gamepad-directional",
    Locked = false,
})

-- Supported Games
-- First paragraph: games 1-100
Tab:Paragraph({
    Title = "🎮 Supported Games [1-100]",
    Desc = "⚠️ Game tab appears only when you're IN the supported game!\n\n" ..
           "[01] 🚗 Car Crusher 2\n" ..
           "[02] 🔫 Counter Blox\n" ..
           "[03] 🚂 Dead Rails\n" ..
           "[04] ⚒️ The Forge\n" ..
           "[05] 💪 Strongman Simulator\n" ..
           "[06] 🌲 99 Nights in the Forest\n" ..
           "[07] 🍎 Blox Fruit\n" ..
           "[08] 🏝️ Island\n" ..
           "[09] 🎵 osu!RoVer\n" ..
           "[10] ✨ Flick\n" ..
           "[11] 🚪 Doors\n" ..
           "[12] 🏃 Evade\n" ..
           "[13] 🏜️ A Dusty Trip\n" ..
           "[14] ⛵ Build a Boat for Treasure\n" ..
           "[15] 🎣 Fisch\n" ..
           "[16] 🚇 The Train Tunnels\n" ..
           "[17] 🐻 Fnaf Co-op\n" ..
           "[18] 🌯 Scary Shawarma\n" ..
           "[19] 🖐️ Slap Battles\n" ..
           "[20] 🐑 Cult of the Lamb\n" ..
           "[21] ⚔️ Blade Ball\n" ..
           "[22] 🕊️ Grace\n" ..
           "[23] 🥊 Rivals\n" ..
           "[24] 🍕 Fnaf Eternal\n" ..
           "[25] 🔪 Survive the Killer\n" ..
           "[26] 🔫 Arsenal\n" ..
           "[27] 🚓 Jailbreak\n" ..
           "[28] 🐶 Adopt Me!\n" ..
           "[29] 🐾 Pet Simulator 99\n" ..
           "[30] 🏡 Brookhaven RP\n" ..
           "[31] 🐝 Bee Swarm Simulator\n" ..
           "[32] 🔪 Murder Mystery 2\n" ..
           "[33] 🌀 Shindo Life\n" ..
           "[34] 👑 King Legacy\n" ..
           "[35] 💥 Anime Fighters Simulator\n" ..
           "[36] 💰 Da Hood\n" ..
           "[37] 🛏️ BedWars\n" ..
           "[38] 💸 Pls Donate\n" ..
           "[39] 🐱 Pet Simulator X\n" ..
           "[40] 🌋 Natural Disaster Survival\n" ..
           "[41] 🏎️ Vehicle Simulator\n" ..
           "[42] 🎢 Theme Park Tycoon 2\n" ..
           "[43] 🍕 Work at a Pizza Place\n" ..
           "[44] 🙈 Hide and Seek Extreme\n" ..
           "[45] 🚘 Driving Empire\n" ..
           "[46] ⚔️ Combat Warriors\n" ..
           "[47] 🦸 Mad City\n" ..
           "[48] 🏚️ Break In Story\n" ..
           "[49] 🗼 Tower of Hell\n" ..
           "[50] 🪓 Lumber Tycoon 2\n" ..
           "[51] 🐷 Piggy\n" ..
           "[52] 🧟 Tower Defense Simulator\n" ..
           "[53] 🏘️ MeepCity\n" ..
           "[54] 🌌 Anime Dimensions\n" ..
           "[55] 🍇 Fruits Battlegrounds\n" ..
           "[56] ☢️ SCP: Roleplay\n" ..
           "[57] 🔫 Phantom Forces\n" ..
           "[58] 🍔 Bloxburg\n" ..
           "[59] 🥷 Ninja Legends\n" ..
           "[60] 🎮 Epic Minigames\n" ..
           "[61] 🏋️ Muscle Legends\n" ..
           "[62] 🩸 Ro-Ghoul\n" ..
           "[63] 🏫 Bayside High School\n" ..
           "[64] 👊 Strongest Battlegrounds\n" ..
           "[65] 🎒 Pet Catchers\n" ..
           "[66] 🍽️ Restaurant Tycoon 2\n" ..
           "[67] 🗡️ Weapon Fighting Simulator\n" ..
           "[68] 🚧 Obby Creator\n" ..
           "[69] 🏙️ RoCitizens\n" ..
           "[70] 👑 Royale High\n" ..
           "[71] 💎 Miner's Haven\n" ..
           "[72] 🍳 My Restaurant\n" ..
           "[73] 🌊 Deepwoken\n" ..
           "[74] 🏴‍☠️ Grand Piece Online\n" ..
           "[75] 🏹 Your Bizarre Adventure\n" ..
           "[76] 🧛 Vampire Hunters 3\n" ..
           "[77] 🏆 Treasure Quest\n" ..
           "[78] 🛡️ Tower Battles\n" ..
           "[79] 🤿 Scuba Diving at Quill Lake\n" ..
           "[80] 🛒 Retail Tycoon 2\n" ..
           "[81] 🧙 Wacky Wizards\n" ..
           "[82] 🦔 Sonic Speed Simulator\n" ..
           "[83] 🎯 Bad Business\n" ..
           "[84] 🌟 Anime Adventures\n" ..
           "[85] 🏰 All Star Tower Defense\n" ..
           "[86] 🫧 Bubble Gum Simulator\n" ..
           "[87] ⛓️ Prison Life\n" ..
           "[88] 🌩️ Survive The Disasters\n" ..
           "[89] ⛳ Super Golf!\n" ..
           "[90] 🖥️ Flee the Facility\n" ..
           "[91] 🦈 SharkBite 2\n" ..
           "[92] 🤠 The Wild West\n" ..
           "[93] 🐉 Creatures of Sonaria\n" ..
           "[94] 🛋️ SCP-3008\n" ..
           "[95] 🎧 RoBeats\n" ..
           "[96] 🗡️ Dungeon Quest\n" ..
           "[97] ⛏️ Mining Simulator 2\n" ..
           "[98] 🪖 Frontlines\n" ..
           "[99] 🟨 Apeirophobia\n" ..
           "[100] 🔪 KAT! (Knife Ability Test)",
    Color = Color3.fromRGB(80, 200, 255),
    Locked = false
})

-- Second paragraph: games 101-200
Tab:Paragraph({
    Title = "🎮 Supported Games [101-200]",
    Desc = "[101] ⚔️ Sword Burst 2\n" ..
           "[102] 🧟 Project Lazarus\n" ..
           "[103] 🏎️ Midnight Racing: Tokyo\n" ..
           "[104] 🍕 Pizza Factory Tycoon\n" ..
           "[105] 🌌 Starscape\n" ..
           "[106] ✈️ Pilot Training Flight Simulator\n" ..
           "[107] 🛳️ Tiny Sailors: World\n" ..
           "[108] 🔨 Ro-Scale Sandbox\n" ..
           "[109] 🏹 Booga Booga\n" ..
           "[110] 🐻 Bear (Alpha)\n" ..
           "[111] 👻 Specter\n" ..
           "[112] 🏚️ The Mimic\n" ..
           "[113] 🔦 Cheese Escape\n" ..
           "[114] 🔪 Assassin!\n" ..
           "[115] 🦸 Marvel New Journey\n" ..
           "[116] 🕸️ Web Slingers\n" ..
           "[117] ⚔️ Swordburst 3\n" ..
           "[118] 🛡️ Base Battles\n" ..
           "[119] 🔫 Energy Assault\n" ..
           "[120] 🚁 Blackhawk Rescue Mission 5\n" ..
           "[121] ⚔️ Criminality\n" ..
           "[122] 💰 Bank Robbery Simulator\n" ..
           "[123] 🥷 Ninja Assassin\n" ..
           "[124] 🏰 Build and Survive\n" ..
           "[125] 🧊 Icebreaker\n" ..
           "[126] 🚀 Space Sailors\n" ..
           "[127] 🏎️ Car Dealership Tycoon\n" ..
           "[128] 🚓 Emergency Response: Liberty County\n" ..
           "[129] 🚒 Maple County\n" ..
           "[130] 🏥 Maple Hospital\n" ..
           "[131] 👶 Baby Simulator\n" ..
           "[132] 🏋️ Weight Lifting Simulator\n" ..
           "[133] 💪 Giant Simulator\n" ..
           "[134] 🥊 Super Punch Simulator\n" ..
           "[135] 🔮 Sorcerer Battlegrounds\n" ..
           "[136] ⚡ Flash Earth\n" ..
           "[137] 🦸 Hero's Ultimatum\n" ..
           "[138] 🧟 Zombie Attack\n" ..
           "[139] 🧟 Zombie Rush\n" ..
           "[140] 🧟 Zombie Uprising\n" ..
           "[141] ⚔️ Demonfall\n" ..
           "[142] 🗡️ Project Slayers\n" ..
           "[143] 🌀 Anime Story\n" ..
           "[144] ⚔️ Anime Battle Arena\n" ..
           "[145] 💥 Anime Fighting Simulator X\n" ..
           "[146] 🏴‍☠️ A One Piece Game\n" ..
           "[147] 🌊 Haze Piece\n" ..
           "[148] 🍇 Fruit Warriors\n" ..
           "[149] ⛵ Trident Survival\n" ..
           "[150] 🏝️ Survival 303\n" ..
           "[151] 🧊 Survive the Epic Disasters\n" ..
           "[152] 🌪️ Tornado Alley Ultimate\n" ..
           "[153] 🌋 Floor is Lava\n" ..
           "[154] 🏃 Speed Run 4\n" ..
           "[155] 🏃‍♂️ Parkour\n" ..
           "[156] 🧗 Tower of Misery\n" ..
           "[157] 🗼 JTOH\n" ..
           "[158] 🏃‍♀️ Deathrun\n" ..
           "[159] ⚔️ Gladiators\n" ..
           "[160] 🛡️ SkyWars\n" ..
           "[161] 🥚 Egg Hunt (Classic)\n" ..
           "[162] 📦 Unboxing Simulator\n" ..
           "[163] 🐾 Pet Swarm Simulator\n" ..
           "[164] 🐶 Adopt and Raise\n" ..
           "[165] 👶 Daycare Story\n" ..
           "[166] 🏫 Robloxian High School\n" ..
           "[167] 🏕️ Camping\n" ..
           "[168] 🏨 Hotel Elephant\n" ..
           "[169] 🎢 Waterpark Tycoon\n" ..
           "[170] 🍔 My Burger Shop\n" ..
           "[171] ☕ Frappe\n" ..
           "[172] 🍦 Pastriez Bakery\n" ..
           "[173] 💇 Salon Tycoon\n" ..
           "[174] 🏢 Skyscraper Tycoon\n" ..
           "[175] 🏭 Factory Simulator\n" ..
           "[176] 🚗 Car Factory Tycoon\n" ..
           "[177] ✈️ Airport Tycoon\n" ..
           "[178] 🚆 Train Tycoon\n" ..
           "[179] 🚀 Space Tycoon\n" ..
           "[180] 🌌 Galaxy\n" ..
           "[181] 🚀 Star Wars: Lightsaber Battles\n" ..
           "[182] 🔫 Neo Warfare X\n" ..
           "[183] ⚔️ Tank Warfare\n" ..
           "[184] 🚢 Naval Warfare\n" ..
           "[185] 💣 Destruction Simulator\n" ..
           "[186] 🧨 Bomb Simulator\n" ..
           "[187] 🧲 Magnet Simulator\n" ..
           "[188] 🍬 Candy Simulator\n" ..
           "[189] 🍦 Ice Cream Simulator\n" ..
           "[190] 🍕 Pizza Simulator\n" ..
           "[191] 🍔 Fast Food Simulator\n" ..
           "[192] 🍎 Eating Simulator\n" ..
           "[193] 🥤 Drinking Simulator\n" ..
           "[194] 🏃 Jogging Simulator\n" ..
           "[195] 🛌 Sleeping Simulator\n" ..
           "[196] 💸 Billionaire Simulator\n" ..
           "[197] 💰 Bitcoin Miner\n" ..
           "[198] 🖥️ PC Building Simulator\n" ..
           "[199] 📱 YouTube Simulator\n" ..
		   "[200] 🌪️ Twisted",
    Color = Color3.fromRGB(80, 200, 255),
    Locked = false
})
