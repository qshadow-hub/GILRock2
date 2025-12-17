-- CONFIG
local SCRIPT_NAME = "Universal Script" -- change this

-- Cleanup if already exists
pcall(function()
    game.CoreGui.ScriptDownGui:Destroy()
end)

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ScriptDownGui"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

-- Black screen
local frame = Instance.new("Frame")
frame.Size = UDim2.new(1, 0, 1, 0)
frame.Position = UDim2.new(0, 0, 0, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 0
frame.Parent = gui

-- Text
local text = Instance.new("TextLabel")
text.Size = UDim2.new(1, 0, 0.2, 0)
text.Position = UDim2.new(0, 0, 0.4, 0)
text.BackgroundTransparency = 1
text.Text = SCRIPT_NAME .. " is down\nCome back later"
text.TextColor3 = Color3.fromRGB(255, 255, 255)
text.Font = Enum.Font.GothamBold
text.TextScaled = true
text.Parent = frame

-- Optional: Freeze player
pcall(function()
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 0
        player.Character.Humanoid.JumpPower = 0
    end
end)
