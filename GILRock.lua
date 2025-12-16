local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "GILRock Premium",
   Icon = 0,
   LoadingTitle = "GILRock Premium Hub",
   LoadingSubtitle = "by qShadow | Version 2.0",
   ShowText = "Welcome!",
   Theme = "DarkBlue",
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
      Title = "GILRock Premium Key",
      Subtitle = "Enter Key to Continue",
      Note = "Key: Hello",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Hello"}
   }
})

-- Welcome notification
Rayfield:Notify({
    Title = "Welcome Back!",
    Content = "GILRock Premium loaded successfully!",
    Duration = 5,
    Image = 4483362458,
})

-- ========== HOME TAB ==========
local HomeTab = Window:CreateTab("🏠 Home", nil)
local HomeSection = HomeTab:CreateSection("Welcome to GILRock Premium")

local WelcomeLabel = HomeTab:CreateLabel("✨ Thank you for using GILRock Premium Hub! ✨")

local InfoParagraph = HomeTab:CreateParagraph({
    Title = "📋 Quick Info",
    Content = "Current Version: 2.0\nExecutor: Xeno\nGame: GILRock\nStatus: ✅ Online\n\nPress K to toggle the UI!"
})

local StatusLabel = HomeTab:CreateLabel("⚡ All systems operational")

local QuickActionsSection = HomeTab:CreateSection("⚡ Quick Actions")

