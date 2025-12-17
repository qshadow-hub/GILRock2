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

