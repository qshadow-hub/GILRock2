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

-- Place this in a LocalScript inside your dropdown button/GUI element

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Reference to your GUI elements (adjust paths as needed)
local dropdownButton = script.Parent -- The button that opens the dropdown
local dropdownFrame = dropdownButton.Parent:WaitForChild("DropdownFrame") -- Container for player list
local playerListFrame = dropdownFrame:WaitForChild("PlayerList") -- ScrollingFrame or Frame for buttons

local selectedPlayer = nil
local isDropdownOpen = false

-- Function to update the player list
local function updatePlayerList()
	-- Clear existing buttons
	for _, child in pairs(playerListFrame:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end
	
	-- Create a button for each player
	local yOffset = 0
	for _, plr in pairs(Players:GetPlayers()) do
		local playerButton = Instance.new("TextButton")
		playerButton.Name = plr.Name
		playerButton.Size = UDim2.new(1, 0, 0, 30)
		playerButton.Position = UDim2.new(0, 0, 0, yOffset)
		playerButton.Text = plr.Name
		playerButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		playerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		playerButton.Font = Enum.Font.SourceSans
		playerButton.TextSize = 18
		playerButton.Parent = playerListFrame
		
		-- When a player is clicked
		playerButton.MouseButton1Click:Connect(function()
			selectedPlayer = plr
			dropdownButton.Text = plr.Name -- Update dropdown button text
			dropdownFrame.Visible = false
			isDropdownOpen = false
			print("Selected player:", plr.Name)
			
			-- You can fire a RemoteEvent here to send selection to server
			-- game.ReplicatedStorage.PlayerSelected:FireServer(plr)
		end)
		
		yOffset = yOffset + 35
	end
	
	-- Update the scrolling frame canvas size
	if playerListFrame:IsA("ScrollingFrame") then
		playerListFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
	end
end

-- Toggle dropdown visibility
dropdownButton.MouseButton1Click:Connect(function()
	isDropdownOpen = not isDropdownOpen
	dropdownFrame.Visible = isDropdownOpen
	
	if isDropdownOpen then
		updatePlayerList()
	end
end)

-- Update list when players join or leave
Players.PlayerAdded:Connect(function()
	if isDropdownOpen then
		updatePlayerList()
	end
end)

Players.PlayerRemoving:Connect(function()
	if isDropdownOpen then
		updatePlayerList()
	end
end)

-- Initial setup
dropdownFrame.Visible = false
updatePlayerList()

local TeleportTab = Window:CreateTab("ESP", nil)
local TeleportSection = TeleportTab:CreateSection("ESP")

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
