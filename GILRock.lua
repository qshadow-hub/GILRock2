----------------------------------------------------------------
-- CHARACTER TAB
----------------------------------------------------------------
local CharacterTab = Window:CreateTab("Character", nil)
CharacterTab:CreateSection("Character")

-- Tabel cu numele butoanelor și callback-urile lor
local characterButtons = {
    {
        Name = "Noclip",
        Callback = function()
            -- Codul Noclip pe care l-ai pus deja
            local Workspace = game:GetService("Workspace")
            local Players = game:GetService("Players")
            local Plr = Players.LocalPlayer
            local Clipon = false
            -- Creează GUI-ul Noclip
            local Noclip = Instance.new("ScreenGui")
            local BG = Instance.new("Frame")
            local Title = Instance.new("TextLabel")
            local Toggle = Instance.new("TextButton")
            local StatusPF = Instance.new("TextLabel")
            local Status = Instance.new("TextLabel")

            Noclip.Name = "Noclip"
            Noclip.Parent = game.CoreGui

            BG.Name = "BG"
            BG.Parent = Noclip
            BG.BackgroundColor3 = Color3.new(0.098, 0.098, 0.098)
            BG.BorderColor3 = Color3.new(0.058,0.058,0.058)
            BG.BorderSizePixel = 2
            BG.Position = UDim2.new(0.15,0,0.82,0)
            BG.Size = UDim2.new(0,210,0,127)
            BG.Active = true
            BG.Draggable = true

            Title.Name = "Title"
            Title.Parent = BG
            Title.BackgroundColor3 = Color3.new(0.267,0.0039,0.627)
            Title.BorderColor3 = Color3.new(0.18,0,0.431)
            Title.BorderSizePixel = 2
            Title.Size = UDim2.new(0,210,0,33)
            Title.Font = Enum.Font.Highway
            Title.Text = "Noclip"
            Title.TextColor3 = Color3.new(1,1,1)
            Title.TextSize = 30

            Toggle.Parent = BG
            Toggle.BackgroundColor3 = Color3.new(0.267,0.0039,0.627)
            Toggle.BorderColor3 = Color3.new(0.18,0,0.431)
            Toggle.BorderSizePixel = 2
            Toggle.Position = UDim2.new(0.15,0,0.37,0)
            Toggle.Size = UDim2.new(0,146,0,36)
            Toggle.Font = Enum.Font.Highway
            Toggle.Text = "Toggle"
            Toggle.TextColor3 = Color3.new(1,1,1)
            Toggle.TextSize = 25

            StatusPF.Name = "StatusPF"
            StatusPF.Parent = BG
            StatusPF.BackgroundTransparency = 1
            StatusPF.Position = UDim2.new(0.31,0,0.7,0)
            StatusPF.Size = UDim2.new(0,56,0,20)
            StatusPF.Font = Enum.Font.Highway
            StatusPF.Text = "Status:"
            StatusPF.TextColor3 = Color3.new(1,1,1)
            StatusPF.TextSize = 20

            Status.Name = "Status"
            Status.Parent = BG
            Status.BackgroundTransparency = 1
            Status.Position = UDim2.new(0.58,0,0.7,0)
            Status.Size = UDim2.new(0,56,0,20)
            Status.Font = Enum.Font.Highway
            Status.Text = "off"
            Status.TextColor3 = Color3.new(0.666,0,0)
            Status.TextSize = 14

            local Stepped
            Toggle.MouseButton1Click:Connect(function()
                if Status.Text == "off" then
                    Clipon = true
                    Status.Text = "on"
                    Status.TextColor3 = Color3.new(0,185/255,0)
                    Stepped = game:GetService("RunService").Stepped:Connect(function()
                        if Clipon then
                            for _, part in pairs(Plr.Character:GetChildren()) do
                                if part:IsA("BasePart") then
                                    part.CanCollide = false
                                end
                            end
                        else
                            if Stepped then Stepped:Disconnect() end
                        end
                    end)
                else
                    Clipon = false
                    Status.Text = "off"
                    Status.TextColor3 = Color3.new(170/255,0,0)
                end
            end)
            print("Noclip pressed")
        end
    },
    {Name = "WalkSpeed", Callback = function() print("WalkSpeed pressed") end},
    {Name = "Tracers/ESP", Callback = function() print("Tracers/ESP pressed") end},
    {Name = "InfiniteJump", Callback = function() print("InfiniteJump pressed") end},
    {Name = "Fly", Callback = function() print("Fly pressed") end},
    {Name = "SpeedBoost", Callback = function() print("SpeedBoost pressed") end},
    {Name = "JumpBoost", Callback = function() print("JumpBoost pressed") end},
}

-- Creează toate butoanele
for _, btn in ipairs(characterButtons) do
    CharacterTab:CreateButton({
        Name = btn.Name,
        Callback = btn.Callback
    })
end
