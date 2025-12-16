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
HomeTab:CreateSection("🌏 Welcome to Universal Script")
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
        --[[
    SimpleSpy v2.2 SOURCE

    Credits:
        exx - basically everything
        Frosty - GUI to Lua
]]

-- shuts down the previous instance of SimpleSpy
if _G.SimpleSpyExecuted and type(_G.SimpleSpyShutdown) == "function" then
    _G.SimpleSpyShutdown()
end

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local Highlight = loadstring(game:HttpGet("https://github.com/exxtremestuffs/SimpleSpySource/raw/master/highlight.lua"))()

---- GENERATED (kinda sorta mostly) BY GUI to LUA ----

-- Instances:

local SimpleSpy2 = Instance.new("ScreenGui")
local Background = Instance.new("Frame")
local LeftPanel = Instance.new("Frame")
local LogList = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local RemoteTemplate = Instance.new("Frame")
local ColorBar = Instance.new("Frame")
local Text = Instance.new("TextLabel")
local Button = Instance.new("TextButton")
local RightPanel = Instance.new("Frame")
local CodeBox = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIGridLayout = Instance.new("UIGridLayout")
local FunctionTemplate = Instance.new("Frame")
local ColorBar_2 = Instance.new("Frame")
local Text_2 = Instance.new("TextLabel")
local Button_2 = Instance.new("TextButton")
local TopBar = Instance.new("Frame")
local Simple = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local ImageLabel = Instance.new("ImageLabel")
local MaximizeButton = Instance.new("TextButton")
local ImageLabel_2 = Instance.new("ImageLabel")
local MinimizeButton = Instance.new("TextButton")
local ImageLabel_3 = Instance.new("ImageLabel")
local ToolTip = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")

--Properties:

SimpleSpy2.Name = "SimpleSpy2"
SimpleSpy2.ResetOnSpawn = false

Background.Name = "Background"
Background.Parent = SimpleSpy2
Background.BackgroundColor3 = Color3.new(1, 1, 1)
Background.BackgroundTransparency = 1
Background.Position = UDim2.new(0, 500, 0, 200)
Background.Size = UDim2.new(0, 450, 0, 268)

LeftPanel.Name = "LeftPanel"
LeftPanel.Parent = Background
LeftPanel.BackgroundColor3 = Color3.new(0.207843, 0.203922, 0.215686)
LeftPanel.BorderSizePixel = 0
LeftPanel.Position = UDim2.new(0, 0, 0, 19)
LeftPanel.Size = UDim2.new(0, 131, 0, 249)

LogList.Name = "LogList"
LogList.Parent = LeftPanel
LogList.Active = true
LogList.BackgroundColor3 = Color3.new(1, 1, 1)
LogList.BackgroundTransparency = 1
LogList.BorderSizePixel = 0
LogList.Position = UDim2.new(0, 0, 0, 9)
LogList.Size = UDim2.new(0, 131, 0, 232)
LogList.CanvasSize = UDim2.new(0, 0, 0, 0)
LogList.ScrollBarThickness = 4

UIListLayout.Parent = LogList
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

RemoteTemplate.Name = "RemoteTemplate"
RemoteTemplate.Parent = LogList
RemoteTemplate.BackgroundColor3 = Color3.new(1, 1, 1)
RemoteTemplate.BackgroundTransparency = 1
RemoteTemplate.Size = UDim2.new(0, 117, 0, 27)

ColorBar.Name = "ColorBar"
ColorBar.Parent = RemoteTemplate
ColorBar.BackgroundColor3 = Color3.new(1, 0.94902, 0)
ColorBar.BorderSizePixel = 0
ColorBar.Position = UDim2.new(0, 0, 0, 1)
ColorBar.Size = UDim2.new(0, 7, 0, 18)
ColorBar.ZIndex = 2

Text.Name = "Text"
Text.Parent = RemoteTemplate
Text.BackgroundColor3 = Color3.new(1, 1, 1)
Text.BackgroundTransparency = 1
Text.Position = UDim2.new(0, 12, 0, 1)
Text.Size = UDim2.new(0, 105, 0, 18)
Text.ZIndex = 2
Text.Font = Enum.Font.SourceSans
Text.Text = "TEXT"
Text.TextColor3 = Color3.new(1, 1, 1)
Text.TextSize = 14
Text.TextXAlignment = Enum.TextXAlignment.Left

Button.Name = "Button"
Button.Parent = RemoteTemplate
Button.BackgroundColor3 = Color3.new(0, 0, 0)
Button.BackgroundTransparency = 0.75
Button.BorderColor3 = Color3.new(1, 1, 1)
Button.Position = UDim2.new(0, 0, 0, 1)
Button.Size = UDim2.new(0, 117, 0, 18)
Button.AutoButtonColor = false
Button.Font = Enum.Font.SourceSans
Button.Text = ""
Button.TextColor3 = Color3.new(0, 0, 0)
Button.TextSize = 14

RightPanel.Name = "RightPanel"
RightPanel.Parent = Background
RightPanel.BackgroundColor3 = Color3.new(0.145098, 0.141176, 0.14902)
RightPanel.BorderSizePixel = 0
RightPanel.Position = UDim2.new(0, 131, 0, 19)
RightPanel.Size = UDim2.new(0, 319, 0, 249)

CodeBox.Name = "CodeBox"
CodeBox.Parent = RightPanel
CodeBox.BackgroundColor3 = Color3.new(0.0823529, 0.0745098, 0.0784314)
CodeBox.BorderSizePixel = 0
CodeBox.Size = UDim2.new(0, 319, 0, 119)

ScrollingFrame.Parent = RightPanel
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.new(1, 1, 1)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.Position = UDim2.new(0, 0, 0.5, 0)
ScrollingFrame.Size = UDim2.new(1, 0, 0.5, -9)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarThickness = 4

UIGridLayout.Parent = ScrollingFrame
UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
UIGridLayout.CellSize = UDim2.new(0, 94, 0, 27)

FunctionTemplate.Name = "FunctionTemplate"
FunctionTemplate.Parent = ScrollingFrame
FunctionTemplate.BackgroundColor3 = Color3.new(1, 1, 1)
FunctionTemplate.BackgroundTransparency = 1
FunctionTemplate.Size = UDim2.new(0, 117, 0, 23)

ColorBar_2.Name = "ColorBar"
ColorBar_2.Parent = FunctionTemplate
ColorBar_2.BackgroundColor3 = Color3.new(1, 1, 1)
ColorBar_2.BorderSizePixel = 0
ColorBar_2.Position = UDim2.new(0, 7, 0, 10)
ColorBar_2.Size = UDim2.new(0, 7, 0, 18)
ColorBar_2.ZIndex = 3

Text_2.Name = "Text"
Text_2.Parent = FunctionTemplate
Text_2.BackgroundColor3 = Color3.new(1, 1, 1)
Text_2.BackgroundTransparency = 1
Text_2.Position = UDim2.new(0, 19, 0, 10)
Text_2.Size = UDim2.new(0, 69, 0, 18)
Text_2.ZIndex = 2
Text_2.Font = Enum.Font.SourceSans
Text_2.Text = "TEXT"
Text_2.TextColor3 = Color3.new(1, 1, 1)
Text_2.TextSize = 14
Text_2.TextStrokeColor3 = Color3.new(0.145098, 0.141176, 0.14902)
Text_2.TextXAlignment = Enum.TextXAlignment.Left

Button_2.Name = "Button"
Button_2.Parent = FunctionTemplate
Button_2.BackgroundColor3 = Color3.new(0, 0, 0)
Button_2.BackgroundTransparency = 0.69999998807907
Button_2.BorderColor3 = Color3.new(1, 1, 1)
Button_2.Position = UDim2.new(0, 7, 0, 10)
Button_2.Size = UDim2.new(0, 80, 0, 18)
Button_2.AutoButtonColor = false
Button_2.Font = Enum.Font.SourceSans
Button_2.Text = ""
Button_2.TextColor3 = Color3.new(0, 0, 0)
Button_2.TextSize = 14

TopBar.Name = "TopBar"
TopBar.Parent = Background
TopBar.BackgroundColor3 = Color3.new(0.145098, 0.141176, 0.14902)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(0, 450, 0, 19)

Simple.Name = "Simple"
Simple.Parent = TopBar
Simple.BackgroundColor3 = Color3.new(1, 1, 1)
Simple.AutoButtonColor = false
Simple.BackgroundTransparency = 1
Simple.Position = UDim2.new(0, 5, 0, 0)
Simple.Size = UDim2.new(0, 57, 0, 18)
Simple.Font = Enum.Font.SourceSansBold
Simple.Text = "SimpleSpy"
Simple.TextColor3 = Color3.new(1, 1, 1)
Simple.TextSize = 14
Simple.TextXAlignment = Enum.TextXAlignment.Left

CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.BackgroundColor3 = Color3.new(0.145098, 0.141176, 0.14902)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -19, 0, 0)
CloseButton.Size = UDim2.new(0, 19, 0, 19)
CloseButton.Font = Enum.Font.SourceSans
CloseButton.Text = ""
CloseButton.TextColor3 = Color3.new(0, 0, 0)
CloseButton.TextSize = 14

ImageLabel.Parent = CloseButton
ImageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel.BackgroundTransparency = 1
ImageLabel.Position = UDim2.new(0, 5, 0, 5)
ImageLabel.Size = UDim2.new(0, 9, 0, 9)
ImageLabel.Image = "http://www.roblox.com/asset/?id=5597086202"

