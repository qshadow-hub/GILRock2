local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/RegularVynixu/UI-Libraries/main/Rayfield/source.lua'))()

local Window = Rayfield:CreateWindow({
   Name = "Universal Script",
   Icon = 0,
   LoadingTitle = "Universal Script",
   LoadingSubtitle = "by qShadow/Darius/Hynexx",
   ShowText = "Universal Script",
   Theme = "Default",
   ToggleUIKeybind = "K",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = {Enabled = true, FolderName = "UniversalScriptConfig", FileName = "Big Hub"},
   Discord = {Enabled = false, Invite = "noinvitelink", RememberJoins = true},
   KeySystem = false,
   KeySettings = {
      Title = "Universal Script",
      Subtitle = "Key System",
      Note = "Key=qShadow",
      FileName = "Key",
      SaveKey = false,
      GrabKeyFromSite = false,
      Key = {"qShadow2232"}
   }
})

local ScriptsTab = Window:CreateTab("📜 Scripts", nil)
ScriptsTab:CreateSection("Popular Scripts")

ScriptsTab:CreateButton({
    Name = "🔓 Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        Rayfield:Notify({Title = "Script Loaded", Content = "Infinite Yield loaded", Duration = 2})
    end
})

ScriptsTab:CreateButton({
    Name = "🎮 Dex Explorer",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
        Rayfield:Notify({Title = "Script Loaded", Content = "Dex Explorer loaded", Duration = 2})
    end
})

ScriptsTab:CreateButton({
    Name = "🔍 Remote Spy",
    Callback = function()
         loadstring(game:HttpGet("https://pastebin.com/raw/qyf0wnB8"))()
         Rayfield:Notify({Title = "Script Loaded", Content = "Remote Spy loaded", Duration = 2})
   end
})
ScriptsTab:CreateButton({
    Name = "⌨️ Command Bar",
    Callback = function()
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
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/606b846e88998801018fae498b9b8a3c.lua"))(
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
        Rayfield:Notify({Title = "Script Loaded", Content = "The Forge Blox script loaded", Duration = 2})
    end
})

ScriptsTab:CreateButton({
    Name = "🔨 Blade Ball",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Akash1al/Blade-Ball-Updated-Script/refs/heads/main/Blade-Ball-Script"))()
        Rayfield:Notify({Title = "Script Loaded", Content = "Blade Ball Blox script loaded", Duration = 2})
    end
})

ScriptsTab:CreateButton({
    Name = "🔨 Fnaf CO-OP",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Asphronium/FnafCo-opGUI/main/fnafCo-opGUI.lua"))()
        Rayfield:Notify({Title = "Script Loaded", Content = "Fnaf CO-OP Blox script loaded", Duration = 2})
    end
})

ScriptsTab:CreateButton({
    Name = "🔨 Fnaf Eternal",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Snipez-Dev/Rbx-Scripts/refs/heads/main/Eternal%20Nights"))()
        Rayfield:Notify({Title = "Script Loaded", Content = "Fnaf Eternal script loaded", Duration = 2})
    end
})

ScriptsTab:CreateButton({
    Name = "🔨 StrongMan Simulator",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Strongman-Simulator-Strongman-Simolator-41260"))()
        Rayfield:Notify({Title = "Script Loaded", Content = "StrongMan Simulator script loaded", Duration = 2})
    end
})
