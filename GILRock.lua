-- Load Rayfield
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Roblox services
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

-- Pastebin RAW URL containing valid keys (one key per line)
local KEY_URL = "https://rayfiendgeneratorkey.netlify.app/"

-- Function to fetch key list and validate
local function isKeyValid(key)
    local success, data = pcall(function()
        return HttpService:GetAsync(KEY_URL)
    end)
    if not success then
        warn("Failed to fetch key list")
        return false
    end

    for line in data:gmatch("[^\r\n]+") do
        if line == key then
            return true
        end
    end
    return false
end

-- Create Rayfield window with key system
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

    KeySystem = true,
    KeySettings = {
        Title = "GILRock Key",
        Subtitle = "Key System",
        Note = "Get a key from the website",
        FileName = "Key",
        SaveKey = false,
        GrabKeyFromSite = true, -- We'll validate manually below
        Key = {"TEMP"} -- dummy key
    }
})

-- Validate key after Rayfield prompt
local userKey = Rayfield:Prompt({
    Title = "GILRock Key",
    Subtitle = "Enter your key"
})

if not isKeyValid(userKey) then
    Players.LocalPlayer:Kick("Invalid or expired key.")
    return
end

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
        print("Selected:", Options[1])
    end,
})

for i = 1,5 do
    AutosTab:CreateButton({
        Name = "Temp Button " .. i,
        Callback = function()
            print("Temp Button " .. i .. " pressed")
        end,
    })
end

----------------------------------------------------------------
-- CHARACTER TAB
----------------------------------------------------------------
local CharacterTab = Window:CreateTab("Character", nil)
CharacterTab:CreateSection("Character")

for i = 1,3 do
    CharacterTab:CreateButton({
        Name = "Character Temp " .. i,
        Callback = function()
            print("Character Temp " .. i .. " pressed")
        end,
    })
end