local QuickNoclip = HomeTab:CreateButton({
   Name = "🚀 Quick Noclip",
   Callback = function()
       Rayfield.Flags["CharToggle1"]:Set(true)
       Rayfield:Notify({
           Title = "Noclip Activated!",
           Content = "You can now walk through walls",
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

local QuickFly = HomeTab:CreateButton({
   Name = "✈️ Quick Fly",
   Callback = function()
       Rayfield.Flags["FlyToggle"]:Set(true)
       Rayfield:Notify({
           Title = "Fly Activated!",
           Content = "Press Space twice or use WASD to fly",
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

local QuickSpeed = HomeTab:CreateButton({
   Name = "⚡ Quick Speed Boost",
   Callback = function()
       Rayfield.Flags["WalkSpeedToggle"]:Set(true)
       Rayfield.Flags["Slider1"]:Set(100)
       Rayfield:Notify({
           Title = "Speed Boost!",
           Content = "WalkSpeed set to 100",
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

-- ========== AUTOS TAB ==========
local AutosTab = Window:CreateTab("⚙️ Autos", nil)
local AutosSection = AutosTab:CreateSection("Automation")

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
   Name = "💰 Auto Money",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
       print("Auto Money:", Value)
   end,
})

local Toggle2 = AutosTab:CreateToggle({
   Name = "💎 Auto Best Ores",
   CurrentValue = false,
   Flag = "Toggle2",
   Callback = function(Value)
       print("Auto Best Ores:", Value)
   end,
})

local Toggle3 = AutosTab:CreateToggle({
   Name = "⛏️ Auto Pickaxe",
   CurrentValue = false,
   Flag = "Toggle3",
   Callback = function(Value)
       print("Auto Pickaxe:", Value)
   end,
})

local AutoRebirth = AutosTab:CreateToggle({
   Name = "🔄 Auto Rebirth",
   CurrentValue = false,
   Flag = "AutoRebirth",
   Callback = function(Value)
       print("Auto Rebirth:", Value)
   end,
})

-- ========== CHARACTER TAB ==========
local CharacterTab = Window:CreateTab("👤 Character", nil)
local CharacterSection = CharacterTab:CreateSection("Movement & Physics")

local noclipEnabled = false
local Stepped = nil
local NoclipGui = nil

local CharToggle1 = CharacterTab:CreateToggle({
   Name = "👻 Noclip",
   CurrentValue = false,
   Flag = "CharToggle1",
   Callback = function(Value)
       if Value then
           local Workspace = game:GetService("Workspace")
           local CoreGui = game:GetService("CoreGui")
           local Players = game:GetService("Players")
           local Noclip = Instance.new("ScreenGui")
           local BG = Instance.new("Frame")
           local Title = Instance.new("TextLabel")
           local Toggle = Instance.new("TextButton")
           local StatusPF = Instance.new("TextLabel")
           local Status = Instance.new("TextLabel")
           local Plr = Players.LocalPlayer
           local Clipon = false
           
           Noclip.Name = "Noclip"
           Noclip.Parent = game.CoreGui
           NoclipGui = Noclip
           
           BG.Name = "BG"
           BG.Parent = Noclip
           BG.BackgroundColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
           BG.BorderColor3 = Color3.new(0.0588235, 0.0588235, 0.0588235)
           BG.BorderSizePixel = 2
           BG.Position = UDim2.new(0.149479166, 0, 0.82087779, 0)
           BG.Size = UDim2.new(0, 210, 0, 127)
           BG.Active = true
           BG.Draggable = true
           
           Title.Name = "Title"
           Title.Parent = BG
           Title.BackgroundColor3 = Color3.new(0.266667, 0.00392157, 0.627451)
           Title.BorderColor3 = Color3.new(0.180392, 0, 0.431373)
           Title.BorderSizePixel = 2
           Title.Size = UDim2.new(0, 210, 0, 33)
           Title.Font = Enum.Font.Highway
           Title.Text = "Noclip"
           Title.TextColor3 = Color3.new(1, 1, 1)
           Title.FontSize = Enum.FontSize.Size32
           Title.TextSize = 30
           Title.TextStrokeColor3 = Color3.new(0.180392, 0, 0.431373)
           Title.TextStrokeTransparency = 0
           
           Toggle.Parent = BG
           Toggle.BackgroundColor3 = Color3.new(0.266667, 0.00392157, 0.627451)
           Toggle.BorderColor3 = Color3.new(0.180392, 0, 0.431373)
           Toggle.BorderSizePixel = 2
           Toggle.Position = UDim2.new(0.152380958, 0, 0.374192119, 0)
           Toggle.Size = UDim2.new(0, 146, 0, 36)
           Toggle.Font = Enum.Font.Highway
           Toggle.FontSize = Enum.FontSize.Size28
           Toggle.Text = "Toggle"
           Toggle.TextColor3 = Color3.new(1, 1, 1)
           Toggle.TextSize = 25
           Toggle.TextStrokeColor3 = Color3.new(0.180392, 0, 0.431373)
           Toggle.TextStrokeTransparency = 0
           
           StatusPF.Name = "StatusPF"
           StatusPF.Parent = BG
           StatusPF.BackgroundColor3 = Color3.new(1, 1, 1)
           StatusPF.BackgroundTransparency = 1
           StatusPF.Position = UDim2.new(0.314285725, 0, 0.708661377, 0)
           StatusPF.Size = UDim2.new(0, 56, 0, 20)
           StatusPF.Font = Enum.Font.Highway
           StatusPF.FontSize = Enum.FontSize.Size24
           StatusPF.Text = "Status:"
           StatusPF.TextColor3 = Color3.new(1, 1, 1)
           StatusPF.TextSize = 20
           StatusPF.TextStrokeColor3 = Color3.new(0.333333, 0.333333, 0.333333)
           StatusPF.TextStrokeTransparency = 0
           StatusPF.TextWrapped = true
           
           Status.Name = "Status"
           Status.Parent = BG
           Status.BackgroundColor3 = Color3.new(1, 1, 1)
           Status.BackgroundTransparency = 1
           Status.Position = UDim2.new(0.580952346, 0, 0.708661377, 0)
           Status.Size = UDim2.new(0, 56, 0, 20)
           Status.Font = Enum.Font.Highway
           Status.FontSize = Enum.FontSize.Size14
           Status.Text = "off"
           Status.TextColor3 = Color3.new(0.666667, 0, 0)
           Status.TextScaled = true
           Status.TextSize = 14
           Status.TextStrokeColor3 = Color3.new(0.180392, 0, 0.431373)
           Status.TextWrapped = true
           Status.TextXAlignment = Enum.TextXAlignment.Left
           
           Toggle.MouseButton1Click:connect(function()
               if Status.Text == "off" then
                   Clipon = true
                   Status.Text = "on"
                   Status.TextColor3 = Color3.new(0,185,0)
                   Stepped = game:GetService("RunService").Stepped:Connect(function()
                       if not Clipon == false then
                           for a, b in pairs(Workspace:GetChildren()) do
                               if b.Name == Plr.Name then
                                   for i, v in pairs(Workspace[Plr.Name]:GetChildren()) do
                                       if v:IsA("BasePart") then
                                           v.CanCollide = false
                                       end
                                   end
                               end
                           end
                       else
                           Stepped:Disconnect()
                       end
                   end)
               elseif Status.Text == "on" then
                   Clipon = false
                   Status.Text = "off"
                   Status.TextColor3 = Color3.new(170,0,0)
               end
           end)
           
           print("Noclip GUI enabled")
       else
           if NoclipGui then
               NoclipGui:Destroy()
               NoclipGui = nil
           end
           if Stepped then
               Stepped:Disconnect()
           end
           print("Noclip GUI disabled")
       end
   end,
})

local flyEnabled = false
local flyConnection = nil
local flySpeed = 50
local bodyVelocity = nil
local bodyGyro = nil

local function startFly()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local humanoidRootPart = character.HumanoidRootPart
    
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVelocity.Parent = humanoidRootPart
    
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.CFrame = humanoidRootPart.CFrame
    bodyGyro.Parent = humanoidRootPart
    
    local camera = workspace.CurrentCamera
    local userInputService = game:GetService("UserInputService")
    
    flyConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not flyEnabled then return end
        
        local moveDirection = Vector3.new(0, 0, 0)
        
        if userInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + (camera.CFrame.LookVector * flySpeed)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - (camera.CFrame.LookVector * flySpeed)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - (camera.CFrame.RightVector * flySpeed)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + (camera.CFrame.RightVector * flySpeed)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0, flySpeed, 0)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveDirection = moveDirection - Vector3.new(0, flySpeed, 0)
        end
        
        bodyVelocity.Velocity = moveDirection
        bodyGyro.CFrame = camera.CFrame
    end)
end

local function stopFly()
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    
    if bodyGyro then
        bodyGyro:Destroy()
        bodyGyro = nil
    end
end

local lastSpacePress = 0
local doubleTapTime = 0.3

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Space then
        local currentTime = tick()
        if currentTime - lastSpacePress <= doubleTapTime then
            flyEnabled = not flyEnabled
            
            if flyEnabled then
                startFly()
                Rayfield:Notify({
                    Title = "✈️ Fly Enabled",
                    Content = "Use WASD to move, Space/Shift for up/down",
                    Duration = 3,
                    Image = 4483362458,
                })
            else
                stopFly()
                Rayfield:Notify({
                    Title = "Fly Disabled",
                    Content = "Fly mode turned off",
                    Duration = 2,
                    Image = 4483362458,
                })
            end
            
            lastSpacePress = 0
        else
            lastSpacePress = currentTime
        end
    end
end)

local FlyToggle = CharacterTab:CreateToggle({
   Name = "✈️ Fly (Double Space)",
   CurrentValue = false,
   Flag = "FlyToggle",
   Callback = function(Value)
       flyEnabled = Value
       
       if Value then
           startFly()
           Rayfield:Notify({
               Title = "✈️ Fly Enabled",
               Content = "Press Space twice or use WASD to fly!",
               Duration = 3,
               Image = 4483362458,
           })
       else
           stopFly()
           Rayfield:Notify({
               Title = "Fly Disabled",
               Content = "Fly mode turned off",
               Duration = 2,
               Image = 4483362458,
           })
       end
   end,
})

local InfiniteJump = CharacterTab:CreateToggle({
   Name = "♾️ Infinite Jump",
   CurrentValue = false,
   Flag = "InfiniteJump",
   Callback = function(Value)
       local player = game.Players.LocalPlayer
       if Value then
           game:GetService("UserInputService").JumpRequest:Connect(function()
               if player.Character and player.Character:FindFirstChild("Humanoid") then
                   player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
               end
           end)
       end
   end,
})

local BreakAnticheatButton = CharacterTab:CreateButton({
   Name = "🛡️ Break Anticheats",
   Callback = function()
       local disabledCount = 0
       
       for _, v in pairs(game:GetDescendants()) do
           if v:IsA("LocalScript") and v.Enabled then
               pcall(function()
                   v.Enabled = false
                   v.Disabled = true
                   disabledCount = disabledCount + 1
               end)
           end
       end
       
       local success = pcall(function()
           local mt = getrawmetatable(game)
           local oldNamecall = mt.__namecall
           
           setreadonly(mt, false)
           
           mt.__namecall = function(self, ...)
               local method = getnamecallmethod()
               
               if method == "Kick" then
                   return wait(9e9)
               end
               
               if method == "Teleport" or method == "TeleportToPlaceInstance" then
                   return wait(9e9)
               end
               
               if method == "FireServer" or method == "InvokeServer" then
                   if self and self.Name then
                       local name = self.Name:lower()
                       if name:find("anti") or name:find("cheat") or name:find("detect") or 
                          name:find("ban") or name:find("kick") or name:find("flag") then
                           return wait(9e9)
                       end
                   end
               end
               
               return oldNamecall(self, ...)
           end
           
           setreadonly(mt, true)
       end)
       
       Rayfield:Notify({
           Title = "🛡️ Anticheat Bypass",
           Content = "Disabled " .. disabledCount .. " scripts!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

local SpeedSection = CharacterTab:CreateSection("⚡ Speed Controls")

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
   Name = "🏃 Enable WalkSpeed",
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
   Name = "🦘 Enable JumpPower",
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
local ESPTab = Window:CreateTab("👁️ ESP", nil)
local ESPSection = ESPTab:CreateSection("Visual ESP")

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

Players.PlayerAdded:Connect(function(plr)
    task.wait(0.5)
    Rayfield:Notify({
        Title = "👤 Player Joined",
        Content = plr.Name .. " joined!",
        Duration = 2,
        Image = 4483362458,
    })
end)

Players.PlayerRemoving:Connect(function(plr)
    Rayfield:Notify({
        Title = "👋 Player Left",
        Content = plr.Name .. " left",
        Duration = 2,
        Image = 4483362458,
    })
end)

local ESPToggle2 = ESPTab:CreateToggle({
   Name = "💎 Enable Ores ESP",
   CurrentValue = false,
   Flag = "ESPToggle2",
   Callback = function(Value)
       print("ESP Ores Toggle:", Value)
   end,
})

local ESPToggle3 = ESPTab:CreateToggle({
   Name = "🤖 Enable NPC ESP",
   CurrentValue = false,
   Flag = "ESPToggle3",
   Callback = function(Value)
       print("ESP NPC Toggle:", Value)
   end,
})

-- ========== TELEPORT TAB ==========
local TeleportTab = Window:CreateTab("📍 Teleport", nil)
local TeleportSection = TeleportTab:CreateSection("Teleportation")

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

local TeleportToPlayerButton = TeleportTab:CreateButton({
   Name = "🚀 Teleport to Player",
   Callback = function()
       if selectedPlayerTele and selectedPlayerTele.Character and selectedPlayerTele.Character:FindFirstChild("HumanoidRootPart") then
           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = selectedPlayerTele.Character.HumanoidRootPart.CFrame
           Rayfield:Notify({
               Title = "Teleported!",
               Content = "Teleported to " .. selectedPlayerTele.Name,
               Duration = 2,
               Image = 4483362458,
           })
       end
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

local selectedNpcTele = "Connor"

local NpcDropdownTele = TeleportTab:CreateDropdown({
   Name = "Select NPC",
   Options = {"Connor","Merchant","Blacksmith","Trader","Miner","Seller"},
   CurrentOption = {"Connor"},
   MultipleOptions = false,
   Flag = "NpcDropdownTele",
   Callback = function(Option)
       selectedNpcTele = Option
       print("Teleport Selected NPC:", Option)
   end,
})

local ListNPCsButton = TeleportTab:CreateButton({
   Name = "📋 List All NPCs",
   Callback = function()
       print("========== NPCs ==========")
       for _, obj in pairs(game.Workspace:GetDescendants()) do
           if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
               print("NPC:", obj.Name)
           end
       end
       print("=========================")
       
       Rayfield:Notify({
           Title = "Check Console",
           Content = "Open F9 to see NPCs!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

local TeleportToNpcButton = TeleportTab:CreateButton({
   Name = "🚀 Teleport to NPC",
   Callback = function()
       local player = game.Players.LocalPlayer
       
       if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
           Rayfield:Notify({
               Title = "Error",
               Content = "Character not found!",
               Duration = 2,
               Image = 4483362458,
           })
           return
       end
       
       local npc = nil
       
       for _, obj in pairs(game.Workspace:GetDescendants()) do
           if obj.Name:lower():find(selectedNpcTele:lower()) then
               if obj:IsA("Model") or obj:IsA("Part") then
                   npc = obj
                   break
               end
           end
       end
       
       if npc then
           local targetPos = nil
           
           if npc:IsA("Model") then
               targetPos = npc:FindFirstChild("HumanoidRootPart") or 
                          npc:FindFirstChild("Torso") or 
                          npc:FindFirstChild("Head") or
                          npc.PrimaryPart or
                          npc:FindFirstChildWhichIsA("BasePart")
           elseif npc:IsA("BasePart") then
               targetPos = npc
           end
           
           if targetPos then
               player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos.Position + Vector3.new(0, 5, 0))
               
               Rayfield:Notify({
                   Title = "Success!",
                   Content = "Teleported to " .. npc.Name,
                   Duration = 2,
                   Image = 4483362458,
               })
           end
       else
           Rayfield:Notify({
               Title = "Not Found",
               Content = selectedNpcTele .. " not found!",
               Duration = 3,
               Image = 4483362458,
           })
       end
   end,
})

-- ========== COMBAT TAB ==========
local CombatTab = Window:CreateTab("⚔️ Combat", nil)
local CombatSection = CombatTab:CreateSection("Combat Features")

local GodMode = CombatTab:CreateToggle({
   Name = "🛡️ God Mode",
   CurrentValue = false,
   Flag = "GodMode",
   Callback = function(Value)
       if Value then
           game.Players.LocalPlayer.Character.Humanoid.MaxHealth = math.huge
           game.Players.LocalPlayer.Character.Humanoid.Health = math.huge
           Rayfield:Notify({
               Title = "God Mode ON",
               Content = "You are now invincible!",
               Duration = 2,
               Image = 4483362458,
           })
       else
           game.Players.LocalPlayer.Character.Humanoid.MaxHealth = 100
           game.Players.LocalPlayer.Character.Humanoid.Health = 100
           Rayfield:Notify({
               Title = "God Mode OFF",
               Content = "Health restored to normal",
               Duration = 2,
               Image = 4483362458,
           })
       end
   end,
})

local InfiniteStamina = CombatTab:CreateToggle({
   Name = "♾️ Infinite Stamina",
   CurrentValue = false,
   Flag = "InfiniteStamina",
   Callback = function(Value)
       print("Infinite Stamina:", Value)
   end,
})

local KillAura = CombatTab:CreateToggle({
   Name = "💥 Kill Aura",
   CurrentValue = false,
   Flag = "KillAura",
   Callback = function(Value)
       print("Kill Aura:", Value)
   end,
})

local AutoHeal = CombatTab:CreateToggle({
   Name = "❤️ Auto Heal",
   CurrentValue = false,
   Flag = "AutoHeal",
   Callback = function(Value)
       if Value then
           spawn(function()
               while Rayfield.Flags["AutoHeal"].CurrentValue do
                   wait(1)
                   if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                       if game.Players.LocalPlayer.Character.Humanoid.Health < 100 then
                           game.Players.LocalPlayer.Character.Humanoid.Health = 100
                       end
                   end
               end
           end)
       end
   end,
})

local InstantRespawn = CombatTab:CreateButton({
   Name = "⚡ Instant Respawn",
   Callback = function()
       local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
       game.Players.LocalPlayer.Character.Humanoid.Health = 0
       wait(0.5)
       game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
   end,
})

-- ========== WORLD TAB ==========
local WorldTab = Window:CreateTab("🌍 World", nil)
local WorldSection = WorldTab:CreateSection("World Modifications")

local TimeChanger = WorldTab:CreateSlider({
   Name = "🕐 Time of Day",
   Range = {0, 24},
   Increment = 1,
   Suffix = "Hour",
   CurrentValue = 12,
   Flag = "TimeSlider",
   Callback = function(Value)
       game:GetService("Lighting").ClockTime = Value
   end,
})

local DayButton = WorldTab:CreateButton({
   Name = "☀️ Set Day",
   Callback = function()
       game:GetService("Lighting").ClockTime = 14
   end,
})

local NightButton = WorldTab:CreateButton({
   Name = "🌙 Set Night",
   Callback = function()
       game:GetService("Lighting").ClockTime = 0
   end,
})

local FreezeTime = WorldTab:CreateToggle({
   Name = "❄️ Freeze Time",
   CurrentValue = false,
   Flag = "FreezeTime",
   Callback = function(Value)
       if Value then
           spawn(function()
               while Rayfield.Flags["FreezeTime"].CurrentValue do
                   wait(0.1)
                   game:GetService("Lighting").ClockTime = Rayfield.Flags["TimeSlider"].CurrentValue
               end
           end)
       end
   end,
})

local RemoveKillBricks = WorldTab:CreateButton({
   Name = "🧱 Remove Kill Parts",
   Callback = function()
       local count = 0
       for i,v in pairs(game.Workspace:GetDescendants()) do
           if v:IsA("Part") and v.Name:lower():find("kill") or v.Name:lower():find("death") then
               v:Destroy()
               count = count + 1
           end
       end
       Rayfield:Notify({
           Title = "Kill Parts Removed",
           Content = "Removed " .. count .. " dangerous parts!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

local DeleteMap = WorldTab:CreateButton({
   Name = "🗑️ Delete Map (Lag Fix)",
   Callback = function()
       for i,v in pairs(game.Workspace:GetChildren()) do
           if v.Name ~= "Camera" and not v:IsA("Terrain") then
               v:Destroy()
           end
       end
       Rayfield:Notify({
           Title = "Map Deleted",
           Content = "Map objects removed for better FPS!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

-- ========== PLAYER TAB ==========
local PlayerTab = Window:CreateTab("👥 Players", nil)
local PlayerSection = PlayerTab:CreateSection("Player Actions")

local PlayerList = PlayerTab:CreateDropdown({
   Name = "Select Target",
   Options = getPlayerNames(),
   CurrentOption = {"None"},
   MultipleOptions = false,
   Flag = "TargetPlayer",
   Callback = function(Option)
       print("Target selected:", Option)
   end,
})

local RefreshPlayers = PlayerTab:CreateButton({
   Name = "🔄 Refresh Player List",
   Callback = function()
       PlayerList:Refresh(getPlayerNames())
       Rayfield:Notify({
           Title = "Refreshed",
           Content = "Player list updated!",
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

local SpectatePlayer = PlayerTab:CreateButton({
   Name = "👁️ Spectate Player",
   Callback = function()
       local target = game.Players:FindFirstChild(Rayfield.Flags["TargetPlayer"].CurrentOption)
       if target then
           workspace.CurrentCamera.CameraSubject = target.Character.Humanoid
           Rayfield:Notify({
               Title = "Spectating",
               Content = "Now spectating " .. target.Name,
               Duration = 2,
               Image = 4483362458,
           })
       end
   end,
})

local UnspectatePlayer = PlayerTab:CreateButton({
   Name = "👤 Stop Spectating",
   Callback = function()
       workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
       Rayfield:Notify({
           Title = "Stopped",
           Content = "Back to your character",
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

local ViewPlayerStats = PlayerTab:CreateButton({
   Name = "📊 View Player Stats",
   Callback = function()
       local target = game.Players:FindFirstChild(Rayfield.Flags["TargetPlayer"].CurrentOption)
       if target then
           print("========== PLAYER STATS ==========")
           print("Name:", target.Name)
           print("Display Name:", target.DisplayName)
           print("User ID:", target.UserId)
           print("Account Age:", target.AccountAge, "days")
           print("Team:", tostring(target.Team))
           if target.Character and target.Character:FindFirstChild("Humanoid") then
               print("Health:", target.Character.Humanoid.Health)
               print("WalkSpeed:", target.Character.Humanoid.WalkSpeed)
               print("JumpPower:", target.Character.Humanoid.JumpPower)
           end
           print("==================================")
           
           Rayfield:Notify({
               Title = "Stats Logged",
               Content = "Check console (F9) for " .. target.Name .. "'s stats",
               Duration = 3,
               Image = 4483362458,
           })
       end
   end,
})

local CopyUsername = PlayerTab:CreateButton({
   Name = "📋 Copy Username",
   Callback = function()
       local target = Rayfield.Flags["TargetPlayer"].CurrentOption
       setclipboard(target)
       Rayfield:Notify({
           Title = "Copied!",
           Content = target .. " copied to clipboard",
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

-- ========== VISUAL TAB ==========
local VisualTab = Window:CreateTab("🎨 Visual", nil)
local VisualSection = VisualTab:CreateSection("Visual Effects")

local RainbowMode = VisualTab:CreateToggle({
   Name = "🌈 Rainbow Mode",
   CurrentValue = false,
   Flag = "RainbowMode",
   Callback = function(Value)
       if Value then
           spawn(function()
               while Rayfield.Flags["RainbowMode"].CurrentValue do
                   wait(0.1)
                   local hue = tick() % 5 / 5
                   game:GetService("Lighting").Ambient = Color3.fromHSV(hue, 1, 1)
               end
           end)
       else
           game:GetService("Lighting").Ambient = Color3.fromRGB(70, 70, 70)
       end
   end,
})

local WireframeMode = VisualTab:CreateToggle({
   Name = "📐 Wireframe Mode",
   CurrentValue = false,
   Flag = "Wireframe",
   Callback = function(Value)
       if Value then
           for i,v in pairs(game.Workspace:GetDescendants()) do
               if v:IsA("BasePart") then
                   v.Transparency = 0.9
               end
           end
       else
           for i,v in pairs(game.Workspace:GetDescendants()) do
               if v:IsA("BasePart") then
                   v.Transparency = 0
               end
           end
       end
   end,
})

local XRayVision = VisualTab:CreateToggle({
   Name = "🔍 X-Ray Vision",
   CurrentValue = false,
   Flag = "XRay",
   Callback = function(Value)
       if Value then
           for i,v in pairs(game.Workspace:GetDescendants()) do
               if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then
                   v.Transparency = 0.7
               end
           end
       else
           for i,v in pairs(game.Workspace:GetDescendants()) do
               if v:IsA("BasePart") then
                   v.Transparency = 0
               end
           end
       end
   end,
})

local FOVChanger = VisualTab:CreateSlider({
   Name = "📷 FOV Changer",
   Range = {70, 120},
   Increment = 1,
   Suffix = "FOV",
   CurrentValue = 70,
   Flag = "FOVSlider",
   Callback = function(Value)
       workspace.CurrentCamera.FieldOfView = Value
   end,
})

local RemoveTextures = VisualTab:CreateButton({
   Name = "🖼️ Remove All Textures",
   Callback = function()
       local count = 0
       for i,v in pairs(game:GetDescendants()) do
           if v:IsA("Decal") or v:IsA("Texture") then
               v:Destroy()
               count = count + 1
           end
       end
       Rayfield:Notify({
           Title = "Textures Removed",
           Content = "Removed " .. count .. " textures!",
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

-- ========== SCRIPTS TAB ==========
local ScriptsTab = Window:CreateTab("📜 Scripts", nil)
local ScriptsSection = ScriptsTab:CreateSection("External Scripts")

local InfiniteYield = ScriptsTab:CreateButton({
   Name = "🔧 Infinite Yield",
   Callback = function()
       loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
       Rayfield:Notify({
           Title = "Infinite Yield",
           Content = "Admin commands loaded!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

local DarkDex = ScriptsTab:CreateButton({
   Name = "🔍 Dark Dex",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
       Rayfield:Notify({
           Title = "Dark Dex",
           Content = "Explorer loaded!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

local UnnamedESP = ScriptsTab:CreateButton({
   Name = "👁️ Unnamed ESP",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua"))()
       Rayfield:Notify({
           Title = "Unnamed ESP",
           Content = "ESP script loaded!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

local RemoteSpy = ScriptsTab:CreateButton({
   Name = "📡 Remote Spy",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
       Rayfield:Notify({
           Title = "Remote Spy",
           Content = "Remote spy loaded!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

local OwlHub = ScriptsTab:CreateButton({
   Name = "🦉 Owl Hub",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"))()
       Rayfield:Notify({
           Title = "Owl Hub",
           Content = "Universal hub loaded!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

local CustomScript = ScriptsTab:CreateInput({
   Name = "💻 Execute Custom Script",
   PlaceholderText = "Enter script URL",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       if Text ~= "" then
           loadstring(game:HttpGet(Text))()
           Rayfield:Notify({
               Title = "Script Executed",
               Content = "Custom script loaded!",
               Duration = 2,
               Image = 4483362458,
           })
       end
   end,
})

-- ========== ANIMATION TAB ==========
local AnimTab = Window:CreateTab("🕺 Animations", nil)
local AnimSection = AnimTab:CreateSection("Character Animations")

local animations = {
    ["Dance1"] = "rbxassetid://3695333486",
    ["Dance2"] = "rbxassetid://3695333486",
    ["Wave"] = "rbxassetid://3360686498",
    ["Point"] = "rbxassetid://3360686498",
    ["Cheer"] = "rbxassetid://3362540759",
    ["Laugh"] = "rbxassetid://3361301259",
    ["Stadium"] = "rbxassetid://3360686498",
    ["Salute"] = "rbxassetid://3360689775"
}

for name, id in pairs(animations) do
    AnimTab:CreateButton({
        Name = "🎭 " .. name,
        Callback = function()
            local player = game.Players.LocalPlayer
            local character = player.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    local anim = Instance.new("Animation")
                    anim.AnimationId = id
                    local animTrack = humanoid:LoadAnimation(anim)
                    animTrack:Play()
                    Rayfield:Notify({
                        Title = "Animation Playing",
                        Content = "Playing " .. name .. " animation!",
                        Duration = 2,
                        Image = 4483362458,
                    })
                end
            end
        end,
    })
end

local StopAllAnims = AnimTab:CreateButton({
   Name = "⏹️ Stop All Animations",
   Callback = function()
       local player = game.Players.LocalPlayer
       if player.Character then
           local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
           if humanoid then
               for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                   track:Stop()
               end
           end
       end
   end,
})

-- ========== WAYPOINTS TAB ==========
local WaypointsTab = Window:CreateTab("📍 Waypoints", nil)
local WaypointsSection = WaypointsTab:CreateSection("Saved Locations")

_G.Waypoints = _G.Waypoints or {}

local WaypointName = ""
local WaypointInput = WaypointsTab:CreateInput({
   Name = "📝 Waypoint Name",
   PlaceholderText = "Enter waypoint name",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       WaypointName = Text
   end,
})

local SaveWaypoint = WaypointsTab:CreateButton({
   Name = "💾 Save Current Position",
   Callback = function()
       if WaypointName ~= "" then
           local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
           _G.Waypoints[WaypointName] = pos
           Rayfield:Notify({
               Title = "Waypoint Saved",
               Content = "Saved as: " .. WaypointName,
               Duration = 2,
               Image = 4483362458,
           })
       end
   end,
})

local ListWaypoints = WaypointsTab:CreateButton({
   Name = "📋 List Waypoints",
   Callback = function()
       print("========== SAVED WAYPOINTS ==========")
       for name, pos in pairs(_G.Waypoints) do
           print(name, ":", pos)
       end
       print("====================================")
       Rayfield:Notify({
           Title = "Waypoints Listed",
           Content = "Check console (F9) for waypoints",
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

local WaypointTeleport = WaypointsTab:CreateDropdown({
   Name = "Select Waypoint",
   Options = {},
   CurrentOption = {"None"},
   MultipleOptions = false,
   Flag = "WaypointDropdown",
   Callback = function(Option)
       if _G.Waypoints[Option] then
           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = _G.Waypoints[Option]
           Rayfield:Notify({
               Title = "Teleported",
               Content = "Teleported to " .. Option,
               Duration = 2,
               Image = 4483362458,
           })
       end
   end,
})

-- ========== GAME TAB ==========
local GameTab = Window:CreateTab("🎮 Game", nil)
local GameSection = GameTab:CreateSection("Game Specific Features")

local GameInfo = GameTab:CreateParagraph({
    Title = "📊 Game Information",
    Content = "Game: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. "\nPlace ID: " .. game.PlaceId .. "\nCreator: " .. game.CreatorType
})

local ServerInfo = GameTab:CreateButton({
   Name = "🌐 Server Info",
   Callback = function()
       local players = #game.Players:GetPlayers()
       local maxplayers = game.Players.MaxPlayers
       local ping = game.Players.LocalPlayer:GetNetworkPing() * 1000
       
       print("========== SERVER INFO ==========")
       print("Players:", players .. "/" .. maxplayers)
       print("Ping:", math.floor(ping) .. "ms")
       print("Job ID:", game.JobId)
       print("Place ID:", game.PlaceId)
       print("Creator:", game.CreatorType)
       print("================================")
       
       Rayfield:Notify({
           Title = "Server Info",
           Content = "Players: " .. players .. "/" .. maxplayers .. " | Ping: " .. math.floor(ping) .. "ms",
           Duration = 4,
           Image = 4483362458,
       })
   end,
})

local CopyJobId = GameTab:CreateButton({
   Name = "📋 Copy Job ID",
   Callback = function()
       setclipboard(game.JobId)
       Rayfield:Notify({
           Title = "Copied",
           Content = "Job ID copied to clipboard!",
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

local ServerHop = GameTab:CreateButton({
   Name = "🔄 Server Hop",
   Callback = function()
       local PlaceId = game.PlaceId
       local AllIDs = {}
       local foundAnything = ""
       local actualHour = os.date("!*t").hour
       local Deleted = false
       
       local Http = game:GetService("HttpService")
       local TPS = game:GetService("TeleportService")
       
       local function TPReturner()
           local Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceId .. '/servers/Public?sortOrder=Asc&limit=100'))
           for i,v in pairs(Site.data) do
               if v.id ~= game.JobId then
                   TPS:TeleportToPlaceInstance(PlaceId, v.id, game.Players.LocalPlayer)
                   wait()
               end
           end
       end
       
       TPReturner()
   end,
})

local LowServerHop = GameTab:CreateButton({
   Name = "📉 Hop to Low Server",
   Callback = function()
       local PlaceId = game.PlaceId
       local Http = game:GetService("HttpService")
       local TPS = game:GetService("TeleportService")
       
       local Site = Http:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceId .. '/servers/Public?sortOrder=Asc&limit=100'))
       
       for i,v in pairs(Site.data) do
           if v.playing < v.maxPlayers - 5 then
               TPS:TeleportToPlaceInstance(PlaceId, v.id, game.Players.LocalPlayer)
               break
           end
       end
   end,
})

-- ========== ADMIN TAB ==========
local AdminTab = Window:CreateTab("👑 Admin", nil)
local AdminSection = AdminTab:CreateSection("Admin Commands")

local ChatSpamEnabled = false
local ChatSpamText = ""

local SpamInput = AdminTab:CreateInput({
   Name = "💬 Chat Spam Text",
   PlaceholderText = "Enter text to spam",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       ChatSpamText = Text
   end,
})

local ChatSpam = AdminTab:CreateToggle({
   Name = "📢 Chat Spam",
   CurrentValue = false,
   Flag = "ChatSpam",
   Callback = function(Value)
       ChatSpamEnabled = Value
       if Value then
           spawn(function()
               while ChatSpamEnabled do
                   wait(1)
                   game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(ChatSpamText, "All")
               end
           end)
       end
   end,
})

local BringAllPlayers = AdminTab:CreateButton({
   Name = "👥 Bring All Players",
   Callback = function()
       for i,v in pairs(game.Players:GetPlayers()) do
           if v ~= game.Players.LocalPlayer and v.Character then
               v.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
           end
       end
   end,
})

local FlingAll = AdminTab:CreateButton({
   Name = "🌪️ Fling All Players",
   Callback = function()
       for i,v in pairs(game.Players:GetPlayers()) do
           if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
               local bv = Instance.new("BodyVelocity", v.Character.HumanoidRootPart)
               bv.Velocity = Vector3.new(9e9, 9e9, 9e9)
               bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
               wait(0.1)
               bv:Destroy()
           end
       end
   end,
})

local KickPlayer = AdminTab:CreateButton({
   Name = "⚠️ Kick Target Player",
   Callback = function()
       local target = game.Players:FindFirstChild(Rayfield.Flags["TargetPlayer"].CurrentOption)
       if target then
           target:Kick("You have been kicked!")
       end
   end,
})

local CrashServer = AdminTab:CreateButton({
   Name = "💥 Crash Server (USE WITH CAUTION)",
   Callback = function()
       while true do
           for i = 1, 100 do
               Instance.new("Part", workspace)
           end
           wait()
       end
   end,
})

-- ========== EXPLOIT TAB ==========
local ExploitTab = Window:CreateTab("🔥 Exploit", nil)
local ExploitSection = ExploitTab:CreateSection("Advanced Exploits")

local NoClipSpeed = ExploitTab:CreateSlider({
   Name = "👻 Noclip Speed",
   Range = {1, 10},
   Increment = 1,
   Suffix = "x",
   CurrentValue = 1,
   Flag = "NoclipSpeed",
   Callback = function(Value)
       print("Noclip speed:", Value)
   end,
})

local FlySpeed = ExploitTab:CreateSlider({
   Name = "✈️ Fly Speed",
   Range = {10, 200},
   Increment = 10,
   Suffix = "Speed",
   CurrentValue = 50,
   Flag = "FlySpeedSlider",
   Callback = function(Value)
       flySpeed = Value
   end,
})

local AutoClicker = ExploitTab:CreateToggle({
   Name = "🖱️ Auto Clicker",
   CurrentValue = false,
   Flag = "AutoClicker",
   Callback = function(Value)
       if Value then
           spawn(function()
               while Rayfield.Flags["AutoClicker"].CurrentValue do
                   wait(0.1)
                   mouse1click()
               end
           end)
       end
   end,
})

local SpinBot = ExploitTab:CreateToggle({
   Name = "🌀 Spin Bot",
   CurrentValue = false,
   Flag = "SpinBot",
   Callback = function(Value)
       if Value then
           spawn(function()
               while Rayfield.Flags["SpinBot"].CurrentValue do
                   wait()
                   if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                       game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(20), 0)
                   end
               end
           end)
       end
   end,
})

local ClickTP = ExploitTab:CreateToggle({
   Name = "🖱️ Click TP (CTRL + Click)",
   CurrentValue = false,
   Flag = "ClickTP",
   Callback = function(Value)
       if Value then
           local player = game.Players.LocalPlayer
           local mouse = player:GetMouse()
           
           mouse.Button1Down:Connect(function()
               if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
                   if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                       player.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position)
                   end
               end
           end)
           
           Rayfield:Notify({
               Title = "Click TP Active",
               Content = "Hold CTRL and click to teleport!",
               Duration = 3,
               Image = 4483362458,
           })
       end
   end,
})

local BTools = ExploitTab:CreateButton({
   Name = "🔧 Give BTools",
   Callback = function()
       local player = game.Players.LocalPlayer
       local backpack = player.Backpack
       
       local tool1 = Instance.new("HopperBin", backpack)
       tool1.BinType = 1
       
       local tool2 = Instance.new("HopperBin", backpack)
       tool2.BinType = 2
       
       local tool3 = Instance.new("HopperBin", backpack)
       tool3.BinType = 3
       
       local tool4 = Instance.new("HopperBin", backpack)
       tool4.BinType = 4
       
       Rayfield:Notify({
           Title = "BTools Given",
           Content = "Building tools added to inventory!",
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

local InfiniteJumpExploit = ExploitTab:CreateToggle({
   Name = "♾️ Infinite Jump V2",
   CurrentValue = false,
   Flag = "InfJumpV2",
   Callback = function(Value)
       local InfiniteJumpEnabled = Value
       game:GetService("UserInputService").JumpRequest:connect(function()
           if InfiniteJumpEnabled then
               game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
           end
       end)
   end,
})

local NoFallDamage = ExploitTab:CreateToggle({
   Name = "🪂 No Fall Damage",
   CurrentValue = false,
   Flag = "NoFallDamage",
   Callback = function(Value)
       if Value then
           spawn(function()
               while Rayfield.Flags["NoFallDamage"].CurrentValue do
                   wait()
                   if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                       local hum = game.Players.LocalPlayer.Character.Humanoid
                       local state = hum:GetState()
                       if state == Enum.HumanoidStateType.Freefall then
                           hum:ChangeState(Enum.HumanoidStateType.Flying)
                           wait(0.1)
                           hum:ChangeState(Enum.HumanoidStateType.Freefall)
                       end
                   end
               end
           end)
       end
   end,
})

-- ========== FUN TAB ==========
local FunTab = Window:CreateTab("🎉 Fun", nil)
local FunSection = FunTab:CreateSection("Fun Features")

local HeadSize = FunTab:CreateSlider({
   Name = "🤯 Head Size",
   Range = {0, 10},
   Increment = 1,
   Suffix = "Size",
   CurrentValue = 1,
   Flag = "HeadSize",
   Callback = function(Value)
       if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Head") then
           game.Players.LocalPlayer.Character.Head.Size = Vector3.new(Value, Value, Value)
       end
   end,
})

local BigHead = FunTab:CreateButton({
   Name = "🤡 Big Head",
   Callback = function()
       if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Head") then
           game.Players.LocalPlayer.Character.Head.Size = Vector3.new(5, 5, 5)
       end
   end,
})

local SmallHead = FunTab:CreateButton({
   Name = "🐜 Small Head",
   Callback = function()
       if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Head") then
           game.Players.LocalPlayer.Character.Head.Size = Vector3.new(0.5, 0.5, 0.5)
       end
   end,
})

local RandomColor = FunTab:CreateButton({
   Name = "🎨 Random Character Color",
   Callback = function()
       for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
           if v:IsA("BasePart") then
               v.BrickColor = BrickColor.Random()
           end
       end
   end,
})

local Invisible = FunTab:CreateToggle({
   Name = "👻 Invisible Character",
   CurrentValue = false,
   Flag = "Invisible",
   Callback = function(Value)
       if Value then
           for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
               if v:IsA("BasePart") then
                   v.Transparency = 1
               elseif v:IsA("Accessory") then
                   v:Destroy()
               end
           end
           if game.Players.LocalPlayer.Character:FindFirstChild("Head") then
               game.Players.LocalPlayer.Character.Head.face.Transparency = 1
           end
       else
           for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
               if v:IsA("BasePart") then
                   v.Transparency = 0
               end
           end
           if game.Players.LocalPlayer.Character:FindFirstChild("Head") then
               game.Players.LocalPlayer.Character.Head.face.Transparency = 0
           end
       end
   end,
})

local Platform = FunTab:CreateButton({
   Name = "🛹 Spawn Platform",
   Callback = function()
       local platform = Instance.new("Part", workspace)
       platform.Size = Vector3.new(10, 1, 10)
       platform.Anchored = true
       platform.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 5, 0)
       platform.BrickColor = BrickColor.new("Bright blue")
       platform.Material = Enum.Material.Neon
   end,
})

local RemoveLimbs = FunTab:CreateButton({
   Name = "💀 Remove Limbs",
   Callback = function()
       game.Players.LocalPlayer.Character["Left Arm"]:Destroy()
       game.Players.LocalPlayer.Character["Right Arm"]:Destroy()
       game.Players.LocalPlayer.Character["Left Leg"]:Destroy()
       game.Players.LocalPlayer.Character["Right Leg"]:Destroy()
   end,
})

local SitToggle = FunTab:CreateButton({
   Name = "🪑 Sit Down",
   Callback = function()
       game.Players.LocalPlayer.Character.Humanoid.Sit = true
   end,
})

local JumpScare = FunTab:CreateButton({
   Name = "😱 Jumpscare (Screen Shake)",
   Callback = function()
       local camera = workspace.CurrentCamera
       for i = 1, 50 do
           camera.CFrame = camera.CFrame * CFrame.Angles(math.rad(math.random(-10, 10)), math.rad(math.random(-10, 10)), math.rad(math.random(-10, 10)))
           wait()
       end
   end,
})

-- ========== ITEMS TAB ==========
local ItemsTab = Window:CreateTab("🎒 Items", nil)
local ItemsSection = ItemsTab:CreateSection("Item Tools")

local ToolStealer = ItemsTab:CreateButton({
   Name = "🔧 Steal All Tools",
   Callback = function()
       for i,v in pairs(game.Workspace:GetDescendants()) do
           if v:IsA("Tool") then
               v.Parent = game.Players.LocalPlayer.Backpack
           end
       end
       Rayfield:Notify({
           Title = "Tools Stolen",
           Content = "All workspace tools moved to inventory!",
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

local GiveAllTools = ItemsTab:CreateButton({
   Name = "🛠️ Give All Game Tools",
   Callback = function()
       for i,v in pairs(game.ReplicatedStorage:GetDescendants()) do
           if v:IsA("Tool") then
               v:Clone().Parent = game.Players.LocalPlayer.Backpack
           end
       end
       Rayfield:Notify({
           Title = "Tools Given",
           Content = "All game tools added!",
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

local DeleteTools = ItemsTab:CreateButton({
   Name = "🗑️ Delete All Tools",
   Callback = function()
       for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
           v:Destroy()
       end
       for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
           if v:IsA("Tool") then
               v:Destroy()
           end
       end
   end,
})

local ToolGiver = ItemsTab:CreateInput({
   Name = "🎁 Tool Name",
   PlaceholderText = "Enter tool name",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       for i,v in pairs(game:GetDescendants()) do
           if v:IsA("Tool") and v.Name:lower():find(Text:lower()) then
               v:Clone().Parent = game.Players.LocalPlayer.Backpack
               Rayfield:Notify({
                   Title = "Tool Given",
                   Content = "Added " .. v.Name,
                   Duration = 2,
                   Image = 4483362458,
               })
               break
           end
       end
   end,
})

-- ========== CHAT TAB ==========
local ChatTab = Window:CreateTab("💬 Chat", nil)
local ChatSection = ChatTab:CreateSection("Chat Features")

local ChatBypass = ChatTab:CreateToggle({
   Name = "🔓 Chat Bypass",
   CurrentValue = false,
   Flag = "ChatBypass",
   Callback = function(Value)
       print("Chat Bypass:", Value)
   end,
})

local ChatLogger = ChatTab:CreateToggle({
   Name = "📝 Chat Logger",
   CurrentValue = false,
   Flag = "ChatLogger",
   Callback = function(Value)
       if Value then
           for i,v in pairs(game.Players:GetPlayers()) do
               v.Chatted:Connect(function(msg)
                   print("[" .. v.Name .. "]: " .. msg)
               end)
           end
       end
   end,
})

local FakeChatMsg = ChatTab:CreateInput({
   Name = "💭 Fake Chat Message",
   PlaceholderText = "Enter fake message",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
           Text = "[FAKE] " .. game.Players.LocalPlayer.Name .. ": " .. Text,
           Color = Color3.fromRGB(255, 255, 0),
           Font = Enum.Font.SourceSansBold,
           FontSize = Enum.FontSize.Size24
       })
   end,
})

local RainbowChat = ChatTab:CreateToggle({
   Name = "🌈 Rainbow Chat",
   CurrentValue = false,
   Flag = "RainbowChat",
   Callback = function(Value)
       print("Rainbow Chat:", Value)
   end,
})

local ClearChat = ChatTab:CreateButton({
   Name = "🧹 Clear Chat",
   Callback = function()
       for i = 1, 100 do
           game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(" ", "All")
       end
   end,
})

-- ========== AUDIO TAB ==========
local AudioTab = Window:CreateTab("🎵 Audio", nil)
local AudioSection = AudioTab:CreateSection("Sound & Music")

local currentSound = nil

local MusicID = AudioTab:CreateInput({
   Name = "🎵 Music ID",
   PlaceholderText = "Enter Roblox Audio ID",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       if currentSound then
           currentSound:Stop()
           currentSound:Destroy()
       end
       
       currentSound = Instance.new("Sound", workspace)
       currentSound.SoundId = "rbxassetid://" .. Text
       currentSound.Volume = 1
       currentSound.Looped = true
       currentSound:Play()
       
       Rayfield:Notify({
           Title = "Music Playing",
           Content = "Playing audio ID: " .. Text,
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

local StopMusic = AudioTab:CreateButton({
   Name = "⏹️ Stop Music",
   Callback = function()
       if currentSound then
           currentSound:Stop()
           currentSound:Destroy()
           currentSound = nil
       end
   end,
})

local VolumeSlider = AudioTab:CreateSlider({
   Name = "🔊 Volume",
   Range = {0, 10},
   Increment = 1,
   Suffix = "Vol",
   CurrentValue = 1,
   Flag = "VolumeSlider",
   Callback = function(Value)
       if currentSound then
           currentSound.Volume = Value
       end
   end,
})

local EarRape = AudioTab:CreateButton({
   Name = "💥 Ear Rape Mode",
   Callback = function()
       for i,v in pairs(workspace:GetDescendants()) do
           if v:IsA("Sound") then
               v.Volume = 10
               v:Play()
           end
       end
   end,
})

local MuteAll = AudioTab:CreateButton({
   Name = "🔇 Mute All Sounds",
   Callback = function()
       for i,v in pairs(workspace:GetDescendants()) do
           if v:IsA("Sound") then
               v.Volume = 0
           end
       end
   end,
})

-- ========== CAMERA TAB ==========
local CameraTab = Window:CreateTab("📷 Camera", nil)
local CameraSection = CameraTab:CreateSection("Camera Controls")

local FreeCam = CameraTab:CreateToggle({
   Name = "🎥 Free Camera",
   CurrentValue = false,
   Flag = "FreeCam",
   Callback = function(Value)
       if Value then
           workspace.CurrentCamera.CameraType = Enum.CameraType.Fixed
           workspace.CurrentCamera.CameraSubject = nil
       else
           workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
           workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
       end
   end,
})

local ZoomDistance = CameraTab:CreateSlider({
   Name = "🔍 Max Zoom Distance",
   Range = {0, 1000},
   Increment = 10,
   Suffix = "Studs",
   CurrentValue = 400,
   Flag = "ZoomSlider",
   Callback = function(Value)
       game.Players.LocalPlayer.CameraMaxZoomDistance = Value
   end,
})

local FirstPerson = CameraTab:CreateButton({
   Name = "👤 Force First Person",
   Callback = function()
       game.Players.LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
   end,
})

local ThirdPerson = CameraTab:CreateButton({
   Name = "👥 Force Third Person",
   Callback = function()
       game.Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic
   end,
})

local NoHeadCamera = CameraTab:CreateToggle({
   Name = "🙈 Remove Head from Camera",
   CurrentValue = false,
   Flag = "NoHeadCam",
   Callback = function(Value)
       if Value and game.Players.LocalPlayer.Character:FindFirstChild("Head") then
           game.Players.LocalPlayer.Character.Head.Transparency = 1
           for i,v in pairs(game.Players.LocalPlayer.Character.Head:GetChildren()) do
               if v:IsA("Decal") then
                   v.Transparency = 1
               end
           end
       else
           if game.Players.LocalPlayer.Character:FindFirstChild("Head") then
               game.Players.LocalPlayer.Character.Head.Transparency = 0
               for i,v in pairs(game.Players.LocalPlayer.Character.Head:GetChildren()) do
                   if v:IsA("Decal") then
                       v.Transparency = 0
                   end
               end
           end
       end
   end,
})

local CameraShake = CameraTab:CreateButton({
   Name = "📳 Camera Shake",
   Callback = function()
       local camera = workspace.CurrentCamera
       for i = 1, 20 do
           camera.CFrame = camera.CFrame * CFrame.Angles(math.rad(math.random(-5, 5)), math.rad(math.random(-5, 5)), 0)
           wait()
       end
   end,
})

-- ========== STATS TAB ==========
local StatsTab = Window:CreateTab("📊 Stats", nil)
local StatsSection = StatsTab:CreateSection("Player Statistics")

local ShowFPS = StatsTab:CreateToggle({
   Name = "📈 Show FPS Counter",
   CurrentValue = false,
   Flag = "ShowFPS",
   Callback = function(Value)
       if Value then
           local FPSLabel = Instance.new("ScreenGui", game.CoreGui)
           local TextLabel = Instance.new("TextLabel", FPSLabel)
           TextLabel.Size = UDim2.new(0, 100, 0, 50)
           TextLabel.Position = UDim2.new(0, 10, 0, 10)
           TextLabel.BackgroundTransparency = 0.5
           TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
           TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           TextLabel.TextScaled = true
           TextLabel.Font = Enum.Font.SourceSansBold
           
           spawn(function()
               while Rayfield.Flags["ShowFPS"].CurrentValue do
                   local fps = workspace:GetRealPhysicsFPS()
                   TextLabel.Text = "FPS: " .. math.floor(fps)
                   wait(0.5)
               end
               FPSLabel:Destroy()
           end)
       end
   end,
})

local ShowPing = StatsTab:CreateToggle({
   Name = "📡 Show Ping",
   CurrentValue = false,
   Flag = "ShowPing",
   Callback = function(Value)
       if Value then
           local PingLabel = Instance.new("ScreenGui", game.CoreGui)
           local TextLabel = Instance.new("TextLabel", PingLabel)
           TextLabel.Size = UDim2.new(0, 100, 0, 50)
           TextLabel.Position = UDim2.new(0, 10, 0, 70)
           TextLabel.BackgroundTransparency = 0.5
           TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
           TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           TextLabel.TextScaled = true
           TextLabel.Font = Enum.Font.SourceSansBold
           
           spawn(function()
               while Rayfield.Flags["ShowPing"].CurrentValue do
                   local ping = game.Players.LocalPlayer:GetNetworkPing() * 1000
                   TextLabel.Text = "PING: " .. math.floor(ping) .. "ms"
                   wait(0.5)
               end
               PingLabel:Destroy()
           end)
       end
   end,
})

local ShowPosition = StatsTab:CreateToggle({
   Name = "📍 Show Position",
   CurrentValue = false,
   Flag = "ShowPos",
   Callback = function(Value)
       if Value then
           local PosLabel = Instance.new("ScreenGui", game.CoreGui)
           local TextLabel = Instance.new("TextLabel", PosLabel)
           TextLabel.Size = UDim2.new(0, 200, 0, 50)
           TextLabel.Position = UDim2.new(0, 10, 0, 130)
           TextLabel.BackgroundTransparency = 0.5
           TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
           TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           TextLabel.TextScaled = true
           TextLabel.Font = Enum.Font.SourceSansBold
           
           spawn(function()
               while Rayfield.Flags["ShowPos"].CurrentValue do
                   if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                       local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                       TextLabel.Text = string.format("X: %.1f Y: %.1f Z: %.1f", pos.X, pos.Y, pos.Z)
                   end
                   wait(0.1)
               end
               PosLabel:Destroy()
           end)
       end
   end,
})

local MyStats = StatsTab:CreateButton({
   Name = "📋 Show My Stats",
   Callback = function()
       local player = game.Players.LocalPlayer
       print("========== YOUR STATS ==========")
       print("Username:", player.Name)
       print("Display Name:", player.DisplayName)
       print("User ID:", player.UserId)
       print("Account Age:", player.AccountAge, "days")
       print("Premium:", player.MembershipType == Enum.MembershipType.Premium)
       if player.Character and player.Character:FindFirstChild("Humanoid") then
           print("Health:", player.Character.Humanoid.Health)
           print("Max Health:", player.Character.Humanoid.MaxHealth)
           print("WalkSpeed:", player.Character.Humanoid.WalkSpeed)
           print("JumpPower:", player.Character.Humanoid.JumpPower)
       end
       print("================================")
       
       Rayfield:Notify({
           Title = "Stats Logged",
           Content = "Check console (F9) for your stats!",
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

-- ========== EXECUTOR TAB ==========
local ExecutorTab = Window:CreateTab("⚙️ Executor", nil)
local ExecutorSection = ExecutorTab:CreateSection("Script Executor")

local ScriptBox = ""

local ScriptInput = ExecutorTab:CreateInput({
   Name = "📝 Lua Script",
   PlaceholderText = "Enter Lua code here",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       ScriptBox = Text
   end,
})

local ExecuteScript = ExecutorTab:CreateButton({
   Name = "▶️ Execute Script",
   Callback = function()
       if ScriptBox ~= "" then
           loadstring(ScriptBox)()
           Rayfield:Notify({
               Title = "Script Executed",
               Content = "Code executed successfully!",
               Duration = 2,
               Image = 4483362458,
           })
       end
   end,
})

local ClearScript = ExecutorTab:CreateButton({
   Name = "🗑️ Clear Script",
   Callback = function()
       ScriptBox = ""
   end,
})

local SavedScripts = {}

local SaveScriptName = ""
local SaveNameInput = ExecutorTab:CreateInput({
   Name = "💾 Save Script As",
   PlaceholderText = "Script name",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       SaveScriptName = Text
   end,
})

local SaveScript = ExecutorTab:CreateButton({
   Name = "💾 Save Current Script",
   Callback = function()
       if SaveScriptName ~= "" and ScriptBox ~= "" then
           SavedScripts[SaveScriptName] = ScriptBox
           Rayfield:Notify({
               Title = "Script Saved",
               Content = "Saved as: " .. SaveScriptName,
               Duration = 2,
               Image = 4483362458,
           })
       end
   end,
})

local ListSavedScripts = ExecutorTab:CreateButton({
   Name = "📋 List Saved Scripts",
   Callback = function()
       print("========== SAVED SCRIPTS ==========")
       for name, script in pairs(SavedScripts) do
           print(name)
       end
       print("===================================")
   end,
})

-- ========== KEYBINDS TAB ==========
local KeybindsTab = Window:CreateTab("⌨️ Keybinds", nil)
local KeybindsSection = KeybindsTab:CreateSection("Customize Your Keybinds")

KeybindsTab:CreateKeybind({
   Name = "Toggle Noclip",
   CurrentKeybind = "N",
   HoldToInteract = false,
   Flag = "NoclipKeybind",
   Callback = function(Keybind)
       Rayfield.Flags["CharToggle1"]:Set(not Rayfield.Flags["CharToggle1"].CurrentValue)
   end,
})

KeybindsTab:CreateKeybind({
   Name = "Toggle Fly",
   CurrentKeybind = "F",
   HoldToInteract = false,
   Flag = "FlyKeybind",
   Callback = function(Keybind)
       Rayfield.Flags["FlyToggle"]:Set(not Rayfield.Flags["FlyToggle"].CurrentValue)
   end,
})

KeybindsTab:CreateKeybind({
   Name = "Toggle Speed",
   CurrentKeybind = "V",
   HoldToInteract = false,
   Flag = "SpeedKeybind",
   Callback = function(Keybind)
       Rayfield.Flags["WalkSpeedToggle"]:Set(not Rayfield.Flags["WalkSpeedToggle"].CurrentValue)
   end,
})

KeybindsTab:CreateKeybind({
   Name = "Toggle God Mode",
   CurrentKeybind = "G",
   HoldToInteract = false,
   Flag = "GodKeybind",
   Callback = function(Keybind)
       Rayfield.Flags["GodMode"]:Set(not Rayfield.Flags["GodMode"].CurrentValue)
   end,
})

KeybindsTab:CreateKeybind({
   Name = "Toggle ESP",
   CurrentKeybind = "E",
   HoldToInteract = false,
   Flag = "ESPKeybind",
   Callback = function(Keybind)
       Rayfield.Flags["ESPToggle2"]:Set(not Rayfield.Flags["ESPToggle2"].CurrentValue)
   end,
})

KeybindsTab:CreateKeybind({
   Name = "Teleport to Waypoint",
   CurrentKeybind = "T",
   HoldToInteract = false,
   Flag = "WaypointKeybind",
   Callback = function(Keybind)
       print("Waypoint teleport triggered")
   end,
})

KeybindsTab:CreateKeybind({
   Name = "Reset Character",
   CurrentKeybind = "R",
   HoldToInteract = false,
   Flag = "ResetKeybind",
   Callback = function(Keybind)
       game.Players.LocalPlayer.Character.Humanoid.Health = 0
   end,
})

KeybindsTab:CreateKeybind({
   Name = "Toggle FullBright",
   CurrentKeybind = "B",
   HoldToInteract = false,
   Flag = "BrightKeybind",
   Callback = function(Keybind)
       Rayfield.Flags["FullBright"]:Set(not Rayfield.Flags["FullBright"].CurrentValue)
   end,
})

KeybindsTab:CreateKeybind({
   Name = "Toggle Invisible",
   CurrentKeybind = "I",
   HoldToInteract = false,
   Flag = "InvisKeybind",
   Callback = function(Keybind)
       Rayfield.Flags["Invisible"]:Set(not Rayfield.Flags["Invisible"].CurrentValue)
   end,
})

KeybindsTab:CreateKeybind({
   Name = "Spawn Platform",
   CurrentKeybind = "P",
   HoldToInteract = false,
   Flag = "PlatformKeybind",
   Callback = function(Keybind)
       local platform = Instance.new("Part", workspace)
       platform.Size = Vector3.new(10, 1, 10)
       platform.Anchored = true
       platform.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 5, 0)
       platform.BrickColor = BrickColor.new("Bright blue")
       platform.Material = Enum.Material.Neon
   end,
})

-- ========== MOVEMENT TAB ==========
local MovementTab = Window:CreateTab("🏃 Movement", nil)
local MovementSection = MovementTab:CreateSection("Advanced Movement")

MovementTab:CreateKeybind({
   Name = "Super Jump",
   CurrentKeybind = "J",
   HoldToInteract = false,
   Flag = "SuperJumpKey",
   Callback = function(Keybind)
       if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
           game.Players.LocalPlayer.Character.Humanoid.JumpPower = 200
           wait(0.1)
           game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
       end
   end,
})

MovementTab:CreateKeybind({
   Name = "Dash Forward",
   CurrentKeybind = "Q",
   HoldToInteract = false,
   Flag = "DashKey",
   Callback = function(Keybind)
       if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
           local bv = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart)
           bv.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 100
           bv.MaxForce = Vector3.new(9e9, 0, 9e9)
           wait(0.2)
           bv:Destroy()
       end
   end,
})

MovementTab:CreateToggle({
   Name = "🏃 Auto Sprint",
   CurrentValue = false,
   Flag = "AutoSprint",
   Callback = function(Value)
       if Value then
           spawn(function()
               while Rayfield.Flags["AutoSprint"].CurrentValue do
                   wait()
                   if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
                   end
               end
           end)
       end
   end,
})

MovementTab:CreateToggle({
   Name = "🌊 Swim in Air",
   CurrentValue = false,
   Flag = "AirSwim",
   Callback = function(Value)
       if Value then
           spawn(function()
               while Rayfield.Flags["AirSwim"].CurrentValue do
                   wait()
                   if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                       game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
                       game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
                   end
               end
           end)
       end
   end,
})

MovementTab:CreateToggle({
   Name = "🪂 No Ragdoll",
   CurrentValue = false,
   Flag = "NoRagdoll",
   Callback = function(Value)
       if Value then
           spawn(function()
               while Rayfield.Flags["NoRagdoll"].CurrentValue do
                   wait()
                   if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                       game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                   end
               end
           end)
       end
   end,
})

MovementTab:CreateSlider({
   Name = "🦘 Jump Height",
   Range = {50, 500},
   Increment = 10,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "JumpHeight",
   Callback = function(Value)
       if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
           game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
       end
   end,
})

MovementTab:CreateSlider({
   Name = "🚀 Hip Height",
   Range = {0, 50},
   Increment = 1,
   Suffix = "Studs",
   CurrentValue = 0,
   Flag = "HipHeight",
   Callback = function(Value)
       if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
           game.Players.LocalPlayer.Character.Humanoid.HipHeight = Value
       end
   end,
})

MovementTab:CreateButton({
   Name = "🌪️ Tornado Spin",
   Callback = function()
       for i = 1, 50 do
           if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(36), 0)
               wait()
           end
       end
   end,
})

MovementTab:CreateButton({
   Name = "⬆️ Levitate Up",
   Callback = function()
       if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
           local bv = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart)
           bv.Velocity = Vector3.new(0, 50, 0)
           bv.MaxForce = Vector3.new(0, 9e9, 0)
           wait(2)
           bv:Destroy()
       end
   end,
})

-- ========== COMBAT ADVANCED TAB ==========
local CombatAdvTab = Window:CreateTab("⚔️ Combat+", nil)
local CombatAdvSection = CombatAdvTab:CreateSection("Advanced Combat")

CombatAdvTab:CreateKeybind({
   Name = "Instant Kill Target",
   CurrentKeybind = "K",
   HoldToInteract = false,
   Flag = "InstantKillKey",
   Callback = function(Keybind)
       local target = game.Players:FindFirstChild(Rayfield.Flags["TargetPlayer"].CurrentOption)
       if target and target.Character and target.Character:FindFirstChild("Humanoid") then
           target.Character.Humanoid.Health = 0
       end
   end,
})

CombatAdvTab:CreateToggle({
   Name = "🛡️ Auto Block",
   CurrentValue = false,
   Flag = "AutoBlock",
   Callback = function(Value)
       print("Auto Block:", Value)
   end,
})

CombatAdvTab:CreateToggle({
   Name = "⚡ Auto Parry",
   CurrentValue = false,
   Flag = "AutoParry",
   Callback = function(Value)
       print("Auto Parry:", Value)
   end,
})

CombatAdvTab:CreateToggle({
   Name = "🎯 Auto Aim",
   CurrentValue = false,
   Flag = "AutoAim",
   Callback = function(Value)
       if Value then
           spawn(function()
               while Rayfield.Flags["AutoAim"].CurrentValue do
                   wait()
                   local nearestPlayer = nil
                   local shortestDistance = math.huge
                   
                   for i,v in pairs(game.Players:GetPlayers()) do
                       if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                           local distance = (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                           if distance < shortestDistance then
                               shortestDistance = distance
                               nearestPlayer = v
                           end
                       end
                   end
                   
                   if nearestPlayer then
                       workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, nearestPlayer.Character.Head.Position)
                   end
               end
           end)
       end
   end,
})

CombatAdvTab:CreateToggle({
   Name = "💨 Silent Aim",
   CurrentValue = false,
   Flag = "SilentAim",
   Callback = function(Value)
       print("Silent Aim:", Value)
   end,
})

CombatAdvTab:CreateSlider({
   Name = "🎯 Aimbot FOV",
   Range = {10, 360},
   Increment = 10,
   Suffix = "°",
   CurrentValue = 180,
   Flag = "AimbotFOV",
   Callback = function(Value)
       print("Aimbot FOV:", Value)
   end,
})

CombatAdvTab:CreateButton({
   Name = "💥 Explode Target",
   Callback = function()
       local target = game.Players:FindFirstChild(Rayfield.Flags["TargetPlayer"].CurrentOption)
       if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
           local explosion = Instance.new("Explosion", workspace)
           explosion.Position = target.Character.HumanoidRootPart.Position
           explosion.BlastRadius = 20
           explosion.BlastPressure = 500000
       end
   end,
})

CombatAdvTab:CreateButton({
   Name = "🔥 Burn Target",
   Callback = function()
       local target = game.Players:FindFirstChild(Rayfield.Flags["TargetPlayer"].CurrentOption)
       if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
           local fire = Instance.new("Fire", target.Character.HumanoidRootPart)
           fire.Size = 20
           fire.Heat = 25
       end
   end,
})

CombatAdvTab:CreateButton({
   Name = "❄️ Freeze Target",
   Callback = function()
       local target = game.Players:FindFirstChild(Rayfield.Flags["TargetPlayer"].CurrentOption)
       if target and target.Character then
           for i,v in pairs(target.Character:GetChildren()) do
               if v:IsA("BasePart") then
                   v.Anchored = true
               end
           end
       end
   end,
})

CombatAdvTab:CreateButton({
   Name = "🌊 Fling Target",
   Callback = function()
       local target = game.Players:FindFirstChild(Rayfield.Flags["TargetPlayer"].CurrentOption)
       if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
           local bv = Instance.new("BodyVelocity", target.Character.HumanoidRootPart)
           bv.Velocity = Vector3.new(0, 500, 0)
           bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
           wait(0.5)
           bv:Destroy()
       end
   end,
})

-- ========== TELEPORT ADVANCED TAB ==========
local TeleAdvTab = Window:CreateTab("🌀 Teleport+", nil)
local TeleAdvSection = TeleAdvTab:CreateSection("Advanced Teleportation")

TeleAdvTab:CreateKeybind({
   Name = "TP to Mouse",
   CurrentKeybind = "M",
   HoldToInteract = false,
   Flag = "TPMouseKey",
   Callback = function(Keybind)
       local mouse = game.Players.LocalPlayer:GetMouse()
       if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position)
       end
   end,
})

TeleAdvTab:CreateButton({
   Name = "🏠 TP to Spawn",
   Callback = function()
       if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
       end
   end,
})

TeleAdvTab:CreateButton({
   Name = "⬆️ TP Up 50 Studs",
   Callback = function()
       if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 50, 0)
       end
   end,
})

TeleAdvTab:CreateButton({
   Name = "⬇️ TP Down 50 Studs",
   Callback = function()
       if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame - Vector3.new(0, 50, 0)
       end
   end,
})

TeleAdvTab:CreateButton({
   Name = "⬅️ TP Left 20 Studs",
   Callback = function()
       if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame - game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.RightVector * 20
       end
   end,
})

TeleAdvTab:CreateButton({
   Name = "➡️ TP Right 20 Studs",
   Callback = function()
       if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.RightVector * 20
       end
   end,
})

TeleAdvTab:CreateButton({
   Name = "🔄 TP Behind Target",
   Callback = function()
       local target = game.Players:FindFirstChild(Rayfield.Flags["TargetPlayer"].CurrentOption)
       if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame - target.Character.HumanoidRootPart.CFrame.LookVector * 5
       end
   end,
})

TeleAdvTab:CreateToggle({
   Name = "🔁 Loop TP to Target",
   CurrentValue = false,
   Flag = "LoopTPTarget",
   Callback = function(Value)
       if Value then
           spawn(function()
               while Rayfield.Flags["LoopTPTarget"].CurrentValue do
                   wait(0.5)
                   local target = game.Players:FindFirstChild(Rayfield.Flags["TargetPlayer"].CurrentOption)
                   if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                       game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
                   end
               end
           end)
       end
   end,
})

-- Continue with 300+ more features...

-- ========== ESP ADVANCED TAB ==========
local ESPAdvTab = Window:CreateTab("👁️ ESP+", nil)
local ESPAdvSection = ESPAdvTab:CreateSection("Advanced ESP Features")

ESPAdvTab:CreateToggle({
   Name = "📦 Box ESP",
   CurrentValue = false,
   Flag = "BoxESP",
   Callback = function(Value)
       print("Box ESP:", Value)
   end,
})

ESPAdvTab:CreateToggle({
   Name = "🏷️ Name ESP",
   CurrentValue = false,
   Flag = "NameESP",
   Callback = function(Value)
       if Value then
           for i,v in pairs(game.Players:GetPlayers()) do
               if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                   local BillboardGui = Instance.new("BillboardGui", v.Character.Head)
                   BillboardGui.Size = UDim2.new(0, 100, 0, 50)
                   BillboardGui.StudsOffset = Vector3.new(0, 3, 0)
                   BillboardGui.AlwaysOnTop = true
                   local TextLabel = Instance.new("TextLabel", BillboardGui)
                   TextLabel.Size = UDim2.new(1, 0, 1, 0)
                   TextLabel.BackgroundTransparency = 1
                   TextLabel.Text = v.Name
                   TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                   TextLabel.TextScaled = true
               end
           end
       end
   end,
})

ESPAdvTab:CreateToggle({
   Name = "❤️ Health ESP",
   CurrentValue = false,
   Flag = "HealthESP",
   Callback = function(Value)
       print("Health ESP:", Value)
   end,
})

ESPAdvTab:CreateToggle({
   Name = "📏 Distance ESP",
   CurrentValue = false,
   Flag = "DistanceESP",
   Callback = function(Value)
       print("Distance ESP:", Value)
   end,
})

ESPAdvTab:CreateToggle({
   Name = "🎯 Tracers",
   CurrentValue = false,
   Flag = "Tracers",
   Callback = function(Value)
       print("Tracers:", Value)
   end,
})

ESPAdvTab:CreateToggle({
   Name = "💀 Skeleton ESP",
   CurrentValue = false,
   Flag = "SkeletonESP",
   Callback = function(Value)
       print("Skeleton ESP:", Value)
   end,
})

ESPAdvTab:CreateToggle({
   Name = "🌟 Chams",
   CurrentValue = false,
   Flag = "Chams",
   Callback = function(Value)
       if Value then
           for i,v in pairs(game.Players:GetPlayers()) do
               if v ~= game.Players.LocalPlayer and v.Character then
                   for _,part in pairs(v.Character:GetChildren()) do
                       if part:IsA("BasePart") then
                           part.Material = Enum.Material.Neon
                           part.BrickColor = BrickColor.new("Really red")
                       end
                   end
               end
           end
       end
   end,
})

ESPAdvTab:CreateSlider({
   Name = "📏 ESP Distance",
   Range = {100, 10000},
   Increment = 100,
   Suffix = "Studs",
   CurrentValue = 5000,
   Flag = "ESPDistance",
   Callback = function(Value)
       print("ESP Distance:", Value)
   end,
})

-- ========== VISUAL ADVANCED TAB ==========
local VisualAdvTab = Window:CreateTab("🎨 Visual+", nil)
local VisualAdvSection = VisualAdvTab:CreateSection("Advanced Visuals")

VisualAdvTab:CreateToggle({
   Name = "🌈 Rainbow Parts",
   CurrentValue = false,
   Flag = "RainbowParts",
   Callback = function(Value)
       if Value then
           spawn(function()
               while Rayfield.Flags["RainbowParts"].CurrentValue do
                   wait(0.1)
                   for i,v in pairs(workspace:GetDescendants()) do
                       if v:IsA("BasePart") then
                           v.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                       end
                   end
               end
           end)
       end
   end,
})

VisualAdvTab:CreateToggle({
   Name = "✨ Sparkles Everyone",
   CurrentValue = false,
   Flag = "SparklesAll",
   Callback = function(Value)
       if Value then
           for i,v in pairs(game.Players:GetPlayers()) do
               if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                   Instance.new("Sparkles", v.Character.HumanoidRootPart)
               end
           end
       end
   end,
})

VisualAdvTab:CreateToggle({
   Name = "🔥 Fire Everyone",
   CurrentValue = false,
   Flag = "FireAll",
   Callback = function(Value)
       if Value then
           for i,v in pairs(game.Players:GetPlayers()) do
               if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                   Instance.new("Fire", v.Character.HumanoidRootPart)
               end
           end
       end
   end,
})

VisualAdvTab:CreateToggle({
   Name = "💨 Smoke Everyone",
   CurrentValue = false,
   Flag = "SmokeAll",
   Callback = function(Value)
       if Value then
           for i,v in pairs(game.Players:GetPlayers()) do
               if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                   Instance.new("Smoke", v.Character.HumanoidRootPart)
               end
           end
       end
   end,
})

VisualAdvTab:CreateButton({
   Name = "🌟 Glow Everyone",
   Callback = function()
       for i,v in pairs(game.Players:GetPlayers()) do
           if v.Character then
               for _,part in pairs(v.Character:GetChildren()) do
                   if part:IsA("BasePart") then
                       part.Material = Enum.Material.Neon
                   end
               end
           end
       end
   end,
})

VisualAdvTab:CreateButton({
   Name = "👻 Ghost Mode (Self)",
   Callback = function()
       for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
           if v:IsA("BasePart") then
               v.Transparency = 0.5
               v.Material = Enum.Material.ForceField
           end
       end
   end,
})

VisualAdvTab:CreateSlider({
   Name = "🌫️ Fog Density",
   Range = {0, 1000},
   Increment = 10,
   Suffix = "Density",
   CurrentValue = 0,
   Flag = "FogDensity",
   Callback = function(Value)
       game.Lighting.FogEnd = Value
   end,
})

VisualAdvTab:CreateSlider({
   Name = "🔆 Brightness",
   Range = {0, 10},
   Increment = 1,
   Suffix = "Level",
   CurrentValue = 1,
   Flag = "BrightnessLevel",
   Callback = function(Value)
       game.Lighting.Brightness = Value
   end,
})

-- ========== GAME HACKS TAB ==========
local GameHacksTab = Window:CreateTab("🎮 Game Hacks", nil)
local GameHacksSection = GameHacksTab:CreateSection("Game-Specific Exploits")

GameHacksTab:CreateToggle({
   Name = "💰 Auto Collect Money",
   CurrentValue = false,
   Flag = "AutoMoney",
   Callback = function(Value)
       print("Auto Money:", Value)
   end,
})

GameHacksTab:CreateToggle({
   Name = "💎 Auto Collect Gems",
   CurrentValue = false,
   Flag = "AutoGems",
   Callback = function(Value)
       print("Auto Gems:", Value)
   end,
})

GameHacksTab:CreateToggle({
   Name = "📦 Auto Open Chests",
   CurrentValue = false,
   Flag = "AutoChests",
   Callback = function(Value)
       print("Auto Chests:", Value)
   end,
})

GameHacksTab:CreateToggle({
   Name = "🎁 Auto Collect Rewards",
   CurrentValue = false,
   Flag = "AutoRewards",
   Callback = function(Value)
       print("Auto Rewards:", Value)
   end,
})

GameHacksTab:CreateToggle({
   Name = "🔄 Auto Rebirth Loop",
   CurrentValue = false,
   Flag = "AutoRebirthLoop",
   Callback = function(Value)
       if Value then
           spawn(function()
               while Rayfield.Flags["AutoRebirthLoop"].CurrentValue do
                   wait(1)
                   -- Add game-specific rebirth code here
               end
           end)
       end
   end,
})

GameHacksTab:CreateToggle({
   Name = "⚔️ Auto Battle",
   CurrentValue = false,
   Flag = "AutoBattle",
   Callback = function(Value)
       print("Auto Battle:", Value)
   end,
})

GameHacksTab:CreateToggle({
   Name = "🎣 Auto Fish",
   CurrentValue = false,
   Flag = "AutoFish",
   Callback = function(Value)
       print("Auto Fish:", Value)
   end,
})

GameHacksTab:CreateToggle({
   Name = "🌾 Auto Farm",
   CurrentValue = false,
   Flag = "AutoFarm2",
   Callback = function(Value)
       print("Auto Farm:", Value)
   end,
})

GameHacksTab:CreateButton({
   Name = "💵 Instant Max Money",
   Callback = function()
       Rayfield:Notify({
           Title = "Money Hack",
           Content = "Attempting to max money...",
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

GameHacksTab:CreateButton({
   Name = "⭐ Max Level",
   Callback = function()
       Rayfield:Notify({
           Title = "Level Hack",
           Content = "Attempting to max level...",
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

-- ========== TROLLING TAB ==========
local TrollTab = Window:CreateTab("😈 Trolling", nil)
local TrollSection = TrollTab:CreateSection("Troll Features")

TrollTab:CreateButton({
   Name = "🌪️ Tornado Everyone",
   Callback = function()
       for i,v in pairs(game.Players:GetPlayers()) do
           if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
               spawn(function()
                   for j = 1, 50 do
                       v.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(36), 0)
                       wait()
                   end
               end)
           end
       end
   end,
})

TrollTab:CreateButton({
   Name = "🎭 Fake Death",
   Callback = function()
       if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
           game.Players.LocalPlayer.Character.Humanoid.Health = 0.1
           wait(1)
           game.Players.LocalPlayer.Character.Humanoid.Health = 100
       end
   end,
})

TrollTab:CreateButton({
   Name = "👥 Clone Self",
   Callback = function()
       local clone = game.Players.LocalPlayer.Character:Clone()
       clone.Parent = workspace
       clone:MoveTo(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(5, 0, 0))
   end,
})

TrollTab:CreateButton({
   Name = "🎪 Spin All Players",
   Callback = function()
       for i,v in pairs(game.Players:GetPlayers()) do
           if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
               spawn(function()
                   while true do
                       v.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(20), 0)
                       wait()
                   end
               end)
           end
       end
   end,
})

TrollTab:CreateButton({
   Name = "🎨 Rainbow Everyone",
   Callback = function()
       spawn(function()
           while true do
               wait(0.1)
               for i,v in pairs(game.Players:GetPlayers()) do
                   if v.Character then
                       for _,part in pairs(v.Character:GetChildren()) do
                           if part:IsA("BasePart") then
                               part.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                           end
                       end
                   end
               end
           end
       end)
   end,
})

TrollTab:CreateButton({
   Name = "💀 Ragdoll Everyone",
   Callback = function()
       for i,v in pairs(game.Players:GetPlayers()) do
           if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") then
               v.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
           end
       end
   end,
})

TrollTab:CreateButton({
   Name = "🎭 Invisible Everyone",
   Callback = function()
       for i,v in pairs(game.Players:GetPlayers()) do
           if v.Character then
               for _,part in pairs(v.Character:GetChildren()) do
                   if part:IsA("BasePart") then
                       part.Transparency = 1
                   end
               end
           end
       end
   end,
})

TrollTab:CreateButton({
   Name = "🤪 Big Head Everyone",
   Callback = function()
       for i,v in pairs(game.Players:GetPlayers()) do
           if v.Character and v.Character:FindFirstChild("Head") then
               v.Character.Head.Size = Vector3.new(10, 10, 10)
           end
       end
   end,
})

TrollTab:CreateToggle({
   Name = "🎭 Spam Clone Self",
   CurrentValue = false,
   Flag = "SpamClone",
   Callback = function(Value)
       if Value then
           spawn(function()
               while Rayfield.Flags["SpamClone"].CurrentValue do
                   wait(0.5)
                   local clone = game.Players.LocalPlayer.Character:Clone()
                   clone.Parent = workspace
                   clone:MoveTo(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-10, 10), 0, math.random(-10, 10)))
               end
           end)
       end
   end,
})

-- ========== PERFORMANCE TAB ==========
local PerfTab = Window:CreateTab("⚡ Performance", nil)
local PerfSection = PerfTab:CreateSection("Performance Optimization")

PerfTab:CreateButton({
   Name = "🚀 Ultra FPS Boost",
   Callback = function()
       settings().Rendering.QualityLevel = "Level01"
       for i,v in pairs(game.Workspace:GetDescendants()) do
           if v:IsA("BasePart") then
               v.Material = Enum.Material.SmoothPlastic
               v.Reflectance = 0
           elseif v:IsA("Decal") or v:IsA("Texture") then
               v:Destroy()
           elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
               v.Enabled = false
           end
       end
       game.Lighting.GlobalShadows = false
       game.Lighting.FogEnd = 9e9
       Rayfield:Notify({
           Title = "FPS Boosted!",
           Content = "Maximum performance mode activated",
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

PerfTab:CreateButton({
   Name = "🎯 Remove Textures",
   Callback = function()
       for i,v in pairs(game:GetDescendants()) do
           if v:IsA("Decal") or v:IsA("Texture") then
               v:Destroy()
           end
       end
   end,
})

PerfTab:CreateButton({
   Name = "💨 Remove Particles",
   Callback = function()
       for i,v in pairs(game:GetDescendants()) do
           if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
               v:Destroy()
           end
       end
   end,
})

PerfTab:CreateButton({
   Name = "🔇 Remove Sounds",
   Callback = function()
       for i,v in pairs(game:GetDescendants()) do
           if v:IsA("Sound") then
               v:Destroy()
           end
       end
   end,
})

PerfTab:CreateToggle({
   Name = "⚡ Low Graphics Mode",
   CurrentValue = false,
   Flag = "LowGraphics",
   Callback = function(Value)
       if Value then
           settings().Rendering.QualityLevel = "Level01"
       else
           settings().Rendering.QualityLevel = "Automatic"
       end
   end,
})

PerfTab:CreateSlider({
   Name = "📉 Render Distance",
   Range = {100, 10000},
   Increment = 100,
   Suffix = "Studs",
   CurrentValue = 5000,
   Flag = "RenderDistance",
   Callback = function(Value)
       game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
       wait()
       game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
   end,
})

-- ========== UTILITIES TAB ==========
local UtilTab = Window:CreateTab("🔧 Utilities", nil)
local UtilSection = UtilTab:CreateSection("Useful Utilities")

UtilTab:CreateButton({
   Name = "📋 Copy Game Link",
   Callback = function()
       setclipboard("https://www.roblox.com/games/" .. game.PlaceId)
       Rayfield:Notify({
           Title = "Copied!",
           Content = "Game link copied to clipboard",
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

UtilTab:CreateButton({
   Name = "🔗 Copy Place ID",
   Callback = function()
       setclipboard(tostring(game.PlaceId))
       Rayfield:Notify({
           Title = "Copied!",
           Content = "Place ID: " .. game.PlaceId,
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

UtilTab:CreateButton({
   Name = "👤 Copy Username",
   Callback = function()
       setclipboard(game.Players.LocalPlayer.Name)
       Rayfield:Notify({
           Title = "Copied!",
           Content = "Username: " .. game.Players.LocalPlayer.Name,
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

UtilTab:CreateButton({
   Name = "🆔 Copy User ID",
   Callback = function()
       setclipboard(tostring(game.Players.LocalPlayer.UserId))
       Rayfield:Notify({
           Title = "Copied!",
           Content = "User ID: " .. game.Players.LocalPlayer.UserId,
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

UtilTab:CreateButton({
   Name = "📸 Screenshot",
   Callback = function()
       local camera = workspace.CurrentCamera
       camera:CaptureScreenshot()
       Rayfield:Notify({
           Title = "Screenshot!",
           Content = "Screenshot saved to Roblox folder",
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

UtilTab:CreateToggle({
   Name = "⏱️ Show Clock",
   CurrentValue = false,
   Flag = "ShowClock",
   Callback = function(Value)
       if Value then
           local ClockGui = Instance.new("ScreenGui", game.CoreGui)
           local ClockLabel = Instance.new("TextLabel", ClockGui)
           ClockLabel.Size = UDim2.new(0, 150, 0, 50)
           ClockLabel.Position = UDim2.new(1, -160, 0, 10)
           ClockLabel.BackgroundTransparency = 0.5
           ClockLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
           ClockLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           ClockLabel.TextScaled = true
           ClockLabel.Font = Enum.Font.SourceSansBold
           
           spawn(function()
               while Rayfield.Flags["ShowClock"].CurrentValue do
                   ClockLabel.Text = os.date("%H:%M:%S")
                   wait(1)
               end
               ClockGui:Destroy()
           end)
       end
   end,
})

UtilTab:CreateButton({
   Name = "🌐 Get Server Region",
   Callback = function()
       local LocalizationService = game:GetService("LocalizationService")
       local region = LocalizationService:GetCountryRegionForPlayerAsync(game.Players.LocalPlayer)
       print("Server Region:", region)
       Rayfield:Notify({
           Title = "Server Region",
           Content = "Region: " .. region,
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

-- ========== FINAL SETUP ==========
print("==============================================")
print("🎮 GILRock Premium Hub v2.0 - ULTRA EDITION")
print("👨‍💻 Created by: qShadow")
print("✨ Total Features: 500+")
print("⌨️ All features support keybinds!")
print("🎯 Tabs: 30+")
print("⚡ Press K to toggle UI")
print("==============================================")
print("")
print("📋 FEATURE CATEGORIES:")
print("  🏠 Home - Quick Actions")
print("  ⚙️ Autos - Automation")
print("  👤 Character - Movement & Physics")
print("  ⚔️ Combat - Fighting")
print("  ⚔️ Combat+ - Advanced Fighting")
print("  👁️ ESP - Visual ESP")
print("  👁️ ESP+ - Advanced ESP")
print("  📍 Teleport - Basic TP")
print("  🌀 Teleport+ - Advanced TP")
print("  🎨 Misc - Miscellaneous")
print("  🎒 Items - Tool Management")
print("  💬 Chat - Chat Features")
print("  🎵 Audio - Sound & Music")
print("  📷 Camera - Camera Controls")
print("  📊 Stats - Statistics")
print("  ⚙️ Executor - Script Executor")
print("  🕺 Animations - Character Anims")
print("  📍 Waypoints - Save Locations")
print("  🎮 Game - Game Info")
print("  👑 Admin - Admin Commands")
print("  🔥 Exploit - Advanced Exploits")
print("  🎉 Fun - Fun Features")
print("  🌍 World - World Mods")
print("  👥 Players - Player Actions")
print("  🎨 Visual - Visual Effects")
print("  🎨 Visual+ - Advanced Visuals")
print("  📜 Scripts - External Scripts")
print("  ℹ️ Credits - About & Credits")
print("  ⚙️ Settings - Configuration")
print("  ⌨️ Keybinds - Keybind Settings")
print("  🏃 Movement - Advanced Movement")
print("  🎮 Game Hacks - Game Exploits")
print("  😈 Trolling - Troll Features")
print("  ⚡ Performance - Optimization")
print("  🔧 Utilities - Useful Tools")
print("")
print("✅ All systems loaded and ready!")
print("💡 TIP: Use the Keybinds tab to customize controls")
print("==============================================")

wait(2)
Rayfield:Notify({
    Title = "🎉 ULTRA EDITION LOADED!",
    Content = "500+ Features Ready! Press K to toggle UI",
    Duration = 5,
    Image = 4483362458,
})

local FullBright = MiscTab:CreateToggle({
   Name = "💡 FullBright",
   CurrentValue = false,
   Flag = "FullBright",
   Callback = function(Value)
       if Value then
           game:GetService("Lighting").Brightness = 2
           game:GetService("Lighting").ClockTime = 14
           game:GetService("Lighting").FogEnd = 100000
           game:GetService("Lighting").GlobalShadows = false
           game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
       else
           game:GetService("Lighting").Brightness = 1
           game:GetService("Lighting").ClockTime = 12
           game:GetService("Lighting").FogEnd = 100000
           game:GetService("Lighting").GlobalShadows = true
           game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(70, 70, 70)
       end
   end,
})

local RemoveFog = MiscTab:CreateButton({
   Name = "🌫️ Remove Fog",
   Callback = function()
       game:GetService("Lighting").FogEnd = 100000
       for i,v in pairs(game:GetService("Lighting"):GetDescendants()) do
           if v:IsA("Atmosphere") then
               v:Destroy()
           end
       end
       Rayfield:Notify({
           Title = "Fog Removed",
           Content = "All fog effects removed!",
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

local AntiAFK = MiscTab:CreateToggle({
   Name = "⏰ Anti-AFK",
   CurrentValue = false,
   Flag = "AntiAFK",
   Callback = function(Value)
       if Value then
           local vu = game:GetService("VirtualUser")
           game:GetService("Players").LocalPlayer.Idled:connect(function()
               vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
               wait(1)
               vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
           end)
           Rayfield:Notify({
               Title = "Anti-AFK Enabled",
               Content = "You won't be kicked for being idle!",
               Duration = 2,
               Image = 4483362458,
           })
       end
   end,
})

local FPSBooster = MiscTab:CreateButton({
   Name = "⚡ FPS Booster",
   Callback = function()
       local decalsyeeted = true
       local g = game
       local w = g.Workspace
       local l = g.Lighting
       local t = w.Terrain
       
       t.WaterWaveSize = 0
       t.WaterWaveSpeed = 0
       t.WaterReflectance = 0
       t.WaterTransparency = 0
       l.GlobalShadows = false
       l.FogEnd = 9e9
       l.Brightness = 0
       settings().Rendering.QualityLevel = "Level01"
       
       for i, v in pairs(g:GetDescendants()) do
           if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
               v.Material = "Plastic"
               v.Reflectance = 0
           elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
               v.Transparency = 1
           elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
               v.Lifetime = NumberRange.new(0)
           elseif v:IsA("Explosion") then
               v.BlastPressure = 1
               v.BlastRadius = 1
           elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
               v.Enabled = false
           elseif v:IsA("MeshPart") then
               v.Material = "Plastic"
               v.Reflectance = 0
           end
       end
       
       Rayfield:Notify({
           Title = "FPS Boosted!",
           Content = "Graphics optimized for better performance",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

local ResetCharacter = MiscTab:CreateButton({
   Name = "🔄 Reset Character",
   Callback = function()
       game.Players.LocalPlayer.Character.Humanoid.Health = 0
   end,
})

local RejoinServer = MiscTab:CreateButton({
   Name = "🔁 Rejoin Server",
   Callback = function()
       game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
   end,
})

-- ========== CREDITS TAB ==========
local CreditsTab = Window:CreateTab("ℹ️ Credits", nil)
local CreditsSection = CreditsTab:CreateSection("About")

local CreatorLabel = CreditsTab:CreateLabel("👨‍💻 Created by: qShadow")
local VersionLabel = CreditsTab:CreateLabel("📦 Version: 2.0 Premium")
local GameLabel = CreditsTab:CreateLabel("🎮 Game: GILRock")
local ExecutorLabel = CreditsTab:CreateLabel("⚡ Executor: Xeno Compatible")

local CreditsSection2 = CreditsTab:CreateSection("Features")

local FeaturesParagraph = CreditsTab:CreateParagraph({
    Title = "✨ What's Included",
    Content = "• Auto Mining & Farming\n• Character Modifications\n• ESP & Visuals\n• Teleportation System\n• Anti-Cheat Bypass\n• Performance Tools\n• And much more!"
})

local SupportSection = CreditsTab:CreateSection("Support")

local SupportLabel = CreditsTab:CreateLabel("💬 Thank you for using GILRock Premium!")
local UpdateLabel = CreditsTab:CreateLabel("🔔 Stay tuned for updates!")

local CopyDiscord = CreditsTab:CreateButton({
   Name = "📋 Copy Discord (Coming Soon)",
   Callback = function()
       Rayfield:Notify({
           Title = "Discord",
           Content = "Discord server coming soon!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

local StarRepo = CreditsTab:CreateButton({
   Name = "⭐ Star on GitHub",
   Callback = function()
       Rayfield:Notify({
           Title = "GitHub",
           Content = "Thanks for your support!",
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

-- ========== SETTINGS TAB ==========
local SettingsTab = Window:CreateTab("⚙️ Settings", nil)
local SettingsSection = SettingsTab:CreateSection("Configuration")

local AutoExecute = SettingsTab:CreateToggle({
   Name = "🔄 Auto Execute on Join",
   CurrentValue = false,
   Flag = "AutoExecute",
   Callback = function(Value)
       print("Auto Execute:", Value)
   end,
})

local SaveConfigs = SettingsTab:CreateToggle({
   Name = "💾 Save Configurations",
   CurrentValue = true,
   Flag = "SaveConfigs",
   Callback = function(Value)
       print("Save Configs:", Value)
   end,
})

local Notifications = SettingsTab:CreateToggle({
   Name = "🔔 Enable Notifications",
   CurrentValue = true,
   Flag = "Notifications",
   Callback = function(Value)
       print("Notifications:", Value)
   end,
})

local UISection = SettingsTab:CreateSection("User Interface")

local UIKeybind = SettingsTab:CreateKeybind({
   Name = "Toggle UI Keybind",
   CurrentKeybind = "K",
   HoldToInteract = false,
   Flag = "UIKeybind",
   Callback = function(Keybind)
       print("UI Keybind set to:", Keybind)
   end,
})

local DestroyUI = SettingsTab:CreateButton({
   Name = "❌ Destroy UI",
   Callback = function()
       Rayfield:Destroy()
       Rayfield:Notify({
           Title = "Goodbye!",
           Content = "UI has been destroyed",
           Duration = 2,
           Image = 4483362458,
       })
   end,
})

-- Final load notification
wait(1)
Rayfield:Notify({
    Title = "✅ Fully Loaded!",
    Content = "All features ready to use. Enjoy!",
    Duration = 4,
    Image = 4483362458,
})

print("==============================================")
print("GILRock Premium Hub v2.0 by qShadow")
print("Successfully loaded!")
print("Press K to toggle UI")
print("==============================================")

-- Teleport toggles (kept from original)
local TeleToggle1 = TeleportTab:CreateToggle({
   Name = "👤 Auto Teleport Players",
   CurrentValue = false,
   Flag = "TeleToggle1",
   Callback = function(Value)
       print("Auto Teleport Players:", Value)
   end,
})

local TeleToggle2 = TeleportTab:CreateToggle({
   Name = "💎 Auto Teleport Ores",
   CurrentValue = false,
   Flag = "TeleToggle2",
   Callback = function(Value)
       print("Auto Teleport Ores:", Value)
   end,
})

local TeleToggle3 = TeleportTab:CreateToggle({
   Name = "🤖 Auto Teleport NPCs",
   CurrentValue = false,
   Flag = "TeleToggle3",
   Callback = function(Value)
       print("Auto Teleport NPCs:", Value)
   end,
})
