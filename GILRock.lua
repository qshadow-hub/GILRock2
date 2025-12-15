-- Load Rayfield
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Create Window
local Window = Rayfield:CreateWindow({
    Name = "GILRock",
    Icon = 0,
    LoadingTitle = "GILRock",
    LoadingSubtitle = "qShadow",
    ShowText = "Rayfield",
    Theme = "Default",

    ToggleUIKeybind = "K",

    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,

    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "Big Hub"
    },

    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },

    -- KEY SYSTEM DISABLED
    KeySystem = false
})

----------------------------------------------------------------
-- AUTOS TAB
----------------------------------------------------------------
local AutosTab = Window:CreateTab("Autos", nil)
AutosTab:CreateSection("Autos")

AutosTab:CreateDropdown({
    Name = "Dropdown Example",
    Options = {"Option 1", "Option 2"},
    CurrentOption = {"Option 1"},
    MultipleOptions = false,
    Flag = "Dropdown1",
    Callback = function(Options)
        -- Dropdown logic
        print("Selected:", Options[1])
    end,
})

AutosTab:CreateButton({
    Name = "Temp Button 1",
    Callback = function()
        print("Temp Button 1 pressed")
    end,
})

AutosTab:CreateButton({
    Name = "Temp Button 2",
    Callback = function()
        print("Temp Button 2 pressed")
    end,
})

AutosTab:CreateButton({
    Name = "Temp Button 3",
    Callback = function()
        print("Temp Button 3 pressed")
    end,
})

AutosTab:CreateButton({
    Name = "Temp Button 4",
    Callback = function()
        print("Temp Button 4 pressed")
    end,
})

AutosTab:CreateButton({
    Name = "Temp Button 5",
    Callback = function()
        print("Temp Button 5 pressed")
    end,
})

----------------------------------------------------------------
-- CHARACTER TAB
----------------------------------------------------------------
local CharacterTab = Window:CreateTab("Character", nil)
CharacterTab:CreateSection("Character")

CharacterTab:CreateButton({
    Name = "Character Temp 1",
    Callback = function()
        print("Character Temp 1 pressed")
    end,
})

CharacterTab:CreateButton({
    Name = "Character Temp 2",
    Callback = function()
        print("Character Temp 2 pressed")
    end,
})

CharacterTab:CreateButton({
    Name = "Character Temp 3",
    Callback = function()
        print("Character Temp 3 pressed")
    end,
})
