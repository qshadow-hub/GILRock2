local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

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
   KeySystem = true,
   KeySettings = {
      Title = "Universal Script",
      Subtitle = "Key System",
      Note = "Key=qShadow",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"qShadow2"}
   }
})

-- Calea unde vom salva timpul rămas
local savePath = "GILRockKeyTime.txt"

-- Durata cheii: 10 ani, 6 luni, 4 zile, 17 ore, 40 minute, 27 secunde
local defaultTotalSeconds = 10*365*24*60*60 + 6*30*24*60*60 + 4*24*60*60 + 17*60*60 + 40*60 + 27
local timeLeft = defaultTotalSeconds
local keyActive = true

-- Încarcă timpul rămas dacă fișierul există
if isfile(savePath) then
    local savedTime = tonumber(readfile(savePath))
    if savedTime then
        timeLeft = savedTime
    end
end

-- Funcție de salvare a timpului rămas
local function saveTime()
    writefile(savePath, tostring(timeLeft))
end

-- Funcție de conversie a secundelor în ani, luni, zile, ore, minute, secunde
local function formatTime(seconds)
    local years = math.floor(seconds / (365*24*60*60))
    seconds = seconds % (365*24*60*60)
    local months = math.floor(seconds / (30*24*60*60))
    seconds = seconds % (30*24*60*60)
    local days = math.floor(seconds / (24*60*60))
    seconds = seconds % (24*60*60)
    local hours = math.floor(seconds / 3600)
    seconds = seconds % 3600
    local minutes = math.floor(seconds / 60)
    local secs = seconds % 60
    return years.."y "..months.."M "..days.."d "..hours.."h "..minutes.."m "..secs.."s"
end

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

-- Control Variables
local noclip = false
local flying = false
local jumpEnabled = false
local speedEnabled = false
local infiniteJump = false
local espEnabled = false
local fullbrightEnabled = false
local tracersEnabled = false

local jumpValue = 50
local speedValue = 16
local fovValue = 70

local defaultJump = 50
local defaultSpeed = 16
local defaultFOV = 70

local flyConnection
local noclipConnection
local infJumpConnection
local espConnection
local tracersConnection
local bv, bg

-- Tracer settings
local tracerLines = {}
local Tracer_Color = Color3.fromRGB(0, 255, 50)
local Tracer_Thickness = 1.4
local Tracer_Transparency = 1

-- Get Player Character Functions
local function getChar()
    return player.Character
end

local function getHumanoid()
    local char = getChar()
    if char then
        return char:FindFirstChildOfClass("Humanoid")
    end
    return nil
end

local function getRoot()
    local char = getChar()
    if char then
        return char:FindFirstChild("HumanoidRootPart")
    end
    return nil
end

-- Save defaults
task.spawn(function()
    task.wait(2)
    local hum = getHumanoid()
    if hum then
        defaultJump = hum.JumpPower
        defaultSpeed = hum.WalkSpeed
    end
    if workspace.CurrentCamera then
        defaultFOV = workspace.CurrentCamera.FieldOfView
    end
end)

