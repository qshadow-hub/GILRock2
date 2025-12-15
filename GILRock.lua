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

local walkSpeedEnabled = false
local jumpPowerEnabled = false
local walkSpeedValue = 16
local jumpPowerValue = 50
local walkSpeedConnection = nil
local jumpPowerConnection = nil

local function applyWalkSpeed()
    local player = game.Players.LocalPlayer
    
    if walkSpeedConnection then
        walkSpeedConnection:Disconnect()
    end
    
    local function setSpeed()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = walkSpeedValue
        end
    end
    
    walkSpeedConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if walkSpeedEnabled then
            setSpeed()
        end
    end)
end

local function applyJumpPower()
    local player = game.Players.LocalPlayer
    
    if jumpPowerConnection then
        jumpPowerConnection:Disconnect()
    end
    
    local function setJump()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character.Humanoid
            if humanoid.UseJumpPower then
                humanoid.JumpPower = jumpPowerValue
            else
                humanoid.JumpHeight = jumpPowerValue / 10
            end
        end
    end
    
    jumpPowerConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if jumpPowerEnabled then
            setJump()
        end
    end)
end

-- Character respawn handler
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    if walkSpeedEnabled then
        applyWalkSpeed()
    end
    if jumpPowerEnabled then
        applyJumpPower()
    end
end)

local WalkSpeedToggle = CharacterTab:CreateToggle({
   Name = "Enable WalkSpeed",
   CurrentValue = false,
   Flag = "WalkSpeedToggle",
   Callback = function(Value)
       walkSpeedEnabled = Value
       if Value then
           applyWalkSpeed()
       elseif walkSpeedConnection then
           walkSpeedConnection:Disconnect()
       end
   end,
})

local Slider1 = CharacterTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {0, 500},
   Increment = 10,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "Slider1",
   Callback = function(Value)
       walkSpeedValue = Value
   end,
})

local JumpPowerToggle = CharacterTab:CreateToggle({
   Name = "Enable JumpPower",
   CurrentValue = false,
   Flag = "JumpPowerToggle",
   Callback = function(Value)
       jumpPowerEnabled = Value
       if Value then
           applyJumpPower()
       elseif jumpPowerConnection then
           jumpPowerConnection:Disconnect()
       end
   end,
})

local Slider2 = CharacterTab:CreateSlider({
   Name = "JumpPower",
   Range = {0, 500},
   Increment = 10,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "Slider2",
   Callback = function(Value)
       jumpPowerValue = Value
   end,
})

-- ========== ESP TAB ==========
local ESPTab = Window:CreateTab("ESP", nil)
local ESPSection = ESPTab:CreateSection("ESP")

-- Player Dropdown for ESP
local Players = game:GetService("Players")
local selectedPlayerESP = nil
local PlayerDropdownESP

local function getPlayerNames()
    local names = {}
    for _, plr in pairs(Players:GetPlayers()) do
        table.insert(names, plr.Name)
    end
    return names
end

PlayerDropdownESP = ESPTab:CreateDropdown({
   Name = "Select Player",
   Options = getPlayerNames(),
   CurrentOption = {"None"},
   MultipleOptions = false,
   Flag = "PlayerDropdownESP",
   Callback = function(Option)
       selectedPlayerESP = Players:FindFirstChild(Option)
       if selectedPlayerESP then
           print("ESP Selected player:", selectedPlayerESP.Name)
       end
   end,
})

-- Create a button to manually refresh player list
local RefreshButtonESP = ESPTab:CreateButton({
   Name = "Refresh Player List",
   Callback = function()
       Rayfield:Notify({
           Title = "Players Updated",
           Content = "Player list has been refreshed!",
           Duration = 2,
           Image = 4483362458,
       })
       -- Update the dropdown options
       PlayerDropdownESP:Set(getPlayerNames())
   end,
})

local OresDropdownESP = ESPTab:CreateDropdown({
   Name = "Select Ore",
   Options = {"Stone","Basalt","LimeStone","Iron","Gold","Diamond","Emerald"},
   CurrentOption = {"Stone"},
   MultipleOptions = false,
   Flag = "OresDropdownESP",
   Callback = function(Option)
       print("ESP Selected ore:", Option)
   end,
})

local NpcDropdownESP = ESPTab:CreateDropdown({
   Name = "Select NPC",
   Options = {"Merchant","Guard","Trader","Boss","Enemy"},
   CurrentOption = {"Merchant"},
   MultipleOptions = false,
   Flag = "NpcDropdownESP",
   Callback = function(Option)
       print("ESP Selected NPC:", Option)
   end,
})

-- Auto refresh on player join/leave
Players.PlayerAdded:Connect(function(plr)
    task.wait(0.5)
    Rayfield:Notify({
        Title = "Player Joined",
        Content = plr.Name .. " joined the game!",
        Duration = 2,
        Image = 4483362458,
    })
end)

Players.PlayerRemoving:Connect(function(plr)
    Rayfield:Notify({
        Title = "Player Left",
        Content = plr.Name .. " left the game!",
        Duration = 2,
        Image = 4483362458,
    })
end)

local ESPToggle2 = ESPTab:CreateToggle({
   Name = "Enable Ores ESP",
   CurrentValue = false,
   Flag = "ESPToggle2",
   Callback = function(Value)
       print("ESP Ores Toggle:", Value)
   end,
})

local ESPToggle3 = ESPTab:CreateToggle({
   Name = "Enable NPC ESP",
   CurrentValue = false,
   Flag = "ESPToggle3",
   Callback = function(Value)
       print("ESP NPC Toggle:", Value)
   end,
})

-- ========== TELEPORT TAB ==========
local TeleportTab = Window:CreateTab("Teleport", nil)
local TeleportSection = TeleportTab:CreateSection("Teleport")

local selectedPlayerTele = nil
local PlayerDropdownTele

PlayerDropdownTele = TeleportTab:CreateDropdown({
   Name = "Select Player",
   Options = getPlayerNames(),
   CurrentOption = {"None"},
   MultipleOptions = false,
   Flag = "PlayerDropdownTele",
   Callback = function(Option)
       selectedPlayerTele = Players:FindFirstChild(Option)
       if selectedPlayerTele then
           print("Teleport Selected player:", selectedPlayerTele.Name)
       end
   end,
})

local RefreshButtonTele = TeleportTab:CreateButton({
   Name = "Refresh Player List",
   Callback = function()
       Rayfield:Notify({
           Title = "Players Updated",
           Content = "Player list has been refreshed!",
           Duration = 2,
           Image = 4483362458,
       })
       PlayerDropdownTele:Set(getPlayerNames())
   end,
})

local OresDropdownTele = TeleportTab:CreateDropdown({
   Name = "Select Ore",
   Options = {"Stone","Basalt","LimeStone","Iron","Gold","Diamond","Emerald"},
   CurrentOption = {"Stone"},
   MultipleOptions = false,
   Flag = "OresDropdownTele",
   Callback = function(Option)
       print("Teleport Selected ore:", Option)
   end,
})

local NpcDropdownTele = TeleportTab:CreateDropdown({
   Name = "Select NPC",
   Options = {"Merchant","Guard","Trader","Boss","Enemy"},
   CurrentOption = {"Merchant"},
   MultipleOptions = false,
   Flag = "NpcDropdownTele",
   Callback = function(Option)
       print("Teleport Selected NPC:", Option)
   end,
})

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