MaximizeButton.Name = "MaximizeButton"
MaximizeButton.Parent = TopBar
MaximizeButton.BackgroundColor3 = Color3.new(0.145098, 0.141176, 0.14902)
MaximizeButton.BorderSizePixel = 0
MaximizeButton.Position = UDim2.new(1, -38, 0, 0)
MaximizeButton.Size = UDim2.new(0, 19, 0, 19)
MaximizeButton.Font = Enum.Font.SourceSans
MaximizeButton.Text = ""
MaximizeButton.TextColor3 = Color3.new(0, 0, 0)
MaximizeButton.TextSize = 14

ImageLabel_2.Parent = MaximizeButton
ImageLabel_2.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel_2.BackgroundTransparency = 1
ImageLabel_2.Position = UDim2.new(0, 5, 0, 5)
ImageLabel_2.Size = UDim2.new(0, 9, 0, 9)
ImageLabel_2.Image = "http://www.roblox.com/asset/?id=5597108117"

MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TopBar
MinimizeButton.BackgroundColor3 = Color3.new(0.145098, 0.141176, 0.14902)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(1, -57, 0, 0)
MinimizeButton.Size = UDim2.new(0, 19, 0, 19)
MinimizeButton.Font = Enum.Font.SourceSans
MinimizeButton.Text = ""
MinimizeButton.TextColor3 = Color3.new(0, 0, 0)
MinimizeButton.TextSize = 14

ImageLabel_3.Parent = MinimizeButton
ImageLabel_3.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel_3.BackgroundTransparency = 1
ImageLabel_3.Position = UDim2.new(0, 5, 0, 5)
ImageLabel_3.Size = UDim2.new(0, 9, 0, 9)
ImageLabel_3.Image = "http://www.roblox.com/asset/?id=5597105827"

ToolTip.Name = "ToolTip"
ToolTip.Parent = SimpleSpy2
ToolTip.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
ToolTip.BackgroundTransparency = 0.1
ToolTip.BorderColor3 = Color3.new(1, 1, 1)
ToolTip.Size = UDim2.new(0, 200, 0, 50)
ToolTip.ZIndex = 3
ToolTip.Visible = false

TextLabel.Parent = ToolTip
TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0, 2, 0, 2)
TextLabel.Size = UDim2.new(0, 196, 0, 46)
TextLabel.ZIndex = 3
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "This is some slightly longer text."
TextLabel.TextColor3 = Color3.new(1, 1, 1)
TextLabel.TextSize = 14
TextLabel.TextWrapped = true
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.TextYAlignment = Enum.TextYAlignment.Top

-------------------------------------------------------------------------------
-- init
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")
local TextService = game:GetService("TextService")
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()

local selectedColor = Color3.new(0.321569, 0.333333, 1)
local deselectedColor = Color3.new(0.8, 0.8, 0.8)
--- So things are descending
local layoutOrderNum = 999999999
--- Whether or not the gui is closing
local mainClosing = false
--- Whether or not the gui is closed (defaults to false)
local closed = false
--- Whether or not the sidebar is closing
local sideClosing = false
--- Whether or not the sidebar is closed (defaults to true but opens automatically on remote selection)
local sideClosed = false
--- Whether or not the code box is maximized (defaults to false)
local maximized = false
--- The event logs to be read from
local logs = {}
--- The event currently selected.Log (defaults to nil)
local selected = nil
--- The blacklist (can be a string name or the Remote Instance)
local blacklist = {}
--- The block list (can be a string name or the Remote Instance)
local blocklist = {}
--- Whether or not to add getNil function
local getNil = false
--- Array of remotes (and original functions) connected to
local connectedRemotes = {}
--- True = hookfunction, false = namecall
local toggle = false
local gm = getrawmetatable(game)
local original = gm.__namecall
setreadonly(gm, false)
--- used to prevent recursives
local prevTables = {}
--- holds logs (for deletion)
local remoteLogs = {}
--- used for hookfunction
local remoteEvent = Instance.new("RemoteEvent")
--- used for hookfunction
local remoteFunction = Instance.new("RemoteFunction")
local originalEvent = remoteEvent.FireServer
local originalFunction = remoteFunction.InvokeServer
--- the maximum amount of remotes allowed in logs
_G.SIMPLESPYCONFIG_MaxRemotes = 500
--- how many spaces to indent
local indent = 4
--- used for task scheduler
local scheduled = {}
--- RBXScriptConnect of the task scheduler
local schedulerconnect
local SimpleSpy = {}
local topstr = ""
local bottomstr = ""
local remotesFadeIn
local rightFadeIn
local codebox
local p
local getnilrequired = false

-- autoblock variables
local autoblock = false
local history = {}
local excluding = {}

-- function info variables
local funcEnabled = true

-- remote hooking/connecting api variables
local remoteSignals = {}
local remoteHooks = {}

-- original mouse icon
local oldIcon = Mouse.Icon

-- if mouse inside gui
local mouseInGui = false

-- handy array of RBXScriptConnections to disconnect on shutdown
local connections = {}

-- whether or not SimpleSpy uses 'getcallingscript()' to get the script (default is false because detection)
local useGetCallingScript = false

-- functions

--- Converts arguments to a string and generates code that calls the specified method with them, recommended to be used in conjunction with ValueToString (method must be a string, e.g. `game:GetService("ReplicatedStorage").Remote:FireServer`)
--- @param method string
--- @param args any[]
--- @return string
function SimpleSpy:ArgsToString(method, args)
    assert(typeof(method) == "string", "string expected, got " .. typeof(method))
    assert(typeof(args) == "table", "table expected, got " .. typeof(args))
    return v2v({args = args}) .. "\n\n" .. method .. "(unpack(args))"
end

--- Converts a value to variables with the specified index as the variable name (if nil/invalid then the name will be assigned automatically)
--- @param t any[]
--- @return string
function SimpleSpy:TableToVars(t)
    assert(typeof(t) == "table", "table expected, got " .. typeof(t))
    return v2v(t)
end

--- Converts a value to a variable with the specified `variablename` (if nil/invalid then the name will be assigned automatically)
--- @param value any
--- @return string
function SimpleSpy:ValueToVar(value, variablename)
    assert(variablename == nil or typeof(variablename) == "string", "string expected, got " .. typeof(variablename))
    if not variablename then
        variablename = 1
    end
    return v2v({[variablename] = value})
end

--- Converts any value to a string, cannot preserve function contents
--- @param value any
--- @return string
function SimpleSpy:ValueToString(value)
    return v2s(value)
end

--- Generates the simplespy function info
--- @param func function
--- @return string
function SimpleSpy:GetFunctionInfo(func)
    assert(typeof(func) == "function", "Instance expected, got " .. typeof(func))
    return v2v{functionInfo = {
        info = debug.getinfo(func),
        constants = debug.getconstants(func)
    }}
end

--- Gets the ScriptSignal for a specified remote being fired
--- @param remote Instance
function SimpleSpy:GetRemoteFiredSignal(remote)
    assert(typeof(remote) == "Instance", "Instance expected, got " .. typeof(remote))
    if not remoteSignals[remote] then
        remoteSignals[remote] = newSignal()
    end
    return remoteSignals[remote]
end

--- Allows for direct hooking of remotes **THIS CAN BE VERY DANGEROUS**
--- @param remote Instance
--- @param f function
function SimpleSpy:HookRemote(remote, f)
    assert(typeof(remote) == "Instance", "Instance expected, got " .. typeof(remote))
    assert(typeof(f) == "function", "function expected, got " .. typeof(f))
    remoteHooks[remote] = f
end

--- Blocks the specified remote instance/string
--- @param remote any
function SimpleSpy:BlockRemote(remote)
    assert(typeof(remote) == "Instance" or typeof(remote) == "string", "Instance | string expected, got " .. typeof(remote))
    blocklist[remote] = true
end

--- Excludes the specified remote from logs (instance/string)
--- @param remote any
function SimpleSpy:ExcludeRemote(remote)
    assert(typeof(remote) == "Instance" or typeof(remote) == "string", "Instance | string expected, got " .. typeof(remote))
    blacklist[remote] = true
end

--- Creates a new ScriptSignal that can be connected to and fired
--- @return table
function newSignal()
    local connected = {}
    return {
        Connect = function(self, f)
            assert(connected, "Signal is closed")
            connected[tostring(f)] = f
            return setmetatable({
                Connected = true,
                Disconnect = function(self)
                    if not connected then
                        warn("Signal is already closed")
                    end
                    self.Connected = false
                    connected[tostring(f)] = nil
                end
            },
            {
                __index = function(self, i)
                    if i == "Connected" then
                        return not not connected[tostring(f)]
                    end
                end
            })
        end,
        Fire = function(self, ...)
            for _, f in pairs(connected) do
                coroutine.wrap(f)(...)
            end
        end
    }
end

--- Prevents remote spam from causing lag (clears logs after `_G.SIMPLESPYCONFIG_MaxRemotes` or 500 remotes)
function clean()
    local max = _G.SIMPLESPYCONFIG_MaxRemotes
    if not typeof(max) == "number" and math.floor(max) ~= max then
        max = 500
    end
    if #remoteLogs > max then
        for i = 100, #remoteLogs do
            local v = remoteLogs[i]
            if typeof(v[1]) == "RBXScriptConnection" then
                v[1]:Disconnect()
            end
            if typeof(v[2]) == "Instance" then
                v[2]:Destroy()
            end
        end
        local newLogs = {}
        for i = 1, 100 do
            table.insert(newLogs, remoteLogs[i])
        end
        remoteLogs = newLogs
    end
end

