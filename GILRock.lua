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
   Name = "Dropdown Example",
   Options = {"Option 1","Option 2"},
   CurrentOption = "Option 1",
   MultipleOptions = false,
   Flag = "Dropdown1",
   Callback = function(Option)
       print("Selected option:", Option)
   end,
})

local Toggle1 = AutosTab:CreateToggle({
   Name = "Temp1",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
       print("Temp1:", Value)
   end,
})

local Toggle2 = AutosTab:CreateToggle({
   Name = "Temp2",
   CurrentValue = false,
   Flag = "Toggle2",
   Callback = function(Value)
       print("Temp2:", Value)
   end,
})

local Toggle3 = AutosTab:CreateToggle({
   Name = "Temp3",
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
   Name = "Temp1",
   CurrentValue = false,
   Flag = "CharToggle1",
   Callback = function(Value)
       print("Character Temp1:", Value)
   end,
})

local CharToggle2 = CharacterTab:CreateToggle({
   Name = "Temp2",
   CurrentValue = false,
   Flag = "CharToggle2",
   Callback = function(Value)
       print("Character Temp2:", Value)
   end,
})

local CharToggle3 = CharacterTab:CreateToggle({
   Name = "Temp3",
   CurrentValue = false,
   Flag = "CharToggle3",
   Callback = function(Value)
       print("Character Temp3:", Value)
   end,
})

-- ========== ESP TAB ==========
local ESPTab = Window:CreateTab("ESP", nil)
local ESPSection = ESPTab:CreateSection("ESP")

local ESPToggle1 = ESPTab:CreateToggle({
   Name = "Temp1",
   CurrentValue = false,
   Flag = "ESPToggle1",
   Callback = function(Value)
       print("ESP Temp1:", Value)
   end,
})

local ESPToggle2 = ESPTab:CreateToggle({
   Name = "Temp2",
   CurrentValue = false,
   Flag = "ESPToggle2",
   Callback = function(Value)
       print("ESP Temp2:", Value)
   end,
})

local ESPToggle3 = ESPTab:CreateToggle({
   Name = "Temp3",
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
   Name = "Temp1",
   CurrentValue = false,
   Flag = "TeleToggle1",
   Callback = function(Value)
       print("Teleport Temp1:", Value)
   end,
})

local TeleToggle2 = TeleportTab:CreateToggle({
   Name = "Temp2",
   CurrentValue = false,
   Flag = "TeleToggle2",
   Callback = function(Value)
       print("Teleport Temp2:", Value)
   end,
})

local TeleToggle3 = TeleportTab:CreateToggle({
   Name = "Temp3",
   CurrentValue = false,
   Flag = "TeleToggle3",
   Callback = function(Value)
       print("Teleport Temp3:", Value)
   end,
})