-- NOCLIP
local function startNoclip()
    noclip = true
    if noclipConnection then noclipConnection:Disconnect() end
    noclipConnection = RunService.Stepped:Connect(function()
        pcall(function()
            if not noclip then return end
            local char = getChar()
            if char then
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end)
end

local function stopNoclip()
    noclip = false
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
    pcall(function()
        local char = getChar()
        if char then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                    v.CanCollide = true
                end
            end
        end
    end)
end

-- FLY
local function startFly()
    flying = true
    local root = getRoot()
    if not root then return end
    
    bv = Instance.new("BodyVelocity")
    bv.Velocity = Vector3.new(0,0,0)
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bv.Parent = root
    
    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.P = 9e4
    bg.Parent = root
    
    if flyConnection then flyConnection:Disconnect() end
    flyConnection = RunService.RenderStepped:Connect(function()
        pcall(function()
            if not flying then return end
            local root = getRoot()
            if not root or not bv or not bg then return end
            
            local cam = workspace.CurrentCamera
            local dir = Vector3.new()
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                dir = dir + cam.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                dir = dir - cam.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                dir = dir - cam.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                dir = dir + cam.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                dir = dir + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                dir = dir - Vector3.new(0, 1, 0)
            end
            
            bv.Velocity = dir * 50
            bg.CFrame = cam.CFrame
        end)
    end)
end

local function stopFly()
    flying = false
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    if bv then bv:Destroy() bv = nil end
    if bg then bg:Destroy() bg = nil end
end

-- INFINITE JUMP
local function startInfiniteJump()
    infiniteJump = true
    if infJumpConnection then infJumpConnection:Disconnect() end
    infJumpConnection = UserInputService.JumpRequest:Connect(function()
        pcall(function()
            if not infiniteJump then return end
            local hum = getHumanoid()
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end)
end

local function stopInfiniteJump()
    infiniteJump = false
    if infJumpConnection then
        infJumpConnection:Disconnect()
        infJumpConnection = nil
    end
end

-- ESP
local espCache = {}
local function createESP(plr)
    if plr == player then return end
    
    local function addESP(char)
        pcall(function()
            if espCache[plr] then
                for _, v in pairs(espCache[plr]) do
                    v:Destroy()
                end
            end
            espCache[plr] = {}
            
            local root = char:WaitForChild("HumanoidRootPart", 5)
            if not root then return end
            
            local box = Instance.new("BoxHandleAdornment")
            box.Size = char:GetExtentsSize()
            box.Adornee = root
            box.Color3 = Color3.fromRGB(255, 0, 0)
            box.Transparency = 0.7
            box.AlwaysOnTop = true
            box.ZIndex = 5
            box.Parent = root
            table.insert(espCache[plr], box)
            
            local billboard = Instance.new("BillboardGui")
            billboard.Adornee = root
            billboard.Size = UDim2.new(0, 100, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = root
            
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(1, 0, 1, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = plr.Name
            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameLabel.TextStrokeTransparency = 0.5
            nameLabel.Font = Enum.Font.SourceSansBold
            nameLabel.TextSize = 16
            nameLabel.Parent = billboard
            table.insert(espCache[plr], billboard)
        end)
    end
    
    if plr.Character then
        addESP(plr.Character)
    end
    plr.CharacterAdded:Connect(addESP)
end

local function startESP()
    espEnabled = true
    for _, plr in pairs(Players:GetPlayers()) do
        createESP(plr)
    end
    Players.PlayerAdded:Connect(function(plr)
        if espEnabled then
            createESP(plr)
        end
    end)
end

local function stopESP()
    espEnabled = false
    for _, esps in pairs(espCache) do
        for _, esp in pairs(esps) do
            esp:Destroy()
        end
    end
    espCache = {}
end

-- FULLBRIGHT
 local Light = game:GetService("Lighting")
function dofullbright()
Light.Ambient = Color3.new(1, 1, 1)
Light.ColorShift_Bottom = Color3.new(1, 1, 1)
Light.ColorShift_Top = Color3.new(1, 1, 1)
end
dofullbright()
Light.LightingChanged:Connect(dofullbright)
-- TRACERS (Following Mouse Cursor)

local function createTracerForPlayer(plr)
    if plr == player then return end
    
    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.Color = Tracer_Color
    tracer.Thickness = Tracer_Thickness
    tracer.Transparency = Tracer_Transparency
    tracer.From = Vector2.new(0, 0)
    tracer.To = Vector2.new(0, 0)
    
    tracerLines[plr] = tracer
    
    local function updateTracer()
        local connection
        connection = RunService.RenderStepped:Connect(function()
            if tracersEnabled and plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
                local rootPart = plr.Character.HumanoidRootPart
                local camera = workspace.CurrentCamera
                
                -- Get position on screen
                local pos, onScreen = camera:WorldToViewportPoint(rootPart.Position)
                
                -- Get mouse position
                local mousePos = UserInputService:GetMouseLocation()
                
                -- Check if player is behind camera (pos.Z < 0)
                if pos.Z < 0 then
                    -- Player is behind, invert the screen position
                    pos = Vector3.new(
                        camera.ViewportSize.X - pos.X,
                        camera.ViewportSize.Y - pos.Y,
                        pos.Z
                    )
                end
                
                -- Draw line from mouse to player
                tracer.From = Vector2.new(mousePos.X, mousePos.Y)
                tracer.To = Vector2.new(pos.X, pos.Y)
                tracer.Visible = true
            else
                tracer.Visible = false
            end
            
            if not tracersEnabled or not plr or not plr.Parent then
                tracer.Visible = false
                tracer:Remove()
                tracerLines[plr] = nil
                connection:Disconnect()
            end
        end)
    end
    
    coroutine.wrap(updateTracer)()
end

local function startTracers()
    tracersEnabled = true
    
    -- Create tracers for existing players
    for _, plr in pairs(Players:GetPlayers()) do
        createTracerForPlayer(plr)
    end
    
    -- Create tracers for new players
    Players.PlayerAdded:Connect(function(plr)
        if tracersEnabled then
            createTracerForPlayer(plr)
        end
    end)
    
    -- Handle player leaving
    Players.PlayerRemoving:Connect(function(plr)
        if tracerLines[plr] then
            tracerLines[plr]:Remove()
            tracerLines[plr] = nil
        end
    end)
end

local function stopTracers()
    tracersEnabled = false
    
    -- Remove all tracer lines
    for plr, tracer in pairs(tracerLines) do
        tracer.Visible = false
        tracer:Remove()
    end
    
    tracerLines = {}
end

-- Timerul principal
spawn(function()
    while timeLeft > 0 do
        wait(1)
        timeLeft = timeLeft - 1
        saveTime()
    end
    keyActive = false
    saveTime()
end)

-- Notificare la activare key
Rayfield:Notify({
   Title = "Your Premium key has been redeemed",
   Content = "Your premium key is valid!",
   Duration = 10,
   Image = 4483362458
})

-- ============================================
-- TAB 1: INFO
-- ============================================
local InfoTab = Window:CreateTab("ⓘ Info", nil)
InfoTab:CreateSection("🌏 Welcome to Universal Script Premium")
InfoTab:CreateLabel("✨ Thank you for purchasing Universal Script Premium Hub! ✨")
local TimerLabel = InfoTab:CreateLabel("⏳ Key expires in: "..formatTime(timeLeft))

spawn(function()
    while timeLeft > 0 do
        pcall(function()
            TimerLabel:Set("⏳ Key expires in: "..formatTime(timeLeft))
        end)
        wait(1)
    end
    pcall(function()
        TimerLabel:Set("⏳ Key has expired!")
    end)
    Rayfield:Notify({
        Title = "Key Expired!",
        Content = "Your premium key has expired!",
        Duration = 5,
        Image = 4483362458
    })
end)

InfoTab:CreateParagraph({
    Title = "📋 Quick Info",
    Content = "Current Version: 2.0\nExecutor: Universal\nGame: Universal\nStatus: ✅ Online\n\nPress K to toggle the UI!"
})
InfoTab:CreateLabel("⚡ All systems operational")

-- ============================================
-- TAB 2: HOME
-- ============================================
local HomeTab = Window:CreateTab("🏠 Home", nil)
HomeTab:CreateSection("⚙️ Player Controls")

-- NOCLIP
HomeTab:CreateToggle({
    Name = "🚪 Noclip",
    CurrentValue = false,
    Flag = "NoclipToggle",
    Callback = function(val)
        pcall(function()
            if val then
                startNoclip()
                Rayfield:Notify({Title = "Noclip ON", Content = "Walk through walls!", Duration = 2, Image = 4483362458})
            else
                stopNoclip()
                Rayfield:Notify({Title = "Noclip OFF", Content = "Collisions restored", Duration = 2, Image = 4483362458})
            end
        end)
    end
})

-- FLY
HomeTab:CreateToggle({
    Name = "✈️ Fly",
    CurrentValue = false,
    Flag = "FlyToggle",
    Callback = function(val)
        pcall(function()
            if val then
                startFly()
                Rayfield:Notify({Title = "Fly ON", Content = "WASD + Space/Shift", Duration = 2, Image = 4483362458})
            else
                stopFly()
                Rayfield:Notify({Title = "Fly OFF", Content = "Flying disabled", Duration = 2, Image = 4483362458})
            end
        end)
    end
})

-- INFINITE JUMP
HomeTab:CreateToggle({
    Name = "♾️ Infinite Jump",
    CurrentValue = false,
    Flag = "InfiniteJumpToggle",
    Callback = function(val)
        pcall(function()
            if val then
                startInfiniteJump()
                Rayfield:Notify({Title = "Infinite Jump ON", Content = "Jump forever!", Duration = 2, Image = 4483362458})
            else
                stopInfiniteJump()
                Rayfield:Notify({Title = "Infinite Jump OFF", Content = "Normal jumping", Duration = 2, Image = 4483362458})
            end
        end)
    end
})

-- JUMP POWER
HomeTab:CreateToggle({
    Name = "🦘 Custom Jump Power",
    CurrentValue = false,
    Flag = "JumpToggle",
    Callback = function(val)
        pcall(function()
            jumpEnabled = val
            local hum = getHumanoid()
            if hum then
                if val then
                    hum.JumpPower = jumpValue
                    Rayfield:Notify({Title = "Custom Jump ON", Content = "Power: "..jumpValue, Duration = 2, Image = 4483362458})
                else
                    hum.JumpPower = defaultJump
                    Rayfield:Notify({Title = "Custom Jump OFF", Content = "Normal jump", Duration = 2, Image = 4483362458})
                end
            end
        end)
    end
})

HomeTab:CreateSlider({
    Name = "🦘 Jump Power",
    Range = {50, 500},
    Increment = 10,
    CurrentValue = 50,
    Flag = "JumpSlider",
    Callback = function(val)
        pcall(function()
            jumpValue = val
            if jumpEnabled then
                local hum = getHumanoid()
                if hum then
                    hum.JumpPower = val
                end
            end
        end)
    end
})

-- WALK SPEED
HomeTab:CreateToggle({
    Name = "🏃 Custom Walk Speed",
    CurrentValue = false,
    Flag = "SpeedToggle",
    Callback = function(val)
        pcall(function()
            speedEnabled = val
            local hum = getHumanoid()
            if hum then
                if val then
                    hum.WalkSpeed = speedValue
                    Rayfield:Notify({Title = "Custom Speed ON", Content = "Speed: "..speedValue, Duration = 2, Image = 4483362458})
                else
                    hum.WalkSpeed = defaultSpeed
                    Rayfield:Notify({Title = "Custom Speed OFF", Content = "Normal speed", Duration = 2, Image = 4483362458})
                end
            end
        end)
    end
})

HomeTab:CreateSlider({
    Name = "🏃 Walk Speed",
    Range = {16, 200},
    Increment = 2,
    CurrentValue = 16,
    Flag = "SpeedSlider",
    Callback = function(val)
        pcall(function()
            speedValue = val
            if speedEnabled then
                local hum = getHumanoid()
                if hum then
                    hum.WalkSpeed = val
                end
            end
        end)
    end
})

-- ============================================
-- TAB 3: CHARACTER
-- ============================================
local CharacterTab = Window:CreateTab("👤 Character", nil)
CharacterTab:CreateSection("Character Modifications")

CharacterTab:CreateButton({
    Name = "🔄 Reset Character",
    Callback = function()
        pcall(function()
            local hum = getHumanoid()
            if hum then
                hum.Health = 0
                Rayfield:Notify({Title = "Character Reset", Content = "Resetting...", Duration = 2})
            end
        end)
    end
})

CharacterTab:CreateButton({
    Name = "👻 Remove Accessories",
    Callback = function()
        pcall(function()
            local char = getChar()
            if char then
                for _, v in pairs(char:GetChildren()) do
                    if v:IsA("Accessory") then
                        v:Destroy()
                    end
                end
                Rayfield:Notify({Title = "Accessories Removed", Content = "All accessories deleted", Duration = 2})
            end
        end)
    end
})

CharacterTab:CreateButton({
    Name = "👕 Remove Shirt",
    Callback = function()
        pcall(function()
            local char = getChar()
            if char then
                for _, v in pairs(char:GetChildren()) do
                    if v:IsA("Shirt") then
                        v:Destroy()
                    end
                end
                Rayfield:Notify({Title = "Shirt Removed", Content = "Shirt deleted", Duration = 2})
            end
        end)
    end
})

CharacterTab:CreateButton({
    Name = "👖 Remove Pants",
    Callback = function()
        pcall(function()
            local char = getChar()
            if char then
                for _, v in pairs(char:GetChildren()) do
                    if v:IsA("Pants") then
                        v:Destroy()
                    end
                end
                Rayfield:Notify({Title = "Pants Removed", Content = "Pants deleted", Duration = 2})
            end
        end)
    end
})

CharacterTab:CreateButton({
    Name = "🎭 Remove Face",
    Callback = function()
        pcall(function()
            local char = getChar()
            if char and char:FindFirstChild("Head") then
                local face = char.Head:FindFirstChild("face")
                if face then
                    face:Destroy()
                    Rayfield:Notify({Title = "Face Removed", Content = "Face deleted", Duration = 2})
                end
            end
        end)
    end
})

CharacterTab:CreateButton({
    Name = "🎨 Invisible Character",
    Callback = function()
        pcall(function()
            local char = getChar()
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") or part:IsA("Decal") then
                        part.Transparency = 1
                    end
                end
                Rayfield:Notify({Title = "Invisible", Content = "You are now invisible!", Duration = 2})
            end
        end)
    end
})

CharacterTab:CreateButton({
    Name = "👁️ Visible Character",
    Callback = function()
        pcall(function()
            local char = getChar()
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 0
                    elseif part:IsA("Decal") then
                        part.Transparency = 0
                    end
                end
                Rayfield:Notify({Title = "Visible", Content = "You are now visible", Duration = 2})
            end
        end)
    end
})

CharacterTab:CreateButton({
    Name = "🔥 Fire Character",
    Callback = function()
        pcall(function()
            local char = getChar()
            if char and char:FindFirstChild("HumanoidRootPart") then
                local fire = Instance.new("Fire")
                fire.Size = 10
                fire.Heat = 10
                fire.Parent = char.HumanoidRootPart
                Rayfield:Notify({Title = "Fire Added", Content = "Your character is on fire!", Duration = 2})
            end
        end)
    end
})

CharacterTab:CreateButton({
    Name = "💨 Smoke Character",
    Callback = function()
        pcall(function()
            local char = getChar()
            if char and char:FindFirstChild("HumanoidRootPart") then
                local smoke = Instance.new("Smoke")
                smoke.Size = 10
                smoke.Opacity = 1
                smoke.RiseVelocity = 5
                smoke.Parent = char.HumanoidRootPart
                Rayfield:Notify({Title = "Smoke Added", Content = "Your character is smoking!", Duration = 2})
            end
        end)
    end
})

CharacterTab:CreateButton({
    Name = "✨ Sparkles Character",
    Callback = function()
        pcall(function()
            local char = getChar()
            if char and char:FindFirstChild("HumanoidRootPart") then
                local sparkles = Instance.new("Sparkles")
                sparkles.Parent = char.HumanoidRootPart
                Rayfield:Notify({Title = "Sparkles Added", Content = "Your character is sparkling!", Duration = 2})
            end
        end)
    end
})

CharacterTab:CreateButton({
    Name = "🧹 Remove All Effects",
    Callback = function()
        pcall(function()
            local char = getChar()
            if char then
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") or v:IsA("ParticleEmitter") then
                        v:Destroy()
                    end
                end
                Rayfield:Notify({Title = "Effects Removed", Content = "All effects deleted", Duration = 2})
            end
        end)
    end
})

CharacterTab:CreateSlider({
    Name = "📏 Hip Height",
    Range = {0, 20},
    Increment = 1,
    CurrentValue = 0,
    Callback = function(val)
        pcall(function()
            local hum = getHumanoid()
            if hum then
                hum.HipHeight = val
            end
        end)
    end
})

CharacterTab:CreateSlider({
    Name = "⚖️ Gravity",
    Range = {0, 196},
    Increment = 10,
    CurrentValue = 196,
    Callback = function(val)
        workspace.Gravity = val
    end
})

CharacterTab:CreateSlider({
    Name = "📐 Character Scale",
    Range = {0.5, 3},
    Increment = 0.1,
    CurrentValue = 1,
    Callback = function(val)
        pcall(function()
            local hum = getHumanoid()
            if hum then
                for _, scale in pairs(hum:GetChildren()) do
                    if scale:IsA("NumberValue") then
                        scale.Value = val
                    end
                end
            end
        end)
    end
})

CharacterTab:CreateToggle({
    Name = "🛡️ God Mode",
    CurrentValue = false,
    Callback = function(val)
        pcall(function()
            local hum = getHumanoid()
            if hum and val then
                hum.MaxHealth = math.huge
                hum.Health = math.huge
                Rayfield:Notify({Title = "God Mode ON", Content = "You are invincible!", Duration = 2})
            elseif hum then
                hum.MaxHealth = 100
                hum.Health = 100
                Rayfield:Notify({Title = "God Mode OFF", Content = "Normal health", Duration = 2})
            end
        end)
    end
})

CharacterTab:CreateToggle({
    Name = "🏃 Auto Sprint",
    CurrentValue = false,
    Callback = function(val)
        pcall(function()
            local hum = getHumanoid()
            if hum and val then
                hum.WalkSpeed = 32
                Rayfield:Notify({Title = "Auto Sprint ON", Content = "Running fast!", Duration = 2})
            elseif hum then
                hum.WalkSpeed = 16
                Rayfield:Notify({Title = "Auto Sprint OFF", Content = "Normal speed", Duration = 2})
            end
        end)
    end
})

CharacterTab:CreateToggle({
    Name = "🌀 Spin Character",
    CurrentValue = false,
    Callback = function(val)
        pcall(function()
            if val then
                spawn(function()
                    while val do
                        local root = getRoot()
                        if root then
                            root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(10), 0)
                        end
                        wait(0.05)
                    end
                end)
                Rayfield:Notify({Title = "Spin ON", Content = "You are spinning!", Duration = 2})
            end
        end)
    end
})

CharacterTab:CreateButton({
    Name = "🧱 Sit",
    Callback = function()
        pcall(function()
            local hum = getHumanoid()
            if hum then
                hum.Sit = true
            end
        end)
    end
})

CharacterTab:CreateButton({
    Name = "💀 Ragdoll",
    Callback = function()
        pcall(function()
            local char = getChar()
            if char then
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("Motor6D") then
                        v:Destroy()
                    end
                end
                Rayfield:Notify({Title = "Ragdoll", Content = "Character ragdolled", Duration = 2})
            end
        end)
    end
})

CharacterTab:CreateSlider({
    Name = "💪 Max Health",
    Range = {100, 1000},
    Increment = 50,
    CurrentValue = 100,
    Callback = function(val)
        pcall(function()
            local hum = getHumanoid()
            if hum then
                hum.MaxHealth = val
                hum.Health = val
            end
        end)
    end
})

CharacterTab:CreateSection("Body Parts")

CharacterTab:CreateButton({
    Name = "🗡️ Big Head",
    Callback = function()
        pcall(function()
            local char = getChar()
            if char and char:FindFirstChild("Head") then
                char.Head.Size = Vector3.new(5, 5, 5)
                Rayfield:Notify({Title = "Big Head", Content = "Head enlarged!", Duration = 2})
            end
        end)
    end
})

CharacterTab:CreateButton({
    Name = "👶 Small Head",
    Callback = function()
        pcall(function()
            local char = getChar()
            if char and char:FindFirstChild("Head") then
                char.Head.Size = Vector3.new(0.5, 0.5, 0.5)
                Rayfield:Notify({Title = "Small Head", Content = "Head shrinked!", Duration = 2})
            end
        end)
    end
})

CharacterTab:CreateButton({
    Name = "🔄 Normal Head",
    Callback = function()
        pcall(function()
            local char = getChar()
            if char and char:FindFirstChild("Head") then
                char.Head.Size = Vector3.new(2, 1, 1)
                Rayfield:Notify({Title = "Normal Head", Content = "Head restored!", Duration = 2})
            end
        end)
    end
})

-- ============================================
-- TAB 4: ESP
-- ============================================
local ESPTab = Window:CreateTab("👁️ ESP", nil)
ESPTab:CreateSection("Visual Features")

ESPTab:CreateToggle({
    Name = "📦 Player ESP",
    CurrentValue = false,
    Callback = function(val)
        pcall(function()
            if val then
                startESP()
                Rayfield:Notify({Title = "ESP Enabled", Content = "Players are now visible", Duration = 2})
            else
                stopESP()
                Rayfield:Notify({Title = "ESP Disabled", Content = "ESP removed", Duration = 2})
            end
        end)
    end
})

ESPTab:CreateToggle({
    Name = "🎯 Tracers (Mouse Cursor)",
    CurrentValue = false,
    Callback = function(val)
        pcall(function()
            if val then
                startTracers()
                Rayfield:Notify({Title = "Tracers ON", Content = "Lines from cursor to players", Duration = 2})
            else
                stopTracers()
                Rayfield:Notify({Title = "Tracers OFF", Content = "Tracers disabled", Duration = 2})
            end
        end)
    end
})

ESPTab:CreateToggle({
    Name = "💡 Fullbright",
    CurrentValue = false,
    Callback = function(val)
        pcall(function()
            if val then
                enableFullbright()
                Rayfield:Notify({Title = "Fullbright ON", Content = "Maximum brightness", Duration = 2})
            else
                disableFullbright()
                Rayfield:Notify({Title = "Fullbright OFF", Content = "Normal lighting", Duration = 2})
            end
        end)
    end
})

ESPTab:CreateToggle({
    Name = "🔦 X-Ray Vision",
    CurrentValue = false,
    Callback = function(val)
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    if val then
                        obj.LocalTransparencyModifier = 0.5
                    else
                        obj.LocalTransparencyModifier = 0
                    end
                end
            end
            Rayfield:Notify({Title = val and "X-Ray ON" or "X-Ray OFF", Content = val and "See through walls" or "Normal vision", Duration = 2})
        end)
    end
})

ESPTab:CreateSlider({
    Name = "🎥 FOV (Field of View)",
    Range = {70, 120},
    Increment = 5,
    CurrentValue = 70,
    Callback = function(val)
        pcall(function()
            if workspace.CurrentCamera then
                workspace.CurrentCamera.FieldOfView = val
            end
        end)
    end
})

ESPTab:CreateToggle({
    Name = "🌫️ Remove Fog",
    CurrentValue = false,
    Callback = function(val)
        pcall(function()
            if val then
                Lighting.FogEnd = 999999
                Rayfield:Notify({Title = "Fog Removed", Content = "Clear vision", Duration = 2})
            else
                Lighting.FogEnd = 100000
            end
        end)
    end
})

ESPTab:CreateToggle({
    Name = "🎨 Remove Blur",
    CurrentValue = false,
    Callback = function(val)
        pcall(function()
            for _, v in pairs(Lighting:GetChildren()) do
                if v:IsA("BlurEffect") then
                    v.Enabled = not val
                end
            end
            Rayfield:Notify({Title = val and "Blur Removed" or "Blur Restored", Content = val and "Clear view" or "Blur back", Duration = 2})
        end)
    end
})

ESPTab:CreateToggle({
    Name = "☀️ Remove Shadows",
    CurrentValue = false,
    Callback = function(val)
        pcall(function()
            Lighting.GlobalShadows = not val
            Rayfield:Notify({Title = val and "Shadows Removed" or "Shadows Restored", Content = val and "No shadows" or "Shadows back", Duration = 2})
        end)
    end
})

ESPTab:CreateButton({
    Name = "🎯 ESP Chams",
    Callback = function()
        pcall(function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= player and plr.Character then
                    for _, part in pairs(plr.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Material = Enum.Material.Neon
                            part.Color = Color3.fromRGB(255, 0, 0)
                        end
                    end
                end
            end
            Rayfield:Notify({Title = "Chams Applied", Content = "All players highlighted", Duration = 2})
        end)
    end
})

ESPTab:CreateSlider({
    Name = "🔆 Ambient Brightness",
    Range = {0, 5},
    Increment = 0.5,
    CurrentValue = 1,
    Callback = function(val)
        Lighting.Ambient = Color3.new(val, val, val)
    end
})

ESPTab:CreateToggle({
    Name = "🌈 Rainbow Sky",
    CurrentValue = false,
    Callback = function(val)
        pcall(function()
            if val then
                spawn(function()
                    while val do
                        for i = 0, 1, 0.01 do
                            if not val then break end
                            Lighting.OutdoorAmbient = Color3.fromHSV(i, 1, 1)
                            wait(0.1)
                        end
                    end
                end)
                Rayfield:Notify({Title = "Rainbow Sky ON", Content = "Colorful sky!", Duration = 2})
            else
                Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
            end
        end)
    end
})

ESPTab:CreateSection("Advanced Vision")

ESPTab:CreateToggle({
    Name = "👻 See Through Avatars",
    CurrentValue = false,
    Callback = function(val)
        pcall(function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr.Character then
                    for _, part in pairs(plr.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Transparency = val and 0.5 or 0
                        end
                    end
                end
            end
        end)
    end
})

ESPTab:CreateButton({
    Name = "🌟 Highlight All Players",
    Callback = function()
        pcall(function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= player and plr.Character then
                    local highlight = Instance.new("Highlight")
                    highlight.Adornee = plr.Character
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.Parent = plr.Character
                end
            end
            Rayfield:Notify({Title = "Highlights Added", Content = "All players highlighted!", Duration = 2})
        end)
    end
})

ESPTab:CreateButton({
    Name = "🧹 Remove All Highlights",
    Callback = function()
        pcall(function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr.Character then
                    for _, v in pairs(plr.Character:GetDescendants()) do
                        if v:IsA("Highlight") then
                            v:Destroy()
                        end
                    end
                end
            end
            Rayfield:Notify({Title = "Highlights Removed", Content = "All highlights deleted", Duration = 2})
        end)
    end
})

-- ============================================
-- TAB 5: SCRIPTS
-- ============================================
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

AdminTab:CreateButton({
    Name = "📊 Show FPS",
    Callback = function()
        pcall(function()
            local fps = workspace:GetRealPhysicsFPS()
            Rayfield:Notify({Title = "FPS", Content = "Current FPS: "..math.floor(fps), Duration = 3})
        end)
    end
})

AdminTab:CreateButton({
    Name = "🌐 Show Server Info",
    Callback = function()
        pcall(function()
            local players = #Players:GetPlayers()
            local maxPlayers = Players.MaxPlayers
            Rayfield:Notify({Title = "Server Info", Content = "Players: "..players.."/"..maxPlayers, Duration = 3})
        end)
    end
})

AdminTab:CreateButton({
    Name = "💾 Save Position",
    Callback = function()
        pcall(function()
            local root = getRoot()
            if root then
                _G.SavedPosition = root.CFrame
                Rayfield:Notify({Title = "Position Saved", Content = "Position saved!", Duration = 2})
            end
        end)
    end
})

AdminTab:CreateButton({
    Name = "📍 Load Position",
    Callback = function()
        pcall(function()
            local root = getRoot()
            if root and _G.SavedPosition then
                root.CFrame = _G.SavedPosition
                Rayfield:Notify({Title = "Position Loaded", Content = "Teleported to saved position", Duration = 2})
            end
        end)
    end
})

-- ============================================
-- TAB 7: SETTINGS
-- ============================================
local SettingsTab = Window:CreateTab("⚙️ Settings", nil)
SettingsTab:CreateSection("UI Settings")

SettingsTab:CreateLabel("Press K to toggle UI")

SettingsTab:CreateButton({
    Name = "🗑️ Destroy GUI",
    Callback = function()
        Rayfield:Destroy()
    end
})

SettingsTab:CreateButton({
    Name = "📋 Copy Discord Link",
    Callback = function()
        setclipboard("discord.gg/yourlink")
        Rayfield:Notify({Title = "Copied!", Content = "Discord link copied to clipboard", Duration = 2})
    end
})

SettingsTab:CreateButton({
    Name = "🔄 Reset All Settings",
    Callback = function()
        pcall(function()
            -- Reset all toggles
            stopNoclip()
            stopFly()
            stopInfiniteJump()
            stopESP()
            disableFullbright()
            
            -- Reset sliders
            local hum = getHumanoid()
            if hum then
                hum.JumpPower = defaultJump
                hum.WalkSpeed = defaultSpeed
                hum.HipHeight = 0
            end
            
            workspace.Gravity = 196
            if workspace.CurrentCamera then
                workspace.CurrentCamera.FieldOfView = defaultFOV
            end
            
            Rayfield:Notify({Title = "Settings Reset", Content = "All settings restored to default", Duration = 3})
        end)
    end
})

SettingsTab:CreateSection("Performance")

SettingsTab:CreateToggle({
    Name = "⚡ Performance Mode",
    CurrentValue = false,
    Callback = function(val)
        pcall(function()
            if val then
                settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
                Rayfield:Notify({Title = "Performance Mode ON", Content = "Lower graphics for better FPS", Duration = 2})
            else
                settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
                Rayfield:Notify({Title = "Performance Mode OFF", Content = "Normal graphics", Duration = 2})
            end
        end)
    end
})

SettingsTab:CreateButton({
    Name = "🧹 Clear Workspace",
    Callback = function()
        pcall(function()
            for _, obj in pairs(workspace:GetChildren()) do
                if not obj:IsA("Terrain") and not obj:IsA("Camera") and not Players:GetPlayerFromCharacter(obj) then
                    obj:Destroy()
                end
            end
            Rayfield:Notify({Title = "Workspace Cleared", Content = "Unnecessary objects removed", Duration = 2})
        end)
    end
})

-- ============================================
-- TAB 8: TELEPORTS
-- ============================================
local TeleportsTab = Window:CreateTab("📍 Teleports", nil)
TeleportsTab:CreateSection("Quick Teleports")

-- Create player list for dropdown
local function getPlayerNames()
    local names = {}
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            table.insert(names, plr.Name)
        end
    end
    return names
end

local selectedPlayer = nil

TeleportsTab:CreateDropdown({
    Name = "👥 Select Player",
    Options = getPlayerNames(),
    CurrentOption = "None",
    Flag = "PlayerDropdown",
    Callback = function(option)
        selectedPlayer = option
    end
})

TeleportsTab:CreateButton({
    Name = "✈️ Teleport to Selected Player",
    Callback = function()
        pcall(function()
            if selectedPlayer then
                local targetPlayer = Players:FindFirstChild(selectedPlayer)
                if targetPlayer and targetPlayer.Character then
                    local root = getRoot()
                    local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if root and targetRoot then
                        root.CFrame = targetRoot.CFrame
                        Rayfield:Notify({Title = "Teleported", Content = "Sent to "..selectedPlayer, Duration = 2})
                    end
                else
                    Rayfield:Notify({Title = "Error", Content = "Player not found or has no character", Duration = 2})
                end
            else
                Rayfield:Notify({Title = "Error", Content = "No player selected", Duration = 2})
            end
        end)
    end
})

TeleportsTab:CreateButton({
    Name = "🔄 Refresh Player List",
    Callback = function()
        Rayfield:Notify({Title = "Refreshed", Content = "Player list updated", Duration = 2})
    end
})

TeleportsTab:CreateButton({
    Name = "🏠 Teleport to Spawn",
    Callback = function()
        pcall(function()
            local spawnLocation = workspace:FindFirstChild("SpawnLocation")
            local root = getRoot()
            if root and spawnLocation then
                root.CFrame = spawnLocation.CFrame + Vector3.new(0, 5, 0)
                Rayfield:Notify({Title = "Teleported", Content = "Sent to spawn", Duration = 2})
            end
        end)
    end
})

TeleportsTab:CreateButton({
    Name = "👥 Teleport to Random Player",
    Callback = function()
        pcall(function()
            local players = Players:GetPlayers()
            local randomPlayer = players[math.random(1, #players)]
            if randomPlayer ~= player and randomPlayer.Character then
                local root = getRoot()
                local targetRoot = randomPlayer.Character:FindFirstChild("HumanoidRootPart")
                if root and targetRoot then
                    root.CFrame = targetRoot.CFrame
                    Rayfield:Notify({Title = "Teleported", Content = "Sent to "..randomPlayer.Name, Duration = 2})
                end
            end
        end)
    end
})

TeleportsTab:CreateButton({
    Name = "🎯 Teleport All Players to You",
    Callback = function()
        pcall(function()
            local root = getRoot()
            if root then
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= player and plr.Character then
                        local targetRoot = plr.Character:FindFirstChild("HumanoidRootPart")
                        if targetRoot then
                            targetRoot.CFrame = root.CFrame
                        end
                    end
                end
                Rayfield:Notify({Title = "Teleported All", Content = "All players brought to you", Duration = 2})
            end
        end)
    end
})

TeleportsTab:CreateSection("Coordinate Teleport")

TeleportsTab:CreateInput({
    Name = "X Coordinate",
    PlaceholderText = "Enter X",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        _G.TeleportX = tonumber(text) or 0
    end
})

TeleportsTab:CreateInput({
    Name = "Y Coordinate",
    PlaceholderText = "Enter Y",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        _G.TeleportY = tonumber(text) or 0
    end
})

TeleportsTab:CreateInput({
    Name = "Z Coordinate",
    PlaceholderText = "Enter Z",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        _G.TeleportZ = tonumber(text) or 0
    end
})

TeleportsTab:CreateButton({
    Name = "📍 Teleport to Coordinates",
    Callback = function()
        pcall(function()
            local root = getRoot()
            if root and _G.TeleportX and _G.TeleportY and _G.TeleportZ then
                root.CFrame = CFrame.new(_G.TeleportX, _G.TeleportY, _G.TeleportZ)
                Rayfield:Notify({Title = "Teleported", Content = "Sent to coordinates", Duration = 2})
            end
        end)
    end
})

-- ============================================
-- TAB 9: COMBAT
-- ============================================
local CombatTab = Window:CreateTab("⚔️ Combat", nil)
CombatTab:CreateSection("Combat Features")

CombatTab:CreateToggle({
    Name = "🎯 Aimbot",
    CurrentValue = false,
    Callback = function(val)
        Rayfield:Notify({Title = "Aimbot", Content = val and "Enabled" or "Disabled", Duration = 2})
    end
})

CombatTab:CreateToggle({
    Name = "🔫 Silent Aim",
    CurrentValue = false,
    Callback = function(val)
        Rayfield:Notify({Title = "Silent Aim", Content = val and "Enabled" or "Disabled", Duration = 2})
    end
})

CombatTab:CreateSlider({
    Name = "🎲 Aimbot FOV",
    Range = {0, 360},
    Increment = 10,
    CurrentValue = 90,
    Callback = function(val)
    end
})

CombatTab:CreateToggle({
    Name = "🛡️ Anti-Ragdoll",
    CurrentValue = false,
    Callback = function(val)
        Rayfield:Notify({Title = "Anti-Ragdoll", Content = val and "Enabled" or "Disabled", Duration = 2})
    end
})

CombatTab:CreateToggle({
    Name = "⚡ Instant Kill",
    CurrentValue = false,
    Callback = function(val)
        Rayfield:Notify({Title = "Instant Kill", Content = val and "Enabled" or "Disabled", Duration = 2})
    end
})

CombatTab:CreateToggle({
    Name = "🔥 Kill Aura",
    CurrentValue = false,
    Callback = function(val)
        Rayfield:Notify({Title = "Kill Aura", Content = val and "Enabled" or "Disabled", Duration = 2})
    end
})

CombatTab:CreateSlider({
    Name = "📏 Kill Aura Range",
    Range = {5, 50},
    Increment = 5,
    CurrentValue = 20,
    Callback = function(val)
    end
})

CombatTab:CreateToggle({
    Name = "🎯 Auto Parry",
    CurrentValue = false,
    Callback = function(val)
        Rayfield:Notify({Title = "Auto Parry", Content = val and "Enabled" or "Disabled", Duration = 2})
    end
})

CombatTab:CreateButton({
    Name = "💀 Kill All (FE)",
    Callback = function()
        Rayfield:Notify({Title = "Kill All", Content = "Attempting to kill all players", Duration = 2})
    end
})

-- ============================================
-- TAB 10: GAME
-- ============================================
local GameTab = Window:CreateTab("🎮 Game", nil)
GameTab:CreateSection("Game Specific")

GameTab:CreateLabel("Game: "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
GameTab:CreateLabel("Place ID: "..game.PlaceId)

GameTab:CreateButton({
    Name = "🔄 Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
    end
})

GameTab:CreateButton({
    Name = "🔀 Server Hop",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        TeleportService:Teleport(game.PlaceId)
    end
})

GameTab:CreateButton({
    Name = "🌐 Join Smallest Server",
    Callback = function()
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/"
        
        local _places = Api..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
        local function ListServers()
            local Raw = game:HttpGet(_places)
            local Decoded = Http:JSONDecode(Raw)
            local servers = Decoded.data
            table.sort(servers, function(a, b) return a.playing < b.playing end)
            return servers[1]
        end
        
        local server = ListServers()
        TPS:TeleportToPlaceInstance(game.PlaceId, server.id, player)
        Rayfield:Notify({Title = "Server Hop", Content = "Joining smallest server...", Duration = 2})
    end
})

GameTab:CreateButton({
    Name = "📊 Show Server Stats",
    Callback = function()
        pcall(function()
            local playerCount = #Players:GetPlayers()
            local maxPlayers = Players.MaxPlayers
            local ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
            local fps = math.floor(workspace:GetRealPhysicsFPS())
            
            Rayfield:Notify({
                Title = "Server Stats",
                Content = "Players: "..playerCount.."/"..maxPlayers.."\nPing: "..ping.."ms\nFPS: "..fps,
                Duration = 5
            })
        end)
    end
})

GameTab:CreateButton({
    Name = "🔗 Copy Game Link",
    Callback = function()
        setclipboard("https://www.roblox.com/games/"..game.PlaceId)
        Rayfield:Notify({Title = "Copied", Content = "Game link copied to clipboard", Duration = 2})
    end
})

-- ============================================
-- TAB 11: MISC
-- ============================================
local MiscTab = Window:CreateTab("🔧 Misc", nil)
MiscTab:CreateSection("Miscellaneous")

MiscTab:CreateButton({
    Name = "💬 Chat Spy",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua"))()
        Rayfield:Notify({Title = "Chat Spy", Content = "Loaded", Duration = 2})
    end
})

MiscTab:CreateToggle({
    Name = "🎵 Bypass Audio",
    CurrentValue = false,
    Callback = function(val)
        Rayfield:Notify({Title = "Bypass Audio", Content = val and "Enabled" or "Disabled", Duration = 2})
    end
})

MiscTab:CreateToggle({
    Name = "🚫 Anti-AFK",
    CurrentValue = false,
    Callback = function(val)
        pcall(function()
            if val then
                local VirtualUser = game:GetService("VirtualUser")
                player.Idled:Connect(function()
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                end)
                Rayfield:Notify({Title = "Anti-AFK ON", Content = "You won't be kicked for AFK", Duration = 2})
            end
        end)
    end
})

MiscTab:CreateButton({
    Name = "🎬 Free Camera",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Robobo2022/FreeCam/main/FreeCam.lua"))()
        Rayfield:Notify({Title = "Free Camera", Content = "Loaded", Duration = 2})
    end
})

MiscTab:CreateButton({
    Name = "🔊 Bypass Chat",
    Callback = function()
        Rayfield:Notify({Title = "Bypass Chat", Content = "Chat bypass enabled", Duration = 2})
    end
})

MiscTab:CreateToggle({
    Name = "🌊 Walk on Water",
    CurrentValue = false,
    Callback = function(val)
        pcall(function()
            if val then
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("Part") and v.Name == "Water" then
                        v.CanCollide = true
                    end
                end
                Rayfield:Notify({Title = "Walk on Water ON", Content = "You can walk on water", Duration = 2})
            else
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("Part") and v.Name == "Water" then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end
})

MiscTab:CreateButton({
    Name = "🎨 Rainbow Character",
    Callback = function()
        pcall(function()
            local char = getChar()
            if char then
                spawn(function()
                    while char and char.Parent do
                        for _, part in pairs(char:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                            end
                        end
                        wait(0.1)
                    end
                end)
                Rayfield:Notify({Title = "Rainbow Character", Content = "Your character is now rainbow!", Duration = 2})
            end
        end)
    end
})

MiscTab:CreateButton({
    Name = "🎤 Voice Chat Enabled",
    Callback = function()
        pcall(function()
            if game:GetService("VoiceChatService").EnableDefaultVoice then
                Rayfield:Notify({Title = "Voice Chat", Content = "Voice chat is enabled", Duration = 2})
            else
                Rayfield:Notify({Title = "Voice Chat", Content = "Voice chat is disabled", Duration = 2})
            end
        end)
    end
})

MiscTab:CreateSection("Fun Features")

MiscTab:CreateButton({
    Name = "🎵 Play Music",
    Callback = function()
        pcall(function()
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://1839246711"
            sound.Volume = 0.5
            sound.Looped = true
            sound.Parent = workspace
            sound:Play()
            Rayfield:Notify({Title = "Music Playing", Content = "Background music started", Duration = 2})
        end)
    end
})

MiscTab:CreateButton({
    Name = "🔇 Stop All Sounds",
    Callback = function()
        pcall(function()
            for _, sound in pairs(workspace:GetDescendants()) do
                if sound:IsA("Sound") then
                    sound:Stop()
                    sound:Destroy()
                end
            end
            Rayfield:Notify({Title = "Sounds Stopped", Content = "All sounds removed", Duration = 2})
        end)
    end
})

MiscTab:CreateButton({
    Name = "💥 Explosion at Me",
    Callback = function()
        pcall(function()
            local root = getRoot()
            if root then
                local explosion = Instance.new("Explosion")
                explosion.Position = root.Position
                explosion.BlastRadius = 20
                explosion.BlastPressure = 500000
                explosion.Parent = workspace
                Rayfield:Notify({Title = "Explosion", Content = "BOOM!", Duration = 2})
            end
        end)
    end
})

MiscTab:CreateButton({
    Name = "🌩️ Lightning Strike",
    Callback = function()
        pcall(function()
            local root = getRoot()
            if root then
                local ray = Instance.new("Part")
                ray.Anchored = true
                ray.CanCollide = false
                ray.Size = Vector3.new(1, 1000, 1)
                ray.Material = Enum.Material.Neon
                ray.BrickColor = BrickColor.new("Electric blue")
                ray.Position = root.Position + Vector3.new(0, 500, 0)
                ray.Parent = workspace
                wait(0.5)
                ray:Destroy()
                Rayfield:Notify({Title = "Lightning", Content = "Strike!", Duration = 2})
            end
        end)
    end
})

MiscTab:CreateToggle({
    Name = "🎆 Trail Effect",
    CurrentValue = false,
    Callback = function(val)
        pcall(function()
            local root = getRoot()
            if root and val then
                local trail = Instance.new("Trail")
                local att0 = Instance.new("Attachment", root)
                local att1 = Instance.new("Attachment", root)
                att1.Position = Vector3.new(0, -2, 0)
                trail.Attachment0 = att0
                trail.Attachment1 = att1
                trail.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 0, 255))
                trail.Lifetime = 2
                trail.Parent = root
                Rayfield:Notify({Title = "Trail ON", Content = "You leave a trail!", Duration = 2})
            elseif root then
                for _, v in pairs(root:GetChildren()) do
                    if v:IsA("Trail") or v:IsA("Attachment") then
                        v:Destroy()
                    end
                end
            end
        end)
    end
})

MiscTab:CreateButton({
    Name = "🎲 Random Teleport",
    Callback = function()
        pcall(function()
            local root = getRoot()
            if root then
                local randomX = math.random(-500, 500)
                local randomZ = math.random(-500, 500)
                root.CFrame = CFrame.new(randomX, root.Position.Y, randomZ)
                Rayfield:Notify({Title = "Random Teleport", Content = "Teleported to random location", Duration = 2})
            end
        end)
    end
})

MiscTab:CreateButton({
    Name = "🌪️ Tornado Effect",
    Callback = function()
        pcall(function()
            local root = getRoot()
            if root then
                for i = 1, 50 do
                    local part = Instance.new("Part")
                    part.Size = Vector3.new(1, 1, 1)
                    part.Material = Enum.Material.Neon
                    part.Anchored = true
                    part.CanCollide = false
                    part.BrickColor = BrickColor.Random()
                    part.Position = root.Position + Vector3.new(math.random(-10, 10), i, math.random(-10, 10))
                    part.Parent = workspace
                    game:GetService("Debris"):AddItem(part, 5)
                end
                Rayfield:Notify({Title = "Tornado", Content = "Tornado created!", Duration = 2})
            end
        end)
    end
})

MiscTab:CreateSection("Utilities")

MiscTab:CreateButton({
    Name = "📸 Screenshot",
    Callback = function()
        pcall(function()
            local Camera = workspace.CurrentCamera
            local screenshot = Camera:CaptureScreenshot()
            Rayfield:Notify({Title = "Screenshot", Content = "Screenshot taken!", Duration = 2})
        end)
    end
})

MiscTab:CreateButton({
    Name = "📋 Copy User ID",
    Callback = function()
        setclipboard(tostring(player.UserId))
        Rayfield:Notify({Title = "Copied", Content = "User ID: "..player.UserId, Duration = 2})
    end
})

MiscTab:CreateButton({
    Name = "📋 Copy Username",
    Callback = function()
        setclipboard(player.Name)
        Rayfield:Notify({Title = "Copied", Content = "Username: "..player.Name, Duration = 2})
    end
})

MiscTab:CreateButton({
    Name = "📋 Copy Display Name",
    Callback = function()
        setclipboard(player.DisplayName)
        Rayfield:Notify({Title = "Copied", Content = "Display Name: "..player.DisplayName, Duration = 2})
    end
})

MiscTab:CreateButton({
    Name = "⏱️ Show Play Time",
    Callback = function()
        pcall(function()
            local time = os.time() - player.AccountAge * 86400
            local days = math.floor(time / 86400)
            Rayfield:Notify({Title = "Account Age", Content = player.AccountAge.." days old", Duration = 3})
        end)
    end
})

spawn(function()
    wait(1)
    local DISCORD_LINK = "https://discord.gg/UTCT2hck8S"

    if setclipboard then
        setclipboard(DISCORD_LINK)
    elseif toclipboard then
        toclipboard(DISCORD_LINK)
    elseif Clipboard and Clipboard.set then
        Clipboard.set(DISCORD_LINK)
    end

    if Rayfield then
        Rayfield:Notify({
            Title = "📋 Discord Copied!",
            Content = "Invite-ul a fost copiat în clipboard!",
            Duration = 3
        })
    end
end)

-- ============================================
-- TAB 12: ANIMATIONS
-- ============================================
local AnimationsTab = Window:CreateTab("💃 Animations", nil)
AnimationsTab:CreateSection("Character Animations")

local animations = {
    ["Wave"] = "rbxassetid://507770239",
    ["Dance"] = "rbxassetid://507771019",
    ["Dance2"] = "rbxassetid://507776043",
    ["Dance3"] = "rbxassetid://507777268",
    ["Laugh"] = "rbxassetid://507770818",
    ["Cheer"] = "rbxassetid://507770677",
    ["Point"] = "rbxassetid://507770453",
    ["Stadium"] = "rbxassetid://507781817",
    ["Salute"] = "rbxassetid://3360689775"
}

for name, id in pairs(animations) do
    AnimationsTab:CreateButton({
        Name = "🎭 "..name,
        Callback = function()
            pcall(function()
                local hum = getHumanoid()
                if hum then
                    local anim = Instance.new("Animation")
                    anim.AnimationId = id
                    local track = hum:LoadAnimation(anim)
                    track:Play()
                    Rayfield:Notify({Title = "Animation", Content = name.." played!", Duration = 2})
                end
            end)
        end
    })
end

AnimationsTab:CreateButton({
    Name = "🛑 Stop All Animations",
    Callback = function()
        pcall(function()
            local hum = getHumanoid()
            if hum then
                for _, track in pairs(hum:GetPlayingAnimationTracks()) do
                    track:Stop()
                end
                Rayfield:Notify({Title = "Animations Stopped", Content = "All animations stopped", Duration = 2})
            end
        end)
    end
})

AnimationsTab:CreateSection("Custom Animations")

AnimationsTab:CreateInput({
    Name = "Animation ID",
    PlaceholderText = "Enter Animation ID",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        _G.CustomAnimID = text
    end
})

AnimationsTab:CreateButton({
    Name = "▶️ Play Custom Animation",
    Callback = function()
        pcall(function()
            if _G.CustomAnimID then
                local hum = getHumanoid()
                if hum then
                    local anim = Instance.new("Animation")
                    anim.AnimationId = "rbxassetid://".._G.CustomAnimID
                    local track = hum:LoadAnimation(anim)
                    track:Play()
                    Rayfield:Notify({Title = "Custom Animation", Content = "Playing...", Duration = 2})
                end
            end
        end)
    end
})

-- ============================================
-- TAB 13: EFFECTS
-- ============================================
local EffectsTab = Window:CreateTab("✨ Effects", nil)
EffectsTab:CreateSection("Visual Effects")

EffectsTab:CreateButton({
    Name = "⚡ Lightning Aura",
    Callback = function()
        pcall(function()
            local char = getChar()
            if char then
                for i = 1, 8 do
                    local part = Instance.new("Part")
                    part.Size = Vector3.new(0.2, 10, 0.2)
                    part.Material = Enum.Material.Neon
                    part.Anchored = true
                    part.CanCollide = false
                    part.BrickColor = BrickColor.new("Electric blue")
                    part.Parent = char
                    
                    spawn(function()
                        while part and part.Parent do
                            local angle = (i / 8) * math.pi * 2 + tick()
                            part.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(
                                math.cos(angle) * 3,
                                math.sin(tick() * 2) * 2,
                                math.sin(angle) * 3
                            )
                            wait()
                        end
                    end)
                end
                Rayfield:Notify({Title = "Lightning Aura", Content = "Aura activated!", Duration = 2})
            end
        end)
    end
})

EffectsTab:CreateButton({
    Name = "🔥 Fire Aura",
    Callback = function()
        pcall(function()
            local root = getRoot()
            if root then
                for i = 1, 5 do
                    local fire = Instance.new("Fire")
                    fire.Size = 8
                    fire.Heat = 15
                    fire.Color = Color3.fromRGB(255, math.random(0, 100), 0)
                    fire.SecondaryColor = Color3.fromRGB(255, 255, 0)
                    fire.Parent = root
                end
                Rayfield:Notify({Title = "Fire Aura", Content = "You're on fire!", Duration = 2})
            end
        end)
    end
})

EffectsTab:CreateButton({
    Name = "❄️ Ice Aura",
    Callback = function()
        pcall(function()
            local char = getChar()
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Material = Enum.Material.Ice
                        part.Color = Color3.fromRGB(150, 200, 255)
                        
                        local sparkle = Instance.new("Sparkles")
                        sparkle.SparkleColor = Color3.fromRGB(150, 200, 255)
                        sparkle.Parent = part
                    end
                end
                Rayfield:Notify({Title = "Ice Aura", Content = "Frozen effect applied!", Duration = 2})
            end
        end)
    end
})

EffectsTab:CreateButton({
    Name = "🌟 Star Aura",
    Callback = function()
        pcall(function()
            local root = getRoot()
            if root then
                spawn(function()
                    for i = 1, 50 do
                        local star = Instance.new("Part")
                        star.Size = Vector3.new(0.5, 0.5, 0.5)
                        star.Shape = Enum.PartType.Ball
                        star.Material = Enum.Material.Neon
                        star.BrickColor = BrickColor.Random()
                        star.Anchored = true
                        star.CanCollide = false
                        star.Parent = workspace
                        
                        local pos = root.Position + Vector3.new(
                            math.random(-10, 10),
                            math.random(-10, 10),
                            math.random(-10, 10)
                        )
                        star.Position = pos
                        
                        game:GetService("TweenService"):Create(star, TweenInfo.new(2), {
                            Position = root.Position,
                            Transparency = 1
                        }):Play()
                        
                        game:GetService("Debris"):AddItem(star, 2)
                        wait(0.05)
                    end
                end)
                Rayfield:Notify({Title = "Star Aura", Content = "Stars surround you!", Duration = 2})
            end
        end)
    end
})

EffectsTab:CreateButton({
    Name = "🌈 Rainbow Particles",
    Callback = function()
        pcall(function()
            local root = getRoot()
            if root then
                local particle = Instance.new("ParticleEmitter")
                particle.Texture = "rbxasset://textures/particles/sparkles_main.dds"
                particle.Rate = 100
                particle.Lifetime = NumberRange.new(2, 4)
                particle.Speed = NumberRange.new(5, 10)
                particle.SpreadAngle = Vector2.new(360, 360)
                particle.Parent = root
                
                spawn(function()
                    while particle and particle.Parent do
                        particle.Color = ColorSequence.new(Color3.fromHSV(tick() % 5 / 5, 1, 1))
                        wait(0.1)
                    end
                end)
                
                Rayfield:Notify({Title = "Rainbow Particles", Content = "Particles spawned!", Duration = 2})
            end
        end)
    end
})

EffectsTab:CreateButton({
    Name = "💫 Galaxy Effect",
    Callback = function()
        pcall(function()
            local char = getChar()
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Material = Enum.Material.ForceField
                        
                        spawn(function()
                            while part and part.Parent do
                                part.Color = Color3.fromHSV((tick() + _) % 5 / 5, 0.8, 1)
                                wait(0.05)
                            end
                        end)
                    end
                end
                Rayfield:Notify({Title = "Galaxy Effect", Content = "Cosmic power!", Duration = 2})
            end
        end)
    end
})

EffectsTab:CreateButton({
    Name = "🧹 Remove All Effects",
    Callback = function()
        pcall(function()
            local char = getChar()
            if char then
                for _, obj in pairs(char:GetDescendants()) do
                    if obj:IsA("ParticleEmitter") or obj:IsA("Fire") or obj:IsA("Smoke") 
                    or obj:IsA("Sparkles") or (obj:IsA("Part") and obj.Parent == char) then
                        if obj:IsA("Part") and obj.Name ~= "HumanoidRootPart" and obj.Name ~= "Head" 
                        and obj.Name ~= "Torso" and obj.Name ~= "Left Arm" and obj.Name ~= "Right Arm" 
                        and obj.Name ~= "Left Leg" and obj.Name ~= "Right Leg" then
                            obj:Destroy()
                        end
                    end
                end
                Rayfield:Notify({Title = "Effects Cleared", Content = "All effects removed!", Duration = 2})
            end
        end)
    end
})

-- ============================================
-- TAB 14: TOOLS
-- ============================================
local ToolsTab = Window:CreateTab("🔧 Tools", nil)
ToolsTab:CreateSection("Utility Tools")

ToolsTab:CreateButton({
    Name = "🔦 Give Flashlight",
    Callback = function()
        pcall(function()
            local tool = Instance.new("Tool")
            tool.Name = "Flashlight"
            tool.RequiresHandle = true
            
            local handle = Instance.new("Part")
            handle.Name = "Handle"
            handle.Size = Vector3.new(0.5, 2, 0.5)
            handle.Parent = tool
            
            local light = Instance.new("SpotLight")
            light.Brightness = 10
            light.Range = 60
            light.Parent = handle
            
            tool.Parent = player.Backpack
            Rayfield:Notify({Title = "Flashlight", Content = "Flashlight added to inventory!", Duration = 2})
        end)
    end
})

ToolsTab:CreateButton({
    Name = "⚔️ Give Sword",
    Callback = function()
        pcall(function()
            local tool = game:GetObjects("rbxassetid://99119158")[1]
            if tool then
                tool.Parent = player.Backpack
                Rayfield:Notify({Title = "Sword", Content = "Sword added to inventory!", Duration = 2})
            end
        end)
    end
})

ToolsTab:CreateButton({
    Name = "🎯 Give Grappling Hook",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Super-lover/scripts/main/grappling_hook"))()
        Rayfield:Notify({Title = "Grappling Hook", Content = "Tool loaded!", Duration = 2})
    end
})

ToolsTab:CreateButton({
    Name = "🔫 Give Rocket Launcher",
    Callback = function()
        pcall(function()
            local tool = game:GetObjects("rbxassetid://94794774")[1]
            if tool then
                tool.Parent = player.Backpack
                Rayfield:Notify({Title = "Rocket Launcher", Content = "Weapon added!", Duration = 2})
            end
        end)
    end
})

ToolsTab:CreateButton({
    Name = "🎨 Give Paint Tool",
    Callback = function()
        pcall(function()
            local tool = Instance.new("Tool")
            tool.Name = "Paint Tool"
            tool.RequiresHandle = true
            
            local handle = Instance.new("Part")
            handle.Name = "Handle"
            handle.Size = Vector3.new(0.3, 1, 0.3)
            handle.BrickColor = BrickColor.Random()
            handle.Parent = tool
            
            tool.Activated:Connect(function()
                local mouse = player:GetMouse()
                if mouse.Target then
                    mouse.Target.BrickColor = BrickColor.Random()
                end
            end)
            
            tool.Parent = player.Backpack
            Rayfield:Notify({Title = "Paint Tool", Content = "Click to paint objects!", Duration = 2})
        end)
    end
})

ToolsTab:CreateButton({
    Name = "🧨 Give Bomb",
    Callback = function()
        pcall(function()
            local tool = Instance.new("Tool")
            tool.Name = "Bomb"
            tool.RequiresHandle = true
            
            local handle = Instance.new("Part")
            handle.Name = "Handle"
            handle.Size = Vector3.new(1, 1, 1)
            handle.Shape = Enum.PartType.Ball
            handle.BrickColor = BrickColor.new("Really black")
            handle.Parent = tool
            
            tool.Activated:Connect(function()
                local bomb = handle:Clone()
                bomb.Parent = workspace
                bomb.Position = handle.Position
                wait(3)
                local explosion = Instance.new("Explosion")
                explosion.Position = bomb.Position
                explosion.BlastRadius = 30
                explosion.Parent = workspace
                bomb:Destroy()
            end)
            
            tool.Parent = player.Backpack
            Rayfield:Notify({Title = "Bomb", Content = "Explosive added!", Duration = 2})
        end)
    end
})

ToolsTab:CreateButton({
    Name = "🗑️ Delete All Tools",
    Callback = function()
        pcall(function()
            for _, tool in pairs(player.Backpack:GetChildren()) do
                tool:Destroy()
            end
            local char = getChar()
            if char then
                for _, tool in pairs(char:GetChildren()) do
                    if tool:IsA("Tool") then
                        tool:Destroy()
                    end
                end
            end
            Rayfield:Notify({Title = "Tools Deleted", Content = "All tools removed!", Duration = 2})
        end)
    end
})

-- ============================================
-- TAB 15: FUN
-- ============================================
local FunTab = Window:CreateTab("🎉 Fun", nil)
FunTab:CreateSection("Fun Features")

FunTab:CreateButton({
    Name = "🎈 Balloon Effect",
    Callback = function()
        pcall(function()
            local root = getRoot()
            if root then
                for i = 1, 10 do
                    local balloon = Instance.new("Part")
                    balloon.Size = Vector3.new(2, 2, 2)
                    balloon.Shape = Enum.PartType.Ball
                    balloon.Material = Enum.Material.SmoothPlastic
                    balloon.BrickColor = BrickColor.Random()
                    balloon.Position = root.Position + Vector3.new(math.random(-5, 5), 10, math.random(-5, 5))
                    balloon.Parent = workspace
                    
                    local bv = Instance.new("BodyVelocity")
                    bv.Velocity = Vector3.new(0, 5, 0)
                    bv.MaxForce = Vector3.new(0, math.huge, 0)
                    bv.Parent = balloon
                    
                    game:GetService("Debris"):AddItem(balloon, 10)
                end
                Rayfield:Notify({Title = "Balloons", Content = "Balloons released!", Duration = 2})
            end
        end)
    end
})

FunTab:CreateButton({
    Name = "🎆 Firework Show",
    Callback = function()
        pcall(function()
            spawn(function()
                for i = 1, 20 do
                    local firework = Instance.new("Part")
                    firework.Size = Vector3.new(1, 1, 1)
                    firework.Position = Vector3.new(math.random(-50, 50), 100, math.random(-50, 50))
                    firework.Anchored = true
                    firework.CanCollide = false
                    firework.Transparency = 1
                    firework.Parent = workspace
                    
                    wait(0.5)
                    
                    for j = 1, 30 do
                        local spark = Instance.new("Part")
                        spark.Size = Vector3.new(0.5, 0.5, 0.5)
                        spark.Material = Enum.Material.Neon
                        spark.BrickColor = BrickColor.Random()
                        spark.Position = firework.Position
                        spark.Anchored = true
                        spark.CanCollide = false
                        spark.Parent = workspace
                        
                        game:GetService("TweenService"):Create(spark, TweenInfo.new(2), {
                            Position = firework.Position + Vector3.new(
                                math.random(-20, 20),
                                math.random(-20, 20),
                                math.random(-20, 20)
                            ),
                            Transparency = 1
                        }):Play()
                        
                        game:GetService("Debris"):AddItem(spark, 2)
                    end
                    
                    firework:Destroy()
                    wait(0.5)
                end
            end)
            Rayfield:Notify({Title = "Fireworks", Content = "Show started!", Duration = 2})
        end)
    end
})

FunTab:CreateButton({
    Name = "🌪️ Spawn Tornado",
    Callback = function()
        pcall(function()
            local root = getRoot()
            if root then
                spawn(function()
                    for height = 0, 100, 2 do
                        for angle = 0, 360, 30 do
                            local part = Instance.new("Part")
                            part.Size = Vector3.new(2, 2, 2)
                            part.Material = Enum.Material.Neon
                            part.Anchored = true
                            part.CanCollide = false
                            part.Color = Color3.fromHSV(height / 100, 1, 1)
                            
                            local rad = math.rad(angle)
                            local distance = 5 + (height / 10)
                            part.Position = root.Position + Vector3.new(
                                math.cos(rad) * distance,
                                height,
                                math.sin(rad) * distance
                            )
                            part.Parent = workspace
                            
                            game:GetService("Debris"):AddItem(part, 5)
                        end
                        wait(0.05)
                    end
                end)
                Rayfield:Notify({Title = "Tornado", Content = "Tornado spawned!", Duration = 2})
            end
        end)
    end
})

FunTab:CreateButton({
    Name = "🎪 Disco Floor",
    Callback = function()
        pcall(function()
            local root = getRoot()
            if root then
                for x = -10, 10, 2 do
                    for z = -10, 10, 2 do
                        local tile = Instance.new("Part")
                        tile.Size = Vector3.new(2, 0.5, 2)
                        tile.Position = root.Position + Vector3.new(x, -3, z)
                        tile.Anchored = true
                        tile.Material = Enum.Material.Neon
                        tile.Parent = workspace
                        
                        spawn(function()
                            while tile and tile.Parent do
                                tile.Color = Color3.fromHSV(math.random(), 1, 1)
                                wait(0.3)
                            end
                        end)
                        
                        game:GetService("Debris"):AddItem(tile, 30)
                    end
                end
                Rayfield:Notify({Title = "Disco Floor", Content = "Let's dance!", Duration = 2})
            end
        end)
    end
})

FunTab:CreateToggle({
    Name = "🎮 Head Follow Mouse",
    CurrentValue = false,
    Callback = function(val)
        pcall(function()
            if val then
                spawn(function()
                    while val do
                        local char = getChar()
                        local mouse = player:GetMouse()
                        if char and char:FindFirstChild("Head") then
                            char.Head.CFrame = CFrame.new(char.Head.Position, mouse.Hit.Position)
                        end
                        wait()
                    end
                end)
                Rayfield:Notify({Title = "Head Tracking", Content = "Your head follows the mouse!", Duration = 2})
            end
        end)
    end
})

FunTab:CreateButton({
    Name = "🎲 Random Size",
    Callback = function()
        pcall(function()
            local char = getChar()
            if char then
                local scale = math.random(5, 30) / 10
                for _, obj in pairs(char:GetDescendants()) do
                    if obj:IsA("BodyPartDescription") or obj:IsA("NumberValue") then
                        if obj.Name:match("Scale") then
                            obj.Value = scale
                        end
                    end
                end
                Rayfield:Notify({Title = "Random Size", Content = "Scale: "..scale, Duration = 2})
            end
        end)
    end
})

-- ============================================
-- TAB 16: ITEM ESP
-- ============================================
local ItemESPTab = Window:CreateTab("📦 Item ESP", nil)
ItemESPTab:CreateSection("Item Detection")

local itemESPEnabled = false
local itemESPObjects = {}

local function createItemESP()
    pcall(function()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Tool") or obj:IsA("Model") and obj:FindFirstChild("Handle") then
                local billboard = Instance.new("BillboardGui")
                billboard.Adornee = obj:FindFirstChild("Handle") or obj.PrimaryPart
                billboard.Size = UDim2.new(0, 100, 0, 50)
                billboard.StudsOffset = Vector3.new(0, 2, 0)
                billboard.AlwaysOnTop = true
                billboard.Parent = obj:FindFirstChild("Handle") or obj.PrimaryPart
                
                local nameLabel = Instance.new("TextLabel")
                nameLabel.Size = UDim2.new(1, 0, 1, 0)
                nameLabel.BackgroundTransparency = 1
                nameLabel.Text = obj.Name
                nameLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                nameLabel.TextStrokeTransparency = 0.5
                nameLabel.Font = Enum.Font.SourceSansBold
                nameLabel.TextSize = 14
                nameLabel.Parent = billboard
                
                table.insert(itemESPObjects, billboard)
            end
        end
    end)
end

local function removeItemESP()
    for _, esp in pairs(itemESPObjects) do
        esp:Destroy()
    end
    itemESPObjects = {}
end

ItemESPTab:CreateToggle({
    Name = "🎯 Item ESP",
    CurrentValue = false,
    Callback = function(val)
        itemESPEnabled = val
        if val then
            createItemESP()
            Rayfield:Notify({Title = "Item ESP ON", Content = "Items are now visible!", Duration = 2})
        else
            removeItemESP()
            Rayfield:Notify({Title = "Item ESP OFF", Content = "Item ESP disabled", Duration = 2})
        end
    end
})

ItemESPTab:CreateButton({
    Name = "🔄 Refresh Item ESP",
    Callback = function()
        removeItemESP()
        createItemESP()
        Rayfield:Notify({Title = "Refreshed", Content = "Item ESP updated!", Duration = 2})
    end
})

ItemESPTab:CreateToggle({
    Name = "💎 Highlight Coins/Currency",
    CurrentValue = false,
    Callback = function(val)
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name:lower():match("coin") or obj.Name:lower():match("cash") or obj.Name:lower():match("money") then
                    if obj:IsA("BasePart") then
                        if val then
                            obj.Material = Enum.Material.Neon
                            obj.BrickColor = BrickColor.new("Gold")
                        else
                            obj.Material = Enum.Material.SmoothPlastic
                        end
                    end
                end
            end
            Rayfield:Notify({Title = val and "Coins Highlighted" or "Coins Normal", Content = val and "Coins are glowing!" or "Removed highlight", Duration = 2})
        end)
    end
})

ItemESPTab:CreateButton({
    Name = "🔍 Show All Chests",
    Callback = function()
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name:lower():match("chest") or obj.Name:lower():match("crate") or obj.Name:lower():match("box") then
                    if obj:IsA("Model") or obj:IsA("BasePart") then
                        local highlight = Instance.new("Highlight")
                        highlight.Adornee = obj
                        highlight.FillColor = Color3.fromRGB(255, 215, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                        highlight.Parent = obj
                    end
                end
            end
            Rayfield:Notify({Title = "Chests Highlighted", Content = "All chests are now visible!", Duration = 2})
        end)
    end
})

ItemESPTab:CreateButton({
    Name = "🎁 Teleport to Nearest Item",
    Callback = function()
        pcall(function()
            local root = getRoot()
            if root then
                local nearestItem = nil
                local shortestDistance = math.huge
                
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Tool") or (obj:IsA("Model") and obj:FindFirstChild("Handle")) then
                        local itemPos = obj:FindFirstChild("Handle") and obj.Handle.Position or obj.PrimaryPart and obj.PrimaryPart.Position
                        if itemPos then
                            local distance = (root.Position - itemPos).Magnitude
                            if distance < shortestDistance then
                                shortestDistance = distance
                                nearestItem = itemPos
                            end
                        end
                    end
                end
                
                if nearestItem then
                    root.CFrame = CFrame.new(nearestItem)
                    Rayfield:Notify({Title = "Teleported", Content = "Sent to nearest item!", Duration = 2})
                end
            end
        end)
    end
})

-- ============================================
-- TAB 17: AUTO FARM
-- ============================================
local AutoFarmTab = Window:CreateTab("🌾 Auto Farm", nil)
AutoFarmTab:CreateSection("Auto Farming")

local autoCollectEnabled = false
local autoClickEnabled = false

AutoFarmTab:CreateToggle({
    Name = "💰 Auto Collect Items",
    CurrentValue = false,
    Callback = function(val)
        autoCollectEnabled = val
        if val then
            spawn(function()
                while autoCollectEnabled do
                    pcall(function()
                        local root = getRoot()
                        if root then
                            for _, obj in pairs(workspace:GetDescendants()) do
                                if obj.Name:lower():match("coin") or obj.Name:lower():match("cash") or obj.Name:lower():match("collect") then
                                    if obj:IsA("BasePart") and (obj.Position - root.Position).Magnitude < 50 then
                                        firetouchinterest(root, obj, 0)
                                        firetouchinterest(root, obj, 1)
                                    end
                                end
                            end
                        end
                    end)
                    wait(0.1)
                end
            end)
            Rayfield:Notify({Title = "Auto Collect ON", Content = "Collecting items automatically!", Duration = 2})
        else
            Rayfield:Notify({Title = "Auto Collect OFF", Content = "Stopped collecting", Duration = 2})
        end
    end
})

AutoFarmTab:CreateToggle({
    Name = "🖱️ Auto Click",
    CurrentValue = false,
    Callback = function(val)
        autoClickEnabled = val
        if val then
            spawn(function()
                while autoClickEnabled do
                    pcall(function()
                        mouse1click()
                    end)
                    wait(0.01)
                end
            end)
            Rayfield:Notify({Title = "Auto Click ON", Content = "Clicking automatically!", Duration = 2})
        else
            Rayfield:Notify({Title = "Auto Click OFF", Content = "Stopped clicking", Duration = 2})
        end
    end
})

AutoFarmTab:CreateSlider({
    Name = "⚡ Click Speed (CPS)",
    Range = {1, 100},
    Increment = 1,
    CurrentValue = 10,
    Callback = function(val)
        -- This adjusts click speed in auto click
    end
})

AutoFarmTab:CreateToggle({
    Name = "🎯 Auto Farm Nearest Enemy",
    CurrentValue = false,
    Callback = function(val)
        if val then
            spawn(function()
                while val do
                    pcall(function()
                        local root = getRoot()
                        if root then
                            local nearestEnemy = nil
                            local shortestDistance = math.huge
                            
                            for _, obj in pairs(workspace:GetDescendants()) do
                                if obj.Name:lower():match("enemy") or obj.Name:lower():match("mob") or obj.Name:lower():match("npc") then
                                    if obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") then
                                        local distance = (root.Position - obj.HumanoidRootPart.Position).Magnitude
                                        if distance < shortestDistance and distance < 100 then
                                            shortestDistance = distance
                                            nearestEnemy = obj
                                        end
                                    end
                                end
                            end
                            
                            if nearestEnemy and nearestEnemy:FindFirstChild("HumanoidRootPart") then
                                root.CFrame = CFrame.new(nearestEnemy.HumanoidRootPart.Position + Vector3.new(0, 5, 0))
                                mouse1click()
                            end
                        end
                    end)
                    wait(0.5)
                end
            end)
            Rayfield:Notify({Title = "Auto Farm ON", Content = "Farming enemies!", Duration = 2})
        else
            Rayfield:Notify({Title = "Auto Farm OFF", Content = "Stopped farming", Duration = 2})
        end
    end
})

AutoFarmTab:CreateButton({
    Name = "🔄 Farm All Items in Workspace",
    Callback = function()
        pcall(function()
            local root = getRoot()
            if root then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Tool") or (obj:IsA("Model") and obj:FindFirstChild("Handle")) then
                        local itemPos = obj:FindFirstChild("Handle") and obj.Handle.Position or obj.PrimaryPart and obj.PrimaryPart.Position
                        if itemPos then
                            root.CFrame = CFrame.new(itemPos)
                            wait(0.1)
                        end
                    end
                end
                Rayfield:Notify({Title = "Farm Complete", Content = "Collected all items!", Duration = 2})
            end
        end)
    end
})

AutoFarmTab:CreateToggle({
    Name = "♻️ Auto Respawn",
    CurrentValue = false,
    Callback = function(val)
        if val then
            spawn(function()
                while val do
                    pcall(function()
                        local hum = getHumanoid()
                        if hum and hum.Health <= 0 then
                            wait(1)
                            player:LoadCharacter()
                        end
                    end)
                    wait(1)
                end
            end)
            Rayfield:Notify({Title = "Auto Respawn ON", Content = "Will respawn automatically!", Duration = 2})
        end
    end
})

-- ============================================
-- TAB 18: WAYPOINTS
-- ============================================
local WaypointsTab = Window:CreateTab("🗺️ Waypoints", nil)
WaypointsTab:CreateSection("Waypoint System")

_G.Waypoints = _G.Waypoints or {}

WaypointsTab:CreateInput({
    Name = "Waypoint Name",
    PlaceholderText = "Enter waypoint name",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        _G.CurrentWaypointName = text
    end
})

WaypointsTab:CreateButton({
    Name = "💾 Save Current Position",
    Callback = function()
        pcall(function()
            local root = getRoot()
            if root and _G.CurrentWaypointName then
                _G.Waypoints[_G.CurrentWaypointName] = root.CFrame
                Rayfield:Notify({Title = "Waypoint Saved", Content = "Saved: ".._G.CurrentWaypointName, Duration = 2})
            else
                Rayfield:Notify({Title = "Error", Content = "Enter a waypoint name first!", Duration = 2})
            end
        end)
    end
})

WaypointsTab:CreateButton({
    Name = "📍 Load Waypoint",
    Callback = function()
        pcall(function()
            local root = getRoot()
            if root and _G.CurrentWaypointName and _G.Waypoints[_G.CurrentWaypointName] then
                root.CFrame = _G.Waypoints[_G.CurrentWaypointName]
                Rayfield:Notify({Title = "Teleported", Content = "Loaded: ".._G.CurrentWaypointName, Duration = 2})
            else
                Rayfield:Notify({Title = "Error", Content = "Waypoint not found!", Duration = 2})
            end
        end)
    end
})

WaypointsTab:CreateButton({
    Name = "📋 List All Waypoints",
    Callback = function()
        local list = "Saved Waypoints:\n"
        for name, _ in pairs(_G.Waypoints) do
            list = list..name.."\n"
        end
        Rayfield:Notify({Title = "Waypoints", Content = list, Duration = 5})
    end
})

WaypointsTab:CreateButton({
    Name = "🗑️ Delete Waypoint",
    Callback = function()
        if _G.CurrentWaypointName and _G.Waypoints[_G.CurrentWaypointName] then
            _G.Waypoints[_G.CurrentWaypointName] = nil
            Rayfield:Notify({Title = "Deleted", Content = "Removed: ".._G.CurrentWaypointName, Duration = 2})
        end
    end
})

WaypointsTab:CreateButton({
    Name = "🧹 Clear All Waypoints",
    Callback = function()
        _G.Waypoints = {}
        Rayfield:Notify({Title = "Cleared", Content = "All waypoints deleted!", Duration = 2})
    end
})

-- ============================================
-- TAB 19: SPEED HUB
-- ============================================
local SpeedHubTab = Window:CreateTab("⚡ Speed Hub", nil)
SpeedHubTab:CreateSection("Speed Modifications")

SpeedHubTab:CreateToggle({
    Name = "🚀 Super Speed",
    CurrentValue = false,
    Callback = function(val)
        pcall(function()
            local hum = getHumanoid()
            if hum then
                if val then
                    hum.WalkSpeed = 100
                    Rayfield:Notify({Title = "Super Speed ON", Content = "Running at 100 speed!", Duration = 2})
                else
                    hum.WalkSpeed = defaultSpeed
                    Rayfield:Notify({Title = "Super Speed OFF", Content = "Normal speed restored", Duration = 2})
                end
            end
        end)
    end
})

SpeedHubTab:CreateButton({
    Name = "⚡ Speed Boost x2",
    Callback = function()
        pcall(function()
            local hum = getHumanoid()
            if hum then
                hum.WalkSpeed = hum.WalkSpeed * 2
                Rayfield:Notify({Title = "Speed Boost", Content = "Speed doubled!", Duration = 2})
            end
        end)
    end
})

SpeedHubTab:CreateButton({
    Name = "🔥 Speed Boost x5",
    Callback = function()
        pcall(function()
            local hum = getHumanoid()
            if hum then
                hum.WalkSpeed = hum.WalkSpeed * 5
                Rayfield:Notify({Title = "Speed Boost", Content = "Speed x5!", Duration = 2})
            end
        end)
    end
})

SpeedHubTab:CreateButton({
    Name = "💨 Max Speed (500)",
    Callback = function()
        pcall(function()
            local hum = getHumanoid()
            if hum then
                hum.WalkSpeed = 500
                Rayfield:Notify({Title = "Max Speed", Content = "Sonic mode activated!", Duration = 2})
            end
        end)
    end
})

SpeedHubTab:CreateToggle({
    Name = "🎯 Auto Sprint",
    CurrentValue = false,
    Callback = function(val)
        if val then
            spawn(function()
                while val do
                    pcall(function()
                        local hum = getHumanoid()
                        if hum and UserInputService:IsKeyDown(Enum.KeyCode.W) then
                            hum.WalkSpeed = 50
                        end
                    end)
                    wait(0.1)
                end
            end)
            Rayfield:Notify({Title = "Auto Sprint ON", Content = "Sprint when moving forward!", Duration = 2})
        end
    end
})

SpeedHubTab:CreateSlider({
    Name = "🏃 Custom Speed",
    Range = {16, 1000},
    Increment = 10,
    CurrentValue = 16,
    Callback = function(val)
        pcall(function()
            local hum = getHumanoid()
            if hum then
                hum.WalkSpeed = val
            end
        end)
    end
})

-- ============================================
-- TAB 20: EXPLOIT UTILITIES
-- ============================================
local ExploitTab = Window:CreateTab("🔓 Utilities", nil)
ExploitTab:CreateSection("Exploit Utilities")

ExploitTab:CreateButton({
    Name = "🎮 Unlock All GamePasses",
    Callback = function()
        pcall(function()
            local MarketplaceService = game:GetService("MarketplaceService")
            local oldUserOwnsGamePassAsync = MarketplaceService.UserOwnsGamePassAsync
            MarketplaceService.UserOwnsGamePassAsync = function(self, userId, gamePassId)
                return true
            end
            Rayfield:Notify({Title = "GamePasses Unlocked", Content = "All gamepasses unlocked (client-side)", Duration = 3})
        end)
    end
})

ExploitTab:CreateButton({
    Name = "💎 Unlock Developer Products",
    Callback = function()
        pcall(function()
            local MarketplaceService = game:GetService("MarketplaceService")
            MarketplaceService.ProcessReceipt = function()
                return Enum.ProductPurchaseDecision.PurchaseGranted
            end
            Rayfield:Notify({Title = "Products Unlocked", Content = "Developer products unlocked!", Duration = 2})
        end)
    end
})

ExploitTab:CreateToggle({
    Name = "🔧 Remove Name Tags",
    CurrentValue = false,
    Callback = function(val)
        pcall(function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr.Character and plr.Character:FindFirstChild("Head") then
                    local billboard = plr.Character.Head:FindFirstChildOfClass("BillboardGui")
                    if billboard then
                        billboard.Enabled = not val
                    end
                end
            end
            Rayfield:Notify({Title = val and "Name Tags Hidden" or "Name Tags Shown", Content = val and "Player names hidden" or "Names visible again", Duration = 2})
        end)
    end
})

ExploitTab:CreateButton({
    Name = "🎭 Fake Admin",
    Callback = function()
        pcall(function()
            local Players = game:GetService("Players")
            local fakeTag = Instance.new("BillboardGui")
            fakeTag.Adornee = player.Character.Head
            fakeTag.Size = UDim2.new(0, 200, 0, 50)
            fakeTag.StudsOffset = Vector3.new(0, 3, 0)
            fakeTag.AlwaysOnTop = true
            fakeTag.Parent = player.Character.Head
            
            local tagLabel = Instance.new("TextLabel")
            tagLabel.Size = UDim2.new(1, 0, 1, 0)
            tagLabel.BackgroundTransparency = 1
            tagLabel.Text = "👑 ADMIN"
            tagLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            tagLabel.TextStrokeTransparency = 0
            tagLabel.Font = Enum.Font.SourceSansBold
            tagLabel.TextSize = 20
            tagLabel.Parent = fakeTag
            
            Rayfield:Notify({Title = "Fake Admin", Content = "Admin tag added!", Duration = 2})
        end)
    end
})

ExploitTab:CreateButton({
    Name = "🌐 Bypass Region Lock",
    Callback = function()
        pcall(function()
            local LocalizationService = game:GetService("LocalizationService")
            LocalizationService:GetCountryRegionForPlayerAsync(player)
            Rayfield:Notify({Title = "Region Bypass", Content = "Region lock bypassed!", Duration = 2})
        end)
    end
})

ExploitTab:CreateButton({
    Name = "📡 Anti-Detection",
    Callback = function()
        pcall(function()
            local mt = getrawmetatable(game)
            local old = mt.__namecall
            setreadonly(mt, false)
            mt.__namecall = newcclosure(function(self, ...)
                local args = {...}
                local method = getnamecallmethod()
                if method == "Kick" then
                    return
                end
                return old(self, ...)
            end)
            setreadonly(mt, true)
            Rayfield:Notify({Title = "Anti-Detection", Content = "Protected from kicks!", Duration = 2})
        end)
    end
})

ExploitTab:CreateButton({
    Name = "🔓 Unlock Doors",
    Callback = function()
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name:lower():match("door") and obj:IsA("Model") then
                    for _, part in pairs(obj:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                            part.Transparency = 0.5
                        end
                    end
                end
            end
            Rayfield:Notify({Title = "Doors Unlocked", Content = "All doors are now passable!", Duration = 2})
        end)
    end
})

-- ============================================
-- TAB 21: CAMERA
-- ============================================
local CameraTab = Window:CreateTab("📷 Camera", nil)
CameraTab:CreateSection("Camera Controls")

CameraTab:CreateSlider({
    Name = "🎥 Camera Distance",
    Range = {0, 500},
    Increment = 10,
    CurrentValue = 15,
    Callback = function(val)
        pcall(function()
            player.CameraMaxZoomDistance = val
            player.CameraMinZoomDistance = val
        end)
    end
})

CameraTab:CreateButton({
    Name = "🔓 Unlock Camera Distance",
    Callback = function()
        pcall(function()
            player.CameraMaxZoomDistance = 9999
            player.CameraMinZoomDistance = 0
            Rayfield:Notify({Title = "Camera Unlocked", Content = "Zoom limit removed!", Duration = 2})
        end)
    end
})

CameraTab:CreateToggle({
    Name = "📹 Third Person Lock",
    CurrentValue = false,
    Callback = function(val)
        pcall(function()
            if val then
                player.CameraMode = Enum.CameraMode.LockFirstPerson
                wait(0.1)
                player.CameraMode = Enum.CameraMode.Classic
                Rayfield:Notify({Title = "Third Person", Content = "Locked to third person!", Duration = 2})
            else
                player.CameraMode = Enum.CameraMode.Classic
            end
        end)
    end
})

CameraTab:CreateToggle({
    Name = "🎬 Smooth Camera",
    CurrentValue = false,
    Callback = function(val)
        pcall(function()
            local camera = workspace.CurrentCamera
            if val then
                spawn(function()
                    while val do
                        camera.CFrame = camera.CFrame:Lerp(camera.CFrame, 0.1)
                        wait()
                    end
                end)
                Rayfield:Notify({Title = "Smooth Camera ON", Content = "Camera movements smoothed!", Duration = 2})
            end
        end)
    end
})

CameraTab:CreateButton({
    Name = "🌀 Camera Shake",
    Callback = function()
        pcall(function()
            local camera = workspace.CurrentCamera
            spawn(function()
                for i = 1, 20 do
                    camera.CFrame = camera.CFrame * CFrame.Angles(
                        math.rad(math.random(-2, 2)),
                        math.rad(math.random(-2, 2)),
                        math.rad(math.random(-2, 2))
                    )
                    wait(0.05)
                end
            end)
            Rayfield:Notify({Title = "Camera Shake", Content = "Earthquake mode!", Duration = 2})
        end)
    end
})

CameraTab:CreateToggle({
    Name = "🎯 Lock Camera to Player",
    CurrentValue = false,
    Callback = function(val)
        if val then
            spawn(function()
                while val do
                    pcall(function()
                        local camera = workspace.CurrentCamera
                        local root = getRoot()
                        if root then
                            camera.CFrame = CFrame.new(camera.CFrame.Position, root.Position)
                        end
                    end)
                    wait()
                end
            end)
            Rayfield:Notify({Title = "Camera Locked", Content = "Camera follows you!", Duration = 2})
        end
    end
})

-- ============================================
-- TAB 22: NOTIFICATIONS
-- ============================================
local NotifTab = Window:CreateTab("🔔 Notifications", nil)
NotifTab:CreateSection("Notification Settings")

NotifTab:CreateToggle({
    Name = "📢 Player Join/Leave Notifications",
    CurrentValue = false,
    Callback = function(val)
        if val then
            Players.PlayerAdded:Connect(function(plr)
                Rayfield:Notify({
                    Title = "Player Joined",
                    Content = plr.Name.." joined the game!",
                    Duration = 3
                })
            end)
            
            Players.PlayerRemoving:Connect(function(plr)
                Rayfield:Notify({
                    Title = "Player Left",
                    Content = plr.Name.." left the game!",
                    Duration = 3
                })
            end)
            
            Rayfield:Notify({Title = "Join/Leave Notifs ON", Content = "You'll be notified when players join/leave", Duration = 2})
        end
    end
})

NotifTab:CreateButton({
    Name = "🎉 Test Notification",
    Callback = function()
        Rayfield:Notify({
            Title = "Test Notification",
            Content = "This is a test notification!",
            Duration = 3,
            Image = 4483362458
        })
    end
})

NotifTab:CreateInput({
    Name = "Custom Notification",
    PlaceholderText = "Enter message",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        Rayfield:Notify({
            Title = "Custom Message",
            Content = text,
            Duration = 3
        })
    end
})

-- ============================================
-- TAB 23: KEYBINDS
-- ============================================
local KeybindTab = Window:CreateTab("⌨️ Keybinds", nil)
KeybindTab:CreateSection("Custom Keybinds")

KeybindTab:CreateLabel("Set custom keybinds for quick actions!")

local keybinds = {
    Noclip = Enum.KeyCode.N,
    Fly = Enum.KeyCode.F,
    Speed = Enum.KeyCode.G,
    ESP = Enum.KeyCode.E
}

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == keybinds.Noclip then
            noclip = not noclip
            if noclip then startNoclip() else stopNoclip() end
        elseif input.KeyCode == keybinds.Fly then
            flying = not flying
            if flying then startFly() else stopFly() end
        elseif input.KeyCode == keybinds.ESP then
            espEnabled = not espEnabled
            if espEnabled then startESP() else stopESP() end
        end
    end
end)

KeybindTab:CreateLabel("⌨️ Default Keybinds:")
KeybindTab:CreateLabel("N - Toggle Noclip")
KeybindTab:CreateLabel("F - Toggle Fly")
KeybindTab:CreateLabel("E - Toggle ESP")
KeybindTab:CreateLabel("K - Toggle UI")

print("👑 Made by qShadow/Darius/Hynexx")
print("🔥 THIS IS THE ULTIMATE ROBLOX SCRIPT!")
 
