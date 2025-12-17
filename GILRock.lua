
        loadstring(game:HttpGet("https://raw.githubusercontent.com/sinret/rbxscript.com-scripts-reuploads-/main/us3", true))()
        Rayfield:Notify({Title = "Script Loaded", Content = "Command Bar loaded", Duration = 2})
    end
})

ScriptsTab:CreateButton({
    Name = "🦉 Owl Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"))()
        Rayfield:Notify({Title = "Script Loaded", Content = "Owl Hub loaded", Duration = 2})
    end
})

ScriptsTab:CreateButton({
    Name = "🎯 Aimbot Script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V3/main/main.lua"))()
        Rayfield:Notify({Title = "Script Loaded", Content = "Aimbot loaded", Duration = 2})
    end
})

ScriptsTab:CreateButton({
    Name = "🔫 Arsenal Script",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Arsenal-Feather-Hub-AI-PLAY-SOFTAIM-GUNMODS-DRAWFOV-ESP-70554"))()
        Rayfield:Notify({Title = "Script Loaded", Content = "Arsenal script loaded", Duration = 2})
    end
})

ScriptsTab:CreateButton({
    Name = "⚔️ Blox Fruits Script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xQuartyx/DonateMe/main/ScriptLoader"))()
        Rayfield:Notify({Title = "Script Loaded", Content = "Blox Fruits script loaded", Duration = 2})
    end
})

ScriptsTab:CreateButton({
    Name = "🔨 The Forge",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/2075c39b9a5a2e4414c59c93fe8a5f06.lua"))()
        Rayfield:Notify({Title = "Script Loaded", Content = "Counter Blox script loaded", Duration = 2})
    end
})

ScriptsTab:CreateButton({
    Name = "🔨 Blade Ball",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Akash1al/Blade-Ball-Updated-Script/refs/heads/main/Blade-Ball-Script"))()
        Rayfield:Notify({Title = "Script Loaded", Content = "Counter Blox script loaded", Duration = 2})
    end
})

ScriptsTab:CreateButton({
    Name = "🔨 Fnaf CO-OP",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Asphronium/FnafCo-opGUI/main/fnafCo-opGUI.lua"))()
        Rayfield:Notify({Title = "Script Loaded", Content = "Counter Blox script loaded", Duration = 2})
    end
})

ScriptsTab:CreateButton({
    Name = "🔨 Fnaf Enthernal",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Snipez-Dev/Rbx-Scripts/refs/heads/main/Eternal%20Nights"))()
        Rayfield:Notify({Title = "Script Loaded", Content = "Counter Blox script loaded", Duration = 2})
    end
})

ScriptsTab:CreateButton({
    Name = "🔨 The Forge",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/2075c39b9a5a2e4414c59c93fe8a5f06.lua"))()
        Rayfield:Notify({Title = "Script Loaded", Content = "Counter Blox script loaded", Duration = 2})
    end
})

ScriptsTab:CreateButton({
    Name = "🔨 The Forge",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/2075c39b9a5a2e4414c59c93fe8a5f06.lua"))()
        Rayfield:Notify({Title = "Script Loaded", Content = "Counter Blox script loaded", Duration = 2})
    end
})
-- ============================================
-- TAB 6: ADMIN
-- ============================================
local AdminTab = Window:CreateTab("👑 Admin", nil)
AdminTab:CreateSection("Admin Commands")

AdminTab:CreateButton({
    Name = "👨‍💼 Load Admin Commands",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        Rayfield:Notify({Title = "Admin Loaded", Content = "Infinite Yield admin loaded", Duration = 2})
    end
})

AdminTab:CreateButton({
    Name = "🔨 Load HD Admin",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Hosvile/HD-Admin/main/Main"))()
        Rayfield:Notify({Title = "Admin Loaded", Content = "HD Admin loaded", Duration = 2})
    end
})

AdminTab:CreateButton({
    Name = "⚡ Load Reviz Admin",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ttjy9808/POOPOOPEE/main/protected_7831550836392278.lua.txt"))()
        Rayfield:Notify({Title = "Admin Loaded", Content = "Reviz Admin loaded", Duration = 2})
    end
})

AdminTab:CreateButton({
    Name = "🎭 Fake Lag",
    Callback = function()
        pcall(function()
            local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
            Rayfield:Notify({Title = "Ping", Content = "Current ping: "..math.floor(ping).."ms", Duration = 3})
        end)
    end
})