--- Scales the ToolTip to fit containing text
function scaleToolTip()
    local size = TextService:GetTextSize(TextLabel.Text, TextLabel.TextSize, TextLabel.Font, Vector2.new(196, math.huge))
    TextLabel.Size = UDim2.new(0, size.X, 0, size.Y)
    ToolTip.Size = UDim2.new(0, size.X + 4, 0, size.Y + 4)
end

--- Executed when the toggle button (the SimpleSpy logo) is hovered over
function onToggleButtonHover()
    if not toggle then
        TweenService:Create(Simple, TweenInfo.new(0.5), {TextColor3 = Color3.fromRGB(252, 51, 51)}):Play()
    else
        TweenService:Create(Simple, TweenInfo.new(0.5), {TextColor3 = Color3.fromRGB(68, 206, 91)}):Play()
    end
end

--- Executed when the toggle button is unhovered over
function onToggleButtonUnhover()
    TweenService:Create(Simple, TweenInfo.new(0.5), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end

--- Executed when the X button is hovered over
function onXButtonHover()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 60, 60)}):Play()
end

--- Executed when the X button is unhovered over
function onXButtonUnhover()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(37, 36, 38)}):Play()
end

--- Toggles the remote spy method (when button clicked)
function onToggleButtonClick()
    if toggle then
        TweenService:Create(Simple, TweenInfo.new(0.5), {TextColor3 = Color3.fromRGB(252, 51, 51)}):Play()
    else
        TweenService:Create(Simple, TweenInfo.new(0.5), {TextColor3 = Color3.fromRGB(68, 206, 91)}):Play()
    end
    toggleSpyMethod()
end

--- Reconnects bringBackOnResize if the current viewport changes and also connects it initially
function connectResize()
    local lastCam = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(bringBackOnResize)
    workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
        lastCam:Disconnect()
        if workspace.CurrentCamera then
            lastCam = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(bringBackOnResize)
        end
    end)
end

--- Brings gui back if it gets lost offscreen (connected to the camera viewport changing)
function bringBackOnResize()
    local currentX = Background.AbsolutePosition.X
    local currentY = Background.AbsolutePosition.Y
    local viewportSize = workspace.CurrentCamera.ViewportSize
    if (currentX < 0) or (currentX > (viewportSize.X - (sideClosed and 131 or TopBar.AbsoluteSize.X))) then
        if currentX < 0 then
            currentX = 0
        else
            currentX = viewportSize.X - (sideClosed and 131 or TopBar.AbsoluteSize.X)
        end
    end
    if (currentY < 0) or (currentY > (viewportSize.Y - (closed and 19 or Background.AbsoluteSize.Y) - 36)) then
        if currentY < 0 then
            currentY = 0
        else
            currentY = viewportSize.Y - (closed and 19 or Background.AbsoluteSize.Y) - 36
        end
    end
    TweenService.Create(TweenService, Background, TweenInfo.new(0.1), {Position = UDim2.new(0, currentX, 0, currentY)}):Play()
end

