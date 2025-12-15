local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

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
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Hello"}
   }
})

-- ========== AUTOS TAB ==========
local AutosTab = Window:CreateTab("Autos", nil)
local AutosSection = AutosTab:CreateSection("Autos")

local Dropdown1 = AutosTab:CreateDropdown({
   Name = "Mine",
   Options = {"Stone","Basalt","LimeStone"},
   CurrentOption = "Stone",
   MultipleOptions = false,
   Flag = "Dropdown1",
   Callback = function(Option)
       print("Selected option:", Option)
   end,
})

local Toggle1 = AutosTab:CreateToggle({
   Name = "Money",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
       print("Temp1:", Value)
   end,
})

local Toggle2 = AutosTab:CreateToggle({
   Name = "BEST ORES",
   CurrentValue = false,
   Flag = "Toggle2",
   Callback = function(Value)
       print("Temp2:", Value)
   end,
})

local Toggle3 = AutosTab:CreateToggle({
   Name = "Pickaxe",
   CurrentValue = false,
   Flag = "Toggle3",
   Callback = function(Value)
       print("Temp3:", Value)
   end,
})

-- ========== CHARACTER TAB ==========
local CharacterTab = Window:CreateTab("Character", nil)
local CharacterSection = CharacterTab:CreateSection("Character")

local CharToggle1 = CharacterTab:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Flag = "CharToggle1",
   Callback = function(Value)
       print("Character Temp1:", Value)
   end,
})

local Slider = AutosTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {0, 1000},
   Increment = 10,
   Suffix = "WalkSpeed",
   CurrentValue = 10,
   Flag = "Slider1", -- Unique flag for configuration
   Callback = function(Value)
       print("Slider value:", Value)
   end,
})


local Slider = AutosTab:CreateSlider({
   Name = "JumpPower",
   Range = {0, 1000},
   Increment = 10,
   Suffix = "JumpPower",
   CurrentValue = 10,
   Flag = "Slider1", -- Unique flag for configuration
   Callback = function(Value)
       print("Slider value:", Value)
   end,
})

-- ========== ESP TAB ==========
local ESPTab = Window:CreateTab("ESP", nil)
local ESPSection = ESPTab:CreateSection("ESP")

local Players = game:GetService("Players")

-- Table to store player names
local playerNames = {}

-- Function to refresh the dropdown options
local function refreshDropdown()
    playerNames = {}
    for _, player in ipairs(Players:GetPlayers()) do
        table.insert(playerNames, player.Name)
    end
    Dropdown1:UpdateOptions(playerNames) -- Updates the dropdown with current players
end

-- Create the dropdown
local Dropdown1 = AutosTab:CreateDropdown({
    Name = "Players",
    Options = {},  -- Start empty; we'll populate it dynamically
    CurrentOption = "Select Player",
    MultipleOptions = false,
    Flag = "Dropdown1",
    Callback = function(option)
        print("Selected player:", option)
    end,
})

-- Initial population
refreshDropdown()

-- Update dropdown when a player joins
Players.PlayerAdded:Connect(function(player)
    table.insert(playerNames, player.Name)
    Dropdown1:UpdateOptions(playerNames)
end)

-- Update dropdown when a player leaves
Players.PlayerRemoving:Connect(function(player)
    for i, name in ipairs(playerNames) do
        if name == player.Name then
            table.remove(playerNames, i)
            break
        end
    end
    Dropdown1:UpdateOptions(playerNames)
end)

local ESPToggle2 = ESPTab:CreateToggle({
   Name = "Ores",
   CurrentValue = false,
   Flag = "ESPToggle2",
   Callback = function(Value)
       print("ESP Temp2:", Value)
   end,
})

local ESPToggle3 = ESPTab:CreateToggle({
   Name = "Npc",
   CurrentValue = false,
   Flag = "ESPToggle3",
   Callback = function(Value)
       print("ESP Temp3:", Value)
   end,
})

-- ========== TELEPORT TAB ==========
local TeleportTab = Window:CreateTab("Teleport", nil)
local TeleportSection = TeleportTab:CreateSection("Teleport")

local TeleToggle1 = TeleportTab:CreateToggle({
   Name = "Players",
   CurrentValue = false,
   Flag = "TeleToggle1",
   Callback = function(Value)
       print("Teleport Temp1:", Value)
   end,
})

local TeleToggle2 = TeleportTab:CreateToggle({
   Name = "Ores",
   CurrentValue = false,
   Flag = "TeleToggle2",
   Callback = function(Value)
       print("Teleport Temp2:", Value)
   end,
})

local TeleToggle3 = TeleportTab:CreateToggle({
   Name = "Npc",
   CurrentValue = false,
   Flag = "TeleToggle3",
   Callback = function(Value)
       print("Teleport Temp3:", Value)
   end,
})
