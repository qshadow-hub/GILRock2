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

local noclipEnabled = false
local Stepped = nil
local NoclipGui = nil

local CharToggle1 = CharacterTab:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Flag = "CharToggle1",
   Callback = function(Value)
       if Value then
           -- Create Noclip GUI
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
           -- Destroy Noclip GUI
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
    
    -- Create BodyVelocity and BodyGyro
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

-- Double space detection
local lastSpacePress = 0
local doubleTapTime = 0.3

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Space then
        local currentTime = tick()
        if currentTime - lastSpacePress <= doubleTapTime then
            -- Double space detected
            flyEnabled = not flyEnabled
            
            if flyEnabled then
                startFly()
                Rayfield:Notify({
                    Title = "Fly Enabled",
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
   Name = "Fly (Double Space)",
   CurrentValue = false,
   Flag = "FlyToggle",
   Callback = function(Value)
       flyEnabled = Value
       
       if Value then
           startFly()
           Rayfield:Notify({
               Title = "Fly Enabled",
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

local BreakAnticheatButton = CharacterTab:CreateButton({
   Name = "Break Anticheats",
   Callback = function()
       local disabledCount = 0
       
       -- Disable LocalScripts
       for _, v in pairs(game:GetDescendants()) do
           if v:IsA("LocalScript") and v.Enabled then
               pcall(function()
                   v.Enabled = false
                   v.Disabled = true
                   disabledCount = disabledCount + 1
               end)
           end
       end
       
       -- Safe metamethod hook
       local success = pcall(function()
           local mt = getrawmetatable(game)
           local oldNamecall = mt.__namecall
           
           setreadonly(mt, false)
           
           mt.__namecall = function(self, ...)
               local method = getnamecallmethod()
               
               -- Block Kick
               if method == "Kick" then
                   return wait(9e9)
               end
               
               -- Block TeleportService
               if method == "Teleport" or method == "TeleportToPlaceInstance" then
                   return wait(9e9)
               end
               
               -- Block anticheat remotes
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
           Title = "Anticheat Bypass",
           Content = "Disabled " .. disabledCount .. " scripts! Hook: " .. (success and "OK" or "Failed"),
           Duration = 3,
           Image = 4483362458,
       })
       
       print("Anticheat bypass - Scripts disabled:", disabledCount, "| Hook:", success and "Success" or "Failed")
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
   Name = "List All NPCs (Console)",
   Callback = function()
       print("========== LISTING ALL NPCs IN WORKSPACE ==========")
       for _, obj in pairs(game.Workspace:GetDescendants()) do
           if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
               print("Found NPC Model:", obj.Name, "at", obj:GetFullName())
           end
       end
       print("========== END OF NPC LIST ==========")
       
       Rayfield:Notify({
           Title = "Check Console",
           Content = "Open F9 to see all NPCs!",
           Duration = 3,
           Image = 4483362458,
       })
   end,
})

local TeleportToNpcButton = TeleportTab:CreateButton({
   Name = "Teleport to NPC",
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
       
       print("========== TELEPORT DEBUG ==========")
       print("Searching for NPC:", selectedNpcTele)
       
       local npc = nil
       local searchName = selectedNpcTele
       
       -- Search all workspace descendants for matching name
       for _, obj in pairs(game.Workspace:GetDescendants()) do
           if obj.Name:lower():find(searchName:lower()) then
               if obj:IsA("Model") or obj:IsA("Part") then
                   npc = obj
                   print("Found match:", obj.Name, "Type:", obj.ClassName, "Path:", obj:GetFullName())
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
                          npc:FindFirstChild("UpperTorso") or
                          npc.PrimaryPart or
                          npc:FindFirstChildWhichIsA("BasePart")
           elseif npc:IsA("BasePart") then
               targetPos = npc
           end
           
           if targetPos then
               print("Teleporting to position:", targetPos.Position)
               player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos.Position + Vector3.new(0, 5, 0))
               
               Rayfield:Notify({
                   Title = "Success!",
                   Content = "Teleported to " .. npc.Name,
                   Duration = 2,
                   Image = 4483362458,
               })
           else
               print("ERROR: Could not find valid part in NPC")
               Rayfield:Notify({
                   Title = "Error",
                   Content = "Could not find valid part in " .. npc.Name,
                   Duration = 3,
                   Image = 4483362458,
               })
           end
       else
           print("ERROR: NPC not found in workspace")
           Rayfield:Notify({
               Title = "NPC Not Found",
               Content = selectedNpcTele .. " not found! Use 'List All NPCs' button",
               Duration = 3,
               Image = 4483362458,
           })
       end
       print("========== END TELEPORT DEBUG ==========")
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