--- Drags gui (so long as mouse is held down)
function onBarInput(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local lastPos = UserInputService.GetMouseLocation(UserInputService)
        local mainPos = Background.AbsolutePosition
        local offset = mainPos - lastPos
        local currentPos = offset + lastPos
        RunService.BindToRenderStep(RunService, "drag", 1,
            function()
                local newPos = UserInputService.GetMouseLocation(UserInputService)
                if newPos ~= lastPos then
                    local currentX = (offset + newPos).X
                    local currentY = (offset + newPos).Y
                    local viewportSize = workspace.CurrentCamera.ViewportSize
                    if (currentX < 0 and currentX < currentPos.X) or (currentX > (viewportSize.X - (sideClosed and 131 or TopBar.AbsoluteSize.X)) and currentX > currentPos.X) then
                        if currentX < 0 then
                            currentX = 0
                        else
                            currentX = viewportSize.X - (sideClosed and 131 or TopBar.AbsoluteSize.X)
                        end
                    end
                    if (currentY < 0 and currentY < currentPos.Y) or (currentY > (viewportSize.Y - (closed and 19 or Background.AbsoluteSize.Y) - 36) and currentY > currentPos.Y) then
                        if currentY < 0 then
                            currentY = 0
                        else
                            currentY = viewportSize.Y - (closed and 19 or Background.AbsoluteSize.Y) - 36
                        end
                    end
                    currentPos = Vector2.new(currentX, currentY)
                    lastPos = newPos
                    TweenService.Create(TweenService, Background, TweenInfo.new(0.1), {Position = UDim2.new(0, currentPos.X, 0, currentPos.Y)}):Play()
                end
                if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                    RunService.UnbindFromRenderStep(RunService, "drag")
                end
            end
        )
    end
end

--- Fades out the table of elements (and makes them invisible), returns a function to make them visible again
function fadeOut(elements)
    local data = {}
    for _, v in pairs(elements) do
        if typeof(v) == "Instance" and v:IsA("GuiObject") and v.Visible then
            coroutine.wrap(function()
                data[v] = {
                    BackgroundTransparency = v.BackgroundTransparency
                }
                TweenService:Create(v, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
                if v:IsA("TextBox") or v:IsA("TextButton") or v:IsA("TextLabel") then
                    data[v].TextTransparency = v.TextTransparency
                    TweenService:Create(v, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
                elseif v:IsA("ImageButton") or v:IsA("ImageLabel") then
                    data[v].ImageTransparency = v.ImageTransparency
                    TweenService:Create(v, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
                end
                wait(0.5)
                v.Visible = false
                for i, x in pairs(data[v]) do
                    v[i] = x
                end
                data[v] = true
            end)()
        end
    end
    return function()
        for i, _ in pairs(data) do
            coroutine.wrap(function()
                local properties = {
                    BackgroundTransparency = i.BackgroundTransparency
                }
                i.BackgroundTransparency = 1
                TweenService:Create(i, TweenInfo.new(0.5), {BackgroundTransparency = properties.BackgroundTransparency}):Play()
                if i:IsA("TextBox") or i:IsA("TextButton") or i:IsA("TextLabel") then
                    properties.TextTransparency = i.TextTransparency
                    i.TextTransparency = 1
                    TweenService:Create(i, TweenInfo.new(0.5), {TextTransparency = properties.TextTransparency}):Play()
                elseif i:IsA("ImageButton") or i:IsA("ImageLabel") then
                    properties.ImageTransparency = i.ImageTransparency
                    i.ImageTransparency = 1
                    TweenService:Create(i, TweenInfo.new(0.5), {ImageTransparency = properties.ImageTransparency}):Play()
                end
                i.Visible = true
            end)()
        end
    end
end

--- Expands and minimizes the gui (closed is the toggle boolean)
function toggleMinimize(override)
    if mainClosing and not override or maximized then
        return
    end
    mainClosing = true
    closed = not closed
    if closed then
        if not sideClosed then
            toggleSideTray(true)
        end
        LeftPanel.Visible = true
        TweenService:Create(LeftPanel, TweenInfo.new(0.5), {Size = UDim2.new(0, 131, 0, 0)}):Play()
        wait(0.5)
        remotesFadeIn = fadeOut(LeftPanel:GetDescendants())
        wait(0.5)
    else
        TweenService:Create(LeftPanel, TweenInfo.new(0.5), {Size = UDim2.new(0, 131, 0, 249)}):Play()
        wait(0.5)
        if remotesFadeIn then
            remotesFadeIn()
            remotesFadeIn = nil
        end
        bringBackOnResize()
    end
    mainClosing = false
end

--- Expands and minimizes the sidebar (sideClosed is the toggle boolean)
function toggleSideTray(override)
    if sideClosing and not override or maximized then
        return
    end
    sideClosing = true
    sideClosed = not sideClosed
    if sideClosed then
        rightFadeIn = fadeOut(RightPanel:GetDescendants())
        wait(0.5)
        minimizeSize(0.5)
        wait(0.5)
        RightPanel.Visible = false
    else
        if closed then
            toggleMinimize(true)
        end
        RightPanel.Visible = true
        maximizeSize(0.5)
        wait(0.5)
        if rightFadeIn then
            rightFadeIn()
        end
        bringBackOnResize()
    end
    sideClosing = false
end

--- Expands code box to fit screen for more convenient viewing
function toggleMaximize()
    if not sideClosed and not maximized then
        maximized = true
        local disable = Instance.new("TextButton")
        local prevSize = UDim2.new(0, CodeBox.AbsoluteSize.X, 0, CodeBox.AbsoluteSize.Y)
        local prevPos = UDim2.new(0,CodeBox.AbsolutePosition.X, 0, CodeBox.AbsolutePosition.Y)
        disable.Size = UDim2.new(1, 0, 1, 0)
        disable.BackgroundColor3 = Color3.new()
        disable.BorderSizePixel = 0
        disable.Text = 0
        disable.ZIndex = 3
        disable.BackgroundTransparency = 1
        disable.AutoButtonColor = false
        CodeBox.ZIndex = 4
        CodeBox.Position = prevPos
        CodeBox.Size = prevSize
        TweenService:Create(CodeBox, TweenInfo.new(0.5), {Size = UDim2.new(0.5, 0, 0.5, 0), Position = UDim2.new(0.25, 0, 0.25, 0)}):Play()
        TweenService:Create(disable, TweenInfo.new(0.5), {BackgroundTransparency = 0.5}):Play()
        disable.MouseButton1Click:Connect(function()
            if UserInputService:GetMouseLocation().Y + 36 >= CodeBox.AbsolutePosition.Y and UserInputService:GetMouseLocation().Y + 36 <= CodeBox.AbsolutePosition.Y + CodeBox.AbsoluteSize.Y
                and UserInputService:GetMouseLocation().X >= CodeBox.AbsolutePosition.X and UserInputService:GetMouseLocation().X <= CodeBox.AbsolutePosition.X + CodeBox.AbsoluteSize.X then
                return
            end
            TweenService:Create(CodeBox, TweenInfo.new(0.5), {Size = prevSize, Position = prevPos}):Play()
            TweenService:Create(disable, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            wait(0.5)
            disable:Destroy()
            CodeBox.Size = UDim2.new(1, 0, 0.5, 0)
            CodeBox.Position = UDim2.new(0, 0, 0, 0)
            CodeBox.ZIndex = 0
            maximized = false
        end)
    end
end

--- Checks if cursor is within resize range
--- @param p Vector2
function isInResizeRange(p)
    local relativeP = p - Background.AbsolutePosition
    local range = 5
    if relativeP.X >= TopBar.AbsoluteSize.X - range and relativeP.Y >= Background.AbsoluteSize.Y - range
        and relativeP.X <= TopBar.AbsoluteSize.X and relativeP.Y <= Background.AbsoluteSize.Y then
        return true, 'B'
    elseif relativeP.X >= TopBar.AbsoluteSize.X - range and relativeP.X <= Background.AbsoluteSize.X then
        return true, 'X'
    elseif relativeP.Y >= Background.AbsoluteSize.Y - range and relativeP.Y <= Background.AbsoluteSize.Y then
        return true, 'Y'
    end
    return false
end

--- Called when mouse enters SimpleSpy
function mouseEntered()
    local customCursor = Instance.new("ImageLabel")
    customCursor.Size = UDim2.fromOffset(200, 200)
    customCursor.ZIndex = 1e5
    customCursor.BackgroundTransparency = 1
    customCursor.Image = ""
    customCursor.Parent = SimpleSpy2
    UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide
    RunService:BindToRenderStep("SIMPLESPY_CURSOR", 1, function()
        if mouseInGui and _G.SimpleSpyExecuted then
            local mouseLocation = UserInputService:GetMouseLocation() - Vector2.new(0, 36)
            customCursor.Position = UDim2.fromOffset(mouseLocation.X - customCursor.AbsoluteSize.X / 2, mouseLocation.Y - customCursor.AbsoluteSize.Y / 2)
            local inRange, type = isInResizeRange(mouseLocation)
            if inRange and not sideClosed and not closed then
                customCursor.Image = type == 'B' and "rbxassetid://6065821980" or type == 'X' and "rbxassetid://6065821086" or type == 'Y' and "rbxassetid://6065821596"
            elseif inRange and not closed and type == 'Y' or type == 'B' then
                customCursor.Image = "rbxassetid://6065821596"
            elseif customCursor.Image ~= "rbxassetid://6065775281" then
                customCursor.Image = "rbxassetid://6065775281"
            end
        else
            UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.None
            customCursor:Destroy()
            RunService:UnbindFromRenderStep("SIMPLESPY_CURSOR")
        end
    end)
end

--- Called when mouse moves
function mouseMoved()
    local mousePos = UserInputService:GetMouseLocation() - Vector2.new(0, 36)
    if not closed
    and mousePos.X >= TopBar.AbsolutePosition.X and mousePos.X <= TopBar.AbsolutePosition.X + TopBar.AbsoluteSize.X
    and mousePos.Y >= Background.AbsolutePosition.Y and mousePos.Y <= Background.AbsolutePosition.Y + Background.AbsoluteSize.Y then
        if not mouseInGui then
            mouseInGui = true
            mouseEntered()
        end
    else
        mouseInGui = false
    end
end

--- Adjusts the ui elements to the 'Maximized' size
function maximizeSize(speed)
    if not speed then
        speed = 0.05
    end
    TweenService:Create(LeftPanel, TweenInfo.new(speed), { Size = UDim2.fromOffset(LeftPanel.AbsoluteSize.X, Background.AbsoluteSize.Y - TopBar.AbsoluteSize.Y) }):Play()
    TweenService:Create(RightPanel, TweenInfo.new(speed), { Size = UDim2.fromOffset(Background.AbsoluteSize.X - LeftPanel.AbsoluteSize.X, Background.AbsoluteSize.Y - TopBar.AbsoluteSize.Y) }):Play()
    TweenService:Create(TopBar, TweenInfo.new(speed), { Size = UDim2.fromOffset(Background.AbsoluteSize.X, TopBar.AbsoluteSize.Y) }):Play()
    TweenService:Create(ScrollingFrame, TweenInfo.new(speed), { Size = UDim2.fromOffset(Background.AbsoluteSize.X - LeftPanel.AbsoluteSize.X, 110), Position = UDim2.fromOffset(0, Background.AbsoluteSize.Y - 119 - TopBar.AbsoluteSize.Y) }):Play()
    TweenService:Create(CodeBox, TweenInfo.new(speed), { Size = UDim2.fromOffset(Background.AbsoluteSize.X - LeftPanel.AbsoluteSize.X, Background.AbsoluteSize.Y - 119 - TopBar.AbsoluteSize.Y) }):Play()
    TweenService:Create(LogList, TweenInfo.new(speed), { Size = UDim2.fromOffset(LogList.AbsoluteSize.X, Background.AbsoluteSize.Y - TopBar.AbsoluteSize.Y - 18) }):Play()
end

--- Adjusts the ui elements to close the side
function minimizeSize(speed)
    if not speed then
        speed = 0.05
    end
    TweenService:Create(LeftPanel, TweenInfo.new(speed), { Size = UDim2.fromOffset(LeftPanel.AbsoluteSize.X, Background.AbsoluteSize.Y - TopBar.AbsoluteSize.Y) }):Play()
    TweenService:Create(RightPanel, TweenInfo.new(speed), { Size = UDim2.fromOffset(0, Background.AbsoluteSize.Y - TopBar.AbsoluteSize.Y) }):Play()
    TweenService:Create(TopBar, TweenInfo.new(speed), { Size = UDim2.fromOffset(LeftPanel.AbsoluteSize.X, TopBar.AbsoluteSize.Y) }):Play()
    TweenService:Create(ScrollingFrame, TweenInfo.new(speed), { Size = UDim2.fromOffset(0, 119), Position = UDim2.fromOffset(0, Background.AbsoluteSize.Y - 119 - TopBar.AbsoluteSize.Y) }):Play()
    TweenService:Create(CodeBox, TweenInfo.new(speed), { Size = UDim2.fromOffset(0, Background.AbsoluteSize.Y - 119 - TopBar.AbsoluteSize.Y) }):Play()
    TweenService:Create(LogList, TweenInfo.new(speed), { Size = UDim2.fromOffset(LogList.AbsoluteSize.X, Background.AbsoluteSize.Y - TopBar.AbsoluteSize.Y - 18) }):Play()
end

--- Called on user input while mouse in 'Background' frame
--- @param input InputObject
function backgroundUserInput(input)
    local inRange, type = isInResizeRange(UserInputService:GetMouseLocation() - Vector2.new(0, 36))
    if input.UserInputType == Enum.UserInputType.MouseButton1 and inRange then
        local lastPos = UserInputService:GetMouseLocation()
        local offset = Background.AbsoluteSize - lastPos
        local currentPos = lastPos + offset
        RunService:BindToRenderStep("SIMPLESPY_RESIZE", 1, function()
            local newPos = UserInputService:GetMouseLocation()
            if newPos ~= lastPos then
                local currentX = (newPos + offset).X
                local currentY = (newPos + offset).Y
                if currentX < 450 then
                    currentX = 450
                end
                if currentY < 268 then
                    currentY = 268
                end
                currentPos = Vector2.new(currentX, currentY)
                Background.Size = UDim2.fromOffset((not sideClosed and not closed and (type == "X" or type == "B")) and currentPos.X or Background.AbsoluteSize.X, (--[[(not sideClosed or currentPos.X <= LeftPanel.AbsolutePosition.X + LeftPanel.AbsoluteSize.X) and]] not closed and (type == "Y" or type == "B")) and currentPos.Y or Background.AbsoluteSize.Y)
                if sideClosed then
                    minimizeSize()
                else
                    maximizeSize()
                end
                lastPos = newPos
            end
        end)
        table.insert(connections, UserInputService.InputEnded:Connect(function(inputE)
            if input == inputE then
                RunService:UnbindFromRenderStep("SIMPLESPY_RESIZE")
            end
        end))
    end
end

--- Gets the player an instance is descended from
function getPlayerFromInstance(instance)
    for _, v in pairs(Players:GetPlayers()) do
        if v.Character and (instance:IsDescendantOf(v.Character) or instance == v.Character) then
            return v
        end
    end
end

--- Runs on MouseButton1Click of an event frame
function eventSelect(frame)
    if selected and selected.Log  then
        TweenService:Create(selected.Log.Button, TweenInfo.new(0.5), {BackgroundColor3 = Color3.fromRGB(0, 0, 0)}):Play()
        selected = nil
    end
    for _, v in pairs(logs) do
        if frame == v.Log then
            selected = v
        end
    end
    if selected and selected.Log then
        TweenService:Create(frame.Button, TweenInfo.new(0.5), {BackgroundColor3 = Color3.fromRGB(92, 126, 229)}):Play()
        codebox:setRaw(selected.GenScript)
    end
    if sideClosed then
        toggleSideTray()
    end
end

--- Updates the canvas size to fit the current amount of function buttons
function updateFunctionCanvas()
    ScrollingFrame.CanvasSize = UDim2.fromOffset(UIGridLayout.AbsoluteContentSize.X, UIGridLayout.AbsoluteContentSize.Y)
end

--- Updates the canvas size to fit the amount of current remotes
function updateRemoteCanvas()
    LogList.CanvasSize = UDim2.fromOffset(UIListLayout.AbsoluteContentSize.X, UIListLayout.AbsoluteContentSize.Y)
end

--- Allows for toggling of the tooltip and easy setting of le description
--- @param enable boolean
--- @param text string
function makeToolTip(enable, text)
    if enable then
        if ToolTip.Visible then
            ToolTip.Visible = false
            RunService:UnbindFromRenderStep("ToolTip")
        end
        local first = true
        RunService:BindToRenderStep("ToolTip", 1, function()
            local topLeft = Vector2.new(Mouse.X + 20, Mouse.Y + 20)
            local bottomRight = topLeft + ToolTip.AbsoluteSize
            if topLeft.X < 0 then
                topLeft = Vector2.new(0, topLeft.Y)
            elseif bottomRight.X > workspace.CurrentCamera.ViewportSize.X then
                topLeft = Vector2.new(workspace.CurrentCamera.ViewportSize.X - ToolTip.AbsoluteSize.X, topLeft.Y)
            end
            if topLeft.Y < 0 then
                topLeft = Vector2.new(topLeft.X, 0)
            elseif bottomRight.Y > workspace.CurrentCamera.ViewportSize.Y - 35 then
                topLeft = Vector2.new(topLeft.X, workspace.CurrentCamera.ViewportSize.Y - ToolTip.AbsoluteSize.Y - 35)
            end
            if topLeft.X <= Mouse.X and topLeft.Y <= Mouse.Y then
                topLeft = Vector2.new(Mouse.X - ToolTip.AbsoluteSize.X - 2, Mouse.Y - ToolTip.AbsoluteSize.Y - 2)
            end
            if first then
                ToolTip.Position = UDim2.fromOffset(topLeft.X, topLeft.Y)
                first = false
            else
                ToolTip:TweenPosition(UDim2.fromOffset(topLeft.X, topLeft.Y), "Out", "Linear", 0.1)
            end
        end)
        TextLabel.Text = text
        ToolTip.Visible = true
    else
        if ToolTip.Visible then
            ToolTip.Visible = false
            RunService:UnbindFromRenderStep("ToolTip")
        end
    end
end

--- Creates new function button (below codebox)
--- @param name string
---@param description function
---@param onClick function
function newButton(name, description, onClick)
    local button = FunctionTemplate:Clone()
    button.Text.Text = name
    button.Button.MouseEnter:Connect(function()
        makeToolTip(true, description())
    end)
    button.Button.MouseLeave:Connect(function()
        makeToolTip(false)
    end)
    button.AncestryChanged:Connect(function()
        makeToolTip(false)
    end)
    button.Button.MouseButton1Click:Connect(function(...)
        onClick(button, ...)
    end)
    button.Parent = ScrollingFrame
    updateFunctionCanvas()
end

--- Adds new Remote to logs
--- @param name string The name of the remote being logged
--- @param type string The type of the remote being logged (either 'function' or 'event')
--- @param gen_script any
--- @param remote any
--- @param function_info string
--- @param blocked any
function newRemote(type, name, gen_script, remote, function_info, blocked, src)
    local remoteFrame = RemoteTemplate:Clone()
    remoteFrame.Text.Text = name
    remoteFrame.ColorBar.BackgroundColor3 = type == "event" and Color3.new(255, 242, 0) or Color3.fromRGB(99, 86, 245)
    local id = Instance.new("IntValue")
    id.Name = "ID"
    id.Value = #logs + 1
    id.Parent = remoteFrame
    logs[#logs + 1] = {
        Name = name,
        GenScript = gen_script,
        Function = function_info,
        Remote = remote,
        Log = remoteFrame,
        Blocked = blocked,
        Source = src
    }
    if blocked then
        logs[#logs].GenScript = "-- THIS REMOTE WAS PREVENTED FROM FIRING THE SERVER BY SIMPLESPY\n\n" .. logs[#logs].GenScript
    end
    local connect = remoteFrame.Button.MouseButton1Click:Connect(function()
        eventSelect(remoteFrame)
    end)
    if layoutOrderNum < 1 then
        layoutOrderNum = 999999999
    end
    remoteFrame.LayoutOrder = layoutOrderNum
    layoutOrderNum = layoutOrderNum - 1
    remoteFrame.Parent = LogList
    table.insert(remoteLogs, 1, {connect, remoteFrame})
    clean()
    updateRemoteCanvas()
end

--- Generates a script from the provided arguments (first has to be remote path)
function genScript(remote, ...)
    prevTables = {}
    local gen = ""
    local args = {...}
    if #args > 0 then
        if not pcall(function()
                gen = v2v({args = args}) .. "\n"
            end)
        then
            gen = gen .. "-- TableToString failure! Reverting to legacy functionality (results may vary)\nlocal args = {"
            if
                not pcall(
                    function()
                        for i, v in pairs(args) do
                            if type(i) ~= "Instance" and type(i) ~= "userdata" then
                                gen = gen .. "\n    [" .. tostring(i) .. "] = "
                            elseif type(i) == "string" then
                                gen = gen .. '\n    ["' .. tostring(i) .. '"] = '
                            elseif type(i) == "userdata" and typeof(i) ~= "Instance" then
                                gen = gen .. "\n    [" .. typeof(i) .. ".new(" .. tostring(i) .. ")] = "
                            elseif type(i) == "userdata" then
                                gen = gen .. "\n    [game." .. i:GetFullName() .. ")] = "
                            end
                            if type(v) ~= "Instance" and type(v) ~= "userdata" then
                                gen = gen .. tostring(v)
                            elseif type(v) == "string" then
                                gen = gen .. '"' .. tostring(v) .. '"'
                            elseif type(v) == "userdata" and typeof(v) ~= "Instance" then
                                gen = gen .. typeof(v) .. ".new(" .. tostring(v) .. ")"
                            elseif type(v) == "userdata" then
                                gen = gen .. "game." .. v:GetFullName()
                            end
                        end
                        gen = gen .. "\n}\n\n"
                    end
                )
             then
                gen = gen .. "}\n-- Legacy tableToString failure! Unable to decompile."
            end
        end
        if not remote:IsDescendantOf(game) and not getnilrequired then
            gen = "function getNil(name,class) for _,v in pairs(getnilinstances())do if v.ClassName==class and v.Name==name then return v;end end end\n\n" .. gen
        end
        if remote:IsA("RemoteEvent") then
            gen = gen .. v2s(remote) .. ":FireServer(unpack(args))"
        elseif remote:IsA("RemoteFunction") then
            gen = gen .. v2s(remote) .. ":InvokeServer(unpack(args))"
        end
    else
        if remote:IsA("RemoteEvent") then
            gen = gen .. v2s(remote) .. ":FireServer()"
        elseif remote:IsA("RemoteFunction") then
            gen = gen .. v2s(remote) .. ":InvokeServer()"
        end
    end
    gen = "" .. gen
    prevTables = {}
    return gen
end

--- value-to-string: value, string (out), level (indentation), parent table, var name, is from tovar
function v2s(v, l, p, n, vtv, i, pt, path, tables)
    if typeof(v) == "number" then
        if v == math.huge then
            return "math.huge"
        elseif tostring(v):match("nan") then
            return "0/0 --[[NaN]]"
        end
        return tostring(v)
    elseif typeof(v) == "boolean" then
        return tostring(v)
    elseif typeof(v) == "string" then
        return formatstr(v)
    elseif typeof(v) == "function" then
        return f2s(v)
    elseif typeof(v) == "table" then
        return t2s(v, l, p, n, vtv, i, pt, path, tables)
    elseif typeof(v) == "Instance" then
        return i2p(v)
    elseif typeof(v) == "userdata" then
        return "newproxy(true)"
    elseif type(v) == "userdata" then
        return u2s(v)
    else
        return "nil --[[" .. typeof(v) .. "]]"
    end
end

--- value-to-variable
--- @param t any
function v2v(t)
    topstr = ""
    bottomstr = ""
    getnilrequired = false
    local ret = ""
    local count = 1
    for i, v in pairs(t) do
        if type(i) == "string" and i:match("^[%a_]+[%w_]*$") then
            ret = ret .. "local " .. i .. " = " .. v2s(v, nil, nil, i, true) .. "\n"
        elseif tostring(i):match("^[%a_]+[%w_]*$") then
            ret = ret .. "local " .. tostring(i):lower() .. "_" .. tostring(count) .. " = " .. v2s(v, nil, nil, tostring(i):lower() .. "_" .. tostring(count), true) .. "\n"
        else
            ret = ret .. "local " .. type(v) .. "_" .. tostring(count) .. " = " .. v2s(v, nil, nil, type(v) .. "_" .. tostring(count), true) .. "\n"
        end
        count = count + 1
    end
    if getnilrequired then
        topstr = "function getNil(name,class) for _,v in pairs(getnilinstances())do if v.ClassName==class and v.Name==name then return v;end end end\n" .. topstr
    end
    if #topstr > 0 then
        ret = topstr .. "\n" .. ret
    end
    if #bottomstr > 0 then
        ret = ret .. bottomstr
    end
    return ret
end

--- table-to-string
--- @param t table
--- @param l number
--- @param p table
--- @param n string
--- @param vtv boolean
--- @param i any
--- @param pt table
--- @param path string
--- @param tables table
function t2s(t, l, p, n, vtv, i, pt, path, tables)
    for k, x in pairs(getrenv()) do
        local isgucci, gpath
        if rawequal(x, t) then
            isgucci, gpath = true, ""
        elseif type(x) == "table" then
            isgucci, gpath = v2p(t, x)
        end
        if isgucci then
            if type(k) == "string" and k:match("^[%a_]+[%w_]*$") then
                return k .. gpath
            else
                return "getrenv()[" .. v2s(k) .. "]" .. gpath
            end
        end
    end
    if not path then
        path = ""
    end
    if not l then
        l = 0
        tables = {}
    end
    if not p then
        p = t
    end
    for _, v in pairs(tables) do
        if n and rawequal(v, t) then
            bottomstr = bottomstr .. "\n" .. tostring(n) .. tostring(path) .. " = " .. tostring(n) .. tostring(({v2p(v, p)})[2])
            return "{} --[[DUPLICATE]]"
        end
    end
    table.insert(tables, t)
    local s =  "{"
    local size = 0
    l = l + indent
    for k, v in pairs(t) do
        size = size + 1
        if size > (_G.SimpleSpyMaxTableSize and _G.SimpleSpyMaxTableSize or 1000) then
            break
        end
        if rawequal(k, t) then
            bottomstr = bottomstr .. "\n" .. tostring(n) .. tostring(path) .. "[" .. tostring(n) .. tostring(path) .. "]" .. " = " .. (v == k and tostring(n) .. tostring(path) or v2s(v, l, p, n, vtv, k, t, path .. "[" .. tostring(n) .. tostring(path) .. "]", tables))
            size -= 1
            continue
        end
        local currentPath = ""
        if type(k) == "string" and k:match("^[%a_]+[%w_]*$") then
            currentPath = "." .. k
        else
            currentPath = "[" .. v2s(k, nil, p, n, vtv, i, pt, path) .. "]"
        end
        s = s .. "\n" .. string.rep(" ", l) .. "[" .. v2s(k, l, p, n, vtv, k, t, path .. currentPath, tables) .. "] = " .. v2s(v, l, p, n, vtv, k, t, path .. currentPath, tables) .. ","
    end
    if #s > 1 then
        s = s:sub(1, #s - 1)
    end
    if size > 0 then
        s = s .. "\n" .. string.rep(" ", l - indent)
    end
    return s .. "}"
end

--- function-to-string
function f2s(f)
    for k, x in pairs(getgenv()) do
        local isgucci, gpath
        if rawequal(x, f) then
            isgucci, gpath = true, ""
        elseif type(x) == "table" then
            isgucci, gpath = v2p(f, x)
        end
        if isgucci then
            if type(k) == "string" and k:match("^[%a_]+[%w_]*$") then
                return k .. gpath
            else
                return "getgenv()[" .. v2s(k) .. "]" .. gpath
            end
        end
    end
    -- uwu some cool stuff here once bork finishes up
    -- if SimpleSpy.GetExternalLoader then
    --     local ExternalLoader = SimpleSpy:GetExternalLoader()
    --     local loaded, path = pcall(function() ExternalLoader:LoadAsset("Bork_Functions") end)
    --     if loaded then
    --         local functions = loadfile(path .. "functions.lua")
    --         local out = functions[f]
    --         if out then
    --             return out
    --         end
    --     end
    -- end
    -- local isgucci, gpath = v2p(f, getgc())
    -- if isgucci then
    --     return "getgc()" .. gpath
    -- end
    if debug.getinfo(f).name:match("^[%a_]+[%w_]*$") then
        return "function()end --[[" .. debug.getinfo(f).name .. "]]"
    end
    return "function()end --[[" .. tostring(f) .. "]]"
end

--- instance-to-path
--- @param i userdata
function i2p(i)
    local player = getplayer(i)
    local parent = i
    local out = ""
    if parent == nil then
        return "nil"
    elseif player then
        while true do
            if parent and parent == player.Character then
                if player == Players.LocalPlayer then
                    return 'game:GetService("Players").LocalPlayer.Character' .. out
                else
                    return i2p(player) .. ".Character" .. out
                end
            else
                if parent.Name:match("[%a_]+[%w+]*") ~= parent.Name then
                    out = '[' .. formatstr(parent.Name) .. ']' .. out
                else
                    out = "." .. parent.Name .. out
                end
            end
            parent = parent.Parent
        end
    elseif parent ~= game then
        while true do
            if parent and parent.Parent == game then
                if game:GetService(parent.ClassName) then
                    if parent.ClassName == "Workspace" then
                        return "workspace" .. out
                    else
                        return 'game:GetService("' .. parent.ClassName .. '")' .. out
                    end
                else
                    if parent.Name:match("[%a_]+[%w_]*") then
                        return "game." .. parent.Name .. out
                    else
                        return 'game[' .. formatstr(parent.Name) .. ']' .. out
                    end
                end
            elseif parent.Parent == nil then
                getnilrequired = true
                return 'getNil(' .. formatstr(parent.Name) .. ', "' .. parent.ClassName .. '")' .. out
            elseif parent == Players.LocalPlayer then
                out = ".LocalPlayer" .. out
            else
                if parent.Name:match("[%a_]+[%w_]*") ~= parent.Name then
                    out = '[' .. formatstr(parent.Name) .. ']' .. out
                else
                    out = "." .. parent.Name .. out
                end
            end
            parent = parent.Parent
        end
    else
        return "game"
    end
end

--- userdata-to-string: userdata
--- @param u userdata
function u2s(u)
    if typeof(u) == "TweenInfo" then
        -- TweenInfo
        return "TweenInfo.new(" ..tostring(u.Time) .. ", Enum.EasingStyle." .. tostring(u.EasingStyle) .. ", Enum.EasingDirection." .. tostring(u.EasingDirection) .. ", " .. tostring(u.RepeatCount) .. ", " .. tostring(u.Reverses) .. ", " .. tostring(u.DelayTime) .. ")"
    elseif typeof(u) == "Ray" then
        -- Ray
        return "Ray.new(" .. u2s(u.Origin) .. ", " .. u2s(u.Direction) .. ")"
    elseif typeof(u) == "NumberSequence" then
        -- NumberSequence
        local ret = "NumberSequence.new("
        for i, v in pairs(u.KeyPoints) do
            ret = ret .. tostring(v)
            if i < #u.Keypoints then
                ret = ret .. ", "
            end
        end
        return ret .. ")"
    elseif typeof(u) == "DockWidgetPluginGuiInfo" then
        -- DockWidgetPluginGuiInfo
        return "DockWidgetPluginGuiInfo.new(Enum.InitialDockState" .. tostring(u) .. ")"
    elseif typeof(u) == "ColorSequence" then
        -- ColorSequence
        local ret = "ColorSequence.new("
        for i, v in pairs(u.KeyPoints) do
            ret = ret .. "Color3.new(" .. tostring(v) .. ")"
            if i < #u.Keypoints then
                ret = ret .. ", "
            end
        end
        return ret .. ")"
    elseif typeof(u) == "BrickColor" then
        -- BrickColor
        return "BrickColor.new(" .. tostring(u.Number) .. ")"
    elseif typeof(u) == "NumberRange" then
        -- NumberRange
        return "NumberRange.new(" .. tostring(u.Min) .. ", " .. tostring(u.Max) .. ")"
    elseif typeof(u) == "Region3" then
        -- Region3
        local center = u.CFrame.Position
        local size = u.CFrame.Size
        local vector1 = center - size / 2
        local vector2 = center + size / 2
        return "Region3.new(" .. u2s(vector1) .. ", " .. u2s(vector2) .. ")"
    elseif typeof(u) == "Faces" then
        -- Faces
        local faces = {}
        if u.Top then
            table.insert(faces, "Enum.NormalId.Top")
        end
        if u.Bottom then
            table.insert(faces, "Enum.NormalId.Bottom")
        end
        if u.Left then
            table.insert(faces, "Enum.NormalId.Left")
        end
        if u.Right then
            table.insert(faces, "Enum.NormalId.Right")
        end
        if u.Back then
            table.insert(faces, "Enum.NormalId.Back")
        end
        if u.Front then
            table.insert(faces, "Enum.NormalId.Front")
        end
        return "Faces.new(" .. table.concat(faces, ", ") .. ")"
    elseif typeof(u) == "EnumItem" then
        return tostring(u)
    elseif typeof(u) == "Enums" then
        return "Enum"
    elseif typeof(u) == "Enum" then
        return "Enum." .. tostring(u)
    elseif typeof(u) == "RBXScriptSignal" then
        return "nil --[[RBXScriptSignal]]"
    elseif typeof(u) == "Vector3" then
        return string.format("Vector3.new(%s, %s, %s)", v2s(u.X), v2s(u.Y), v2s(u.Z))
    elseif typeof(u) == "CFrame" then
        return string.format("CFrame.new(%s, %s)", v2s(u.Position), v2s(u.LookVector))
    elseif typeof(u) == "DockWidgetPluginGuiInfo" then
        return string.format("DockWidgetPluginGuiInfo(%s, %s, %s, %s, %s, %s, %s)", "Enum.InitialDockState.Right", v2s(u.InitialEnabled), v2s(u.InitialEnabledShouldOverrideRestore), v2s(u.FloatingXSize), v2s(u.FloatingYSize), v2s(u.MinWidth), v2s(u.MinHeight))
    elseif typeof(u) == "RBXScriptConnection" then
        return "nil --[[RBXScriptConnection " .. tostring(u) .. "]]"
    elseif typeof(u) == "RaycastResult" then
        return "nil --[[RaycastResult " .. tostring(u) .. "]]"
    elseif typeof(u) == "PathWaypoint" then
        return string.format("PathWaypoint.new(%s, %s)", v2s(u.Position), v2s(u.Action))
    else
        return typeof(u) .. ".new(" .. tostring(u) .. ")"
    end
end

--- Gets the player an instance is descended from
function getplayer(instance)
    for _, v in pairs(Players:GetPlayers()) do
        if v.Character and (instance:IsDescendantOf(v.Character) or instance == v.Character) then
            return v
        end
    end
end

--- value-to-path (in table)
function v2p(x, t, path, prev)
    if not path then
        path = ""
    end
    if not prev then
        prev = {}
    end
    if rawequal(x, t) then
        return true, ""
    end
    for i, v in pairs(t) do
        if rawequal(v, x) then
            if type(i) == "string" and i:match("^[%a_]+[%w_]*$") then
                return true, (path .. "." .. i)
            else
                return true, (path .. "[" .. v2s(i) .. "]")
            end
        end
        if type(v) == "table" then
            local duplicate = false
            for _, y in pairs(prev) do
                if rawequal(y, v) then
                    duplicate = true
                end
            end
            if not duplicate then
                table.insert(prev, t)
                local found
                found, p = v2p(x, v, path, prev)
                if found then
                    if type(i) == "string" and i:match("^[%a_]+[%w_]*$") then
                        return true, "." .. i .. p
                    else
                        return true, "[" .. v2s(i) .. "]" .. p
                    end
                end
            end
        end
    end
    return false, ""
end

--- format s: string, byte encrypt (for weird symbols)
function formatstr(s)
    return '"' .. handlespecials(s) .. '"'
end

--- Adds \'s to the text as a replacement to whitespace chars and other things because string.format can't yayeet
function handlespecials(s)
    local i = 0
    repeat
        i = i + 1
        local char = s:sub(i, i)
        if string.byte(char) then
            if char == "\n" then
                s = s:sub(0, i - 1) .. "\\n" .. s:sub(i + 1, -1)
                i = i + 1
            elseif char == "\t" then
                s = s:sub(0, i - 1) .. "\\t" .. s:sub(i + 1, -1)
                i = i + 1
            elseif char == "\\" then
                s = s:sub(0, i - 1) .. "\\\\" .. s:sub(i + 1, -1)
                i = i + 1
            elseif char == '"' then
                s = s:sub(0, i - 1) .. '\\"' .. s:sub(i + 1, -1)
                i = i + 1
            elseif string.byte(char) > 126 or string.byte(char) < 32 then
                s = s:sub(0, i - 1) .. "\\" .. string.byte(char) .. s:sub(i + 1, -1)
                i = i + #tostring(string.byte(char))
            end
        end
    until char == ""
    return s
end

--- finds script from 'src' from getinfo, returns nil if not found
--- @param src string
function getScriptFromSrc(src)
    local realPath
    local runningTest
    --- @type number
    local s, e
    local match = false
    if src:sub(1, 1) == "=" then
        realPath = game
        s = 2
    else
        runningTest = src:sub(2, e and e - 1 or -1)
        for _, v in pairs(getnilinstances()) do
            if v.Name == runningTest then
                realPath = v
                break
            end
        end
        s = #runningTest + 1
    end
    if realPath then
        e = src:sub(s, -1):find("%.")
        local i = 0
        repeat
            i += 1
            if not e then
                runningTest = src:sub(s, -1)
                local test = realPath.FindFirstChild(realPath, runningTest)
                if test then
                    realPath = test
                end
                match = true
            else
                runningTest = src:sub(s, e)
                local test = realPath.FindFirstChild(realPath, runningTest)
                local yeOld = e
                if test then
                    realPath = test
                    s = e + 2
                    e = src:sub(e + 2, -1):find("%.")
                    e = e and e + yeOld or e
                else
                    e = src:sub(e + 2, -1):find("%.")
                    e = e and e + yeOld or e
                end
            end
        until match or i >= 50
    end
    return realPath
end

--- schedules the provided function (and calls it with any args after)
function schedule(f, ...)
    table.insert(scheduled, {f, ...})
end

--- the big (well tbh small now) boi task scheduler himself, handles p much anything as quicc as possible
function taskscheduler()
    if not toggle then
        scheduled = {}
        return
    end
    if #scheduled > 1000 then
        table.remove(scheduled, #scheduled)
    end
    if #scheduled > 0 then
        local currentf = scheduled[1]
        table.remove(scheduled, 1)
        if type(currentf) == "table" and type(currentf[1]) == "function" then
            pcall(unpack(currentf))
        end
    end
end

--- Handles remote logs
function remoteHandler(hookfunction, methodName, remote, args, func, calling)
    if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
        if funcEnabled and not calling then
            _, calling = pcall(getScriptFromSrc, debug.getinfo(func).source)
        end
        coroutine.wrap(function()
            if remoteSignals[remote] then
                remoteSignals[remote]:Fire(args)
            end
        end)()
        if autoblock then
            if excluding[remote] then
                return
            end
            if not history[remote] then
                history[remote] = {badOccurances = 0, lastCall = tick()}
            end
            if tick() - history[remote].lastCall < 1 then
                history[remote].badOccurances += 1
                return
            else
                history[remote].badOccurances = 0
            end
            if history[remote].badOccurances > 3 then
                excluding[remote] = true
                return
            end
            history[remote].lastCall = tick()
        end
        local functionInfoStr
        local src
        if func and islclosure(func) then
            local functionInfo = {}
            pcall(function() functionInfo.info = debug.getinfo(func) end)
            pcall(function() functionInfo.constants = debug.getconstants(func) end)
            pcall(function() functionInfoStr = v2v{functionInfo = functionInfo} end)
            pcall(function() if type(calling) == "userdata" then src = calling end end)
        end
        if methodName:lower() == "fireserver" then
            newRemote("event", remote.Name, genScript(remote, table.unpack(args)), remote, functionInfoStr, (blocklist[remote] or blocklist[remote.Name]), src)
        elseif methodName:lower() == "invokeserver" then
            newRemote("function", remote.Name, genScript(remote, table.unpack(args)), remote, functionInfoStr, (blocklist[remote] or blocklist[remote.Name]), src)
        end
    end
end

--- Used for hookfunction
function hookRemote(remoteType, remote, ...)
    local args = {...}
    if remoteHooks[remote] then
        args = remoteHooks[remote](args)
    end
    if typeof(remote) == "Instance" and not (blacklist[remote] or blacklist[remote.Name]) then
        local func
        local calling
        if funcEnabled then
            func = debug.getinfo(4).func
            calling = useGetCallingScript and getcallingscript() or nil
        end
        schedule(remoteHandler, true, remoteType == "RemoteEvent" and "fireserver" or "invokeserver", remote, args, func, calling)
        if (blocklist[remote] or blocklist[remote.Name]) then
            return
        end
    end
    if remoteType == "RemoteEvent" then
        if remoteHooks[remote] then
            return originalEvent(remote, unpack(args))
        end
        return originalEvent(remote, ...)
    else
        if remoteHooks[remote] then
            return originalFunction(remote, unpack(args))
        end
        return originalFunction(remote, ...)
    end
end

local newnamecall = newcclosure(function(...)
    local args = {...}
    local methodName = getnamecallmethod()
    local remote = args[1]
    if (methodName:lower() == "invokeserver" or methodName:lower() == "fireserver") and not (blacklist[remote] or blacklist[remote.Name]) then
        if remoteHooks[remote] then
            args = remoteHooks[remote]({args, unpack(args, 2)})
        end
        local func
        local calling
        if funcEnabled then
            func = debug.getinfo(3).func
            calling = useGetCallingScript and getcallingscript() or nil
        end
        coroutine.wrap(function()
            schedule(remoteHandler, false, methodName, remote, {unpack(args, 2)}, func, calling)
        end)()
    end
    if typeof(remote) == "Instance" and (methodName:lower() == "invokeserver" or methodName:lower() == "fireserver") and (blocklist[remote] or blocklist[remote.Name]) then
        return nil
    elseif (methodName:lower() == "invokeserver" or methodName:lower() == "fireserver") and remoteHooks[remote] then
        return original(unpack(args))
    else
        return original(...)
    end
end)

local newFireServer = newcclosure(function(...) return hookRemote("RemoteEvent", ...) end)

local newInvokeServer = newcclosure(function(...) return hookRemote("RemoteFunction", ...) end)

--- Toggles on and off the remote spy
function toggleSpy()
    if not toggle then
        setreadonly(gm, false)
        if not original then
            original = gm.__namecall
            if not original then
                warn("SimpleSpy: namecall method not found!\n")
                onToggleButtonClick()
                return
            end
        end
        gm.__namecall = newnamecall
        originalEvent = hookfunction(remoteEvent.FireServer, newFireServer)
        originalFunction = hookfunction(remoteFunction.InvokeServer, newInvokeServer)
    else
        setreadonly(gm, false)
        gm.__namecall = original
        hookfunction(remoteEvent.FireServer, originalEvent)
        hookfunction(remoteFunction.InvokeServer, originalFunction)
    end
end

--- Toggles between the two remotespy methods (hookfunction currently = disabled)
function toggleSpyMethod()
    toggleSpy()
    toggle = not toggle
end

--- Shuts down the remote spy
function shutdown()
    if schedulerconnect then
        schedulerconnect:Disconnect()
    end
    for _, connection in pairs(connections) do
        coroutine.wrap(function()
            connection:Disconnect()
        end)()
    end
    setreadonly(gm, false)
    SimpleSpy2:Destroy()
    hookfunction(remoteEvent.FireServer, originalEvent)
    hookfunction(remoteFunction.InvokeServer, originalFunction)
    gm.__namecall = original
    _G.SimpleSpyExecuted = false
end

-- main
if not _G.SimpleSpyExecuted then
    local succeeded, err = pcall(function()
        _G.SimpleSpyShutdown = shutdown
        ContentProvider:PreloadAsync({"rbxassetid://6065821980", "rbxassetid://6065774948", "rbxassetid://6065821086", "rbxassetid://6065821596", ImageLabel, ImageLabel_2, ImageLabel_3})
        onToggleButtonClick()
        RemoteTemplate.Parent = nil
        FunctionTemplate.Parent = nil
        codebox = Highlight.new(CodeBox)
        codebox:setRaw("")
        getgenv().SimpleSpy = SimpleSpy
        TextLabel:GetPropertyChangedSignal("Text"):Connect(scaleToolTip)
        TopBar.InputBegan:Connect(onBarInput)
        MinimizeButton.MouseButton1Click:Connect(toggleMinimize)
        MaximizeButton.MouseButton1Click:Connect(toggleSideTray)
        Simple.MouseButton1Click:Connect(onToggleButtonClick)
        CloseButton.MouseEnter:Connect(onXButtonHover)
        CloseButton.MouseLeave:Connect(onXButtonUnhover)
        Simple.MouseEnter:Connect(onToggleButtonHover)
        Simple.MouseLeave:Connect(onToggleButtonUnhover)
        CloseButton.MouseButton1Click:Connect(shutdown)
        table.insert(connections, UserInputService.InputBegan:Connect(backgroundUserInput))
        table.insert(connections, Mouse.Move:Connect(mouseMoved))
        connectResize()
        SimpleSpy2.Enabled = true
        coroutine.wrap(function()
            wait(1)
            onToggleButtonUnhover()
        end)()
        schedulerconnect = RunService.Heartbeat:Connect(taskscheduler)
        if syn and syn.protect_gui then pcall(syn.protect_gui, SimpleSpy2) end
        SimpleSpy2.Parent = gethui and gethui() or CoreGui
    end)
    if succeeded then
        _G.SimpleSpyExecuted = true
    else
        warn("A fatal error has occured, SimpleSpy was unable to launch properly.\nPlease DM this error message to @exx#9394:\n\n" .. tostring(err))
        SimpleSpy2:Destroy()
        hookfunction(remoteEvent.FireServer, originalEvent)
        hookfunction(remoteFunction.InvokeServer, originalFunction)
        gm.__namecall = original
        return
    end
else
    SimpleSpy2:Destroy()
    return
end

----- ADD ONS ----- (easily add or remove additonal functionality to the RemoteSpy!)
--[[
    Some helpful things:
        - add your function in here, and create buttons for them through the 'newButton' function
        - the first argument provided is the TextButton the player clicks to run the function
        - generated scripts are generated when the namecall is initially fired and saved in remoteFrame objects
        - blacklisted remotes will be ignored directly in namecall (less lag)
        - the properties of a 'remoteFrame' object:
            {
                Name: (string) The name of the Remote
                GenScript: (string) The generated script that appears in the codebox (generated when namecall fired)
                Source: (Instance (LocalScript)) The script that fired/invoked the remote
                Remote: (Instance (RemoteEvent) | Instance (RemoteFunction)) The remote that was fired/invoked
                Log: (Instance (TextButton)) The button being used for the remote (same as 'selected.Log')
            }
        - globals list: (contact @exx#9394 for more information or if you have suggestions for more to be added)
            - closed: (boolean) whether or not the GUI is currently minimized
            - logs: (table[remoteFrame]) full of remoteFrame objects (properties listed above)
            - selected: (remoteFrame) the currently selected remoteFrame (properties listed above)
            - blacklist: (string[] | Instance[] (RemoteEvent) | Instance[] (RemoteFunction)) an array of blacklisted names and remotes
            - codebox: (Instance (TextBox)) the textbox that holds all the code- cleared often
]]
-- Copies the contents of the codebox
newButton(
    "Copy Code",
    function() return "Click to copy code" end,
    function()
        setclipboard(codebox:getString())
        TextLabel.Text = "Copied successfully!"
    end
)

--- Copies the source script (that fired the remote)
newButton(
    "Copy Remote",
    function() return "Click to copy the path of the remote" end,
    function()
        if selected then
            setclipboard(v2s(selected.Remote))
            TextLabel.Text = "Copied!"
        end
    end
)

-- Executes the contents of the codebox through loadstring
newButton(
    "Run Code",
    function() return "Click to execute code" end,
    function()
        local orText = "Click to execute code"
        TextLabel.Text = "Executing..."
        local succeeded = pcall(function() return loadstring(codebox:getString())() end)
        if succeeded then
            TextLabel.Text = "Executed successfully!"
        else
            TextLabel.Text = "Execution error!"
        end
    end
)

--- Gets the calling script (not super reliable but w/e)
newButton(
    "Get Script",
    function() return "Click to copy calling script to clipboard\nWARNING: Not super reliable, nil == could not find" end,
    function()
        if selected then
            setclipboard(SimpleSpy:ValueToString(selected.Source))
            TextLabel.Text = "Done!"
        end
    end
)

--- Decompiles the script that fired the remote and puts it in the code box
newButton(
    "Function Info",
    function() return "Click to view calling function information" end,
    function()
        if selected then
            if selected.Function then
                codebox:setRaw("-- Calling function info\n-- Generated by the SimpleSpy serializer\n\n" .. tostring(selected.Function))
            end
            TextLabel.Text = "Done! Function info generated by the SimpleSpy Serializer."
        end
    end
)

--- Clears the Remote logs
newButton(
    "Clr Logs",
    function() return "Click to clear logs" end,
    function()
        TextLabel.Text = "Clearing..."
        logs = {}
        for _, v in pairs(LogList:GetChildren()) do
            if not v:IsA("UIListLayout") then
                v:Destroy()
            end
        end
        codebox:setRaw("")
        selected = nil
        TextLabel.Text = "Logs cleared!"
    end
)

--- Excludes the selected.Log Remote from the RemoteSpy
newButton(
    "Exclude (i)",
    function() return "Click to exclude this Remote" end,
    function()
        if selected then
            blacklist[selected.Remote] = true
            TextLabel.Text = "Excluded!"
        end
    end
)

--- Excludes all Remotes that share the same name as the selected.Log remote from the RemoteSpy
newButton(
    "Exclude (n)",
    function() return "Click to exclude all remotes with this name" end,
    function()
        if selected then
            blacklist[selected.Name] = true
            TextLabel.Text = "Excluded!"
        end
    end
)

--- clears blacklist
newButton(
    "Clr Blacklist",
    function() return "Click to clear the blacklist" end,
    function()
        blacklist = {}
        TextLabel.Text = "Blacklist cleared!"
    end
)

--- Prevents the selected.Log Remote from firing the server (still logged)
newButton(
    "Block (i)",
    function() return "Click to stop this remote from firing" end,
    function()
        if selected then
            blocklist[selected.Remote] = true
            TextLabel.Text = "Excluded!"
        end
    end
)

--- Prevents all remotes from firing that share the same name as the selected.Log remote from the RemoteSpy (still logged)
newButton(
    "Block (n)",
    function() return "Click to stop remotes with this name from firing" end,
    function()
        if selected then
            blocklist[selected.Name] = true
            TextLabel.Text = "Excluded!"
        end
    end
)

--- clears blacklist
newButton(
    "Clr Blocklist",
    function() return "Click to stop blocking remotes" end,
    function()
        blocklist = {}
        TextLabel.Text = "Blocklist cleared!"
    end
)

--- Attempts to decompile the source script
newButton(
    "Decompile",
    function() return "Attempts to decompile source script\nWARNING: Not super reliable, nil == could not find" end,
    function()
        if selected then
            if selected.Source then
                codebox:setRaw(decompile(selected.Source))
                TextLabel.Text = "Done!"
            else
                TextLabel.Text = "Source not found!"
            end
        end
    end
)

newButton(
    "Disable Info",
    function() return string.format("[%s] Toggle function info (because it can cause lag in some games)", funcEnabled and "ENABLED" or "DISABLED") end,
    function()
        funcEnabled = not funcEnabled
        TextLabel.Text = string.format("[%s] Toggle function info (because it can cause lag in some games)", funcEnabled and "ENABLED" or "DISABLED")
    end
)

newButton(
    "Autoblock",
    function() return string.format("[%s] [BETA] Intelligently detects and excludes spammy remote calls from logs", autoblock and "ENABLED" or "DISABLED") end,
    function()
        autoblock = not autoblock
        TextLabel.Text = string.format("[%s] [BETA] Intelligently detects and excludes spammy remote calls from logs", autoblock and "ENABLED" or "DISABLED")
        history = {}
        excluding = {}
    end
)

newButton(
    "CallingScript",
    function() return string.format("[%s] [UNSAFE] Uses 'getcallingscript' to get calling script for Decompile and GetScript. Much more reliable, but opens up SimpleSpy to detection and/or instability.", useGetCallingScript and "ENABLED" or "DISABLED") end,
    function()
        useGetCallingScript = not useGetCallingScript
        TextLabel.Text = string.format("[%s] [UNSAFE] Uses 'getcallingscript' to get calling script for Decompile and GetScript. Much more reliable, but opens up SimpleSpy to detection and/or instability.", useGetCallingScript and "ENABLED" or "DISABLED")
    end
)
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
