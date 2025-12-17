<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Executor Script</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .container {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            max-width: 500px;
            width: 100%;
        }

        h1 {
            color: #1e3c72;
            margin-bottom: 30px;
            text-align: center;
            font-size: 28px;
        }

        .input-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            color: #555;
            margin-bottom: 8px;
            font-weight: 600;
        }

        input {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        input:focus {
            outline: none;
            border-color: #2a5298;
        }

        .code-box {
            background: #f5f5f5;
            border: 2px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            margin-top: 20px;
            position: relative;
        }

        .code-box textarea {
            width: 100%;
            height: 300px;
            font-family: 'Courier New', monospace;
            font-size: 13px;
            background: transparent;
            border: none;
            resize: vertical;
            color: #333;
        }

        .code-box textarea:focus {
            outline: none;
        }

        button {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            margin-top: 15px;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }

        button:active {
            transform: translateY(0);
        }

        .copy-btn {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }

        .info {
            background: #e3f2fd;
            padding: 15px;
            border-radius: 8px;
            margin-top: 20px;
            border-left: 4px solid #2196F3;
        }

        .info p {
            color: #1565C0;
            font-size: 14px;
            line-height: 1.6;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 Executor Script Generator</h1>
        
        <div class="input-group">
            <label for="scriptName">Script Name:</label>
            <input type="text" id="Universal Script" placeholder="Universal Script" value="MyScript">
        </div>

        <button onclick="generateScript()">Generate Script</button>

        <div class="code-box" id="codeBox" style="display: none;">
            <textarea id="scriptCode" readonly></textarea>
            <button class="copy-btn" onclick="copyScript()">Copy to Clipboard</button>
        </div>

        <div class="info">
            <p><strong>How to use:</strong> Enter your script name, click Generate, then copy the Lua code and paste it into Xeno Executor or any Roblox executor!</p>
        </div>
    </div>

    <script>
        function generateScript() {
            const scriptName = document.getElementById('Universal Script').value || 'MyScript';
            
            const luaCode = `-- Configuration
local SCRIPT_NAME = "${Universal Script}"

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MaintenanceScreen"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Check if running on CoreGui or PlayerGui
local success = pcall(function()
    screenGui.Parent = game:GetService("CoreGui")
end)

if not success then
    screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

-- Create black background frame
local blackFrame = Instance.new("Frame")
blackFrame.Name = "BlackScreen"
blackFrame.Size = UDim2.new(1, 0, 1, 0)
blackFrame.Position = UDim2.new(0, 0, 0, 0)
blackFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
blackFrame.BorderSizePixel = 0
blackFrame.ZIndex = 10
blackFrame.Parent = screenGui

-- Create warning icon
local warningIcon = Instance.new("TextLabel")
warningIcon.Name = "WarningIcon"
warningIcon.Size = UDim2.new(0, 100, 0, 100)
warningIcon.Position = UDim2.new(0.5, -50, 0.35, -50)
warningIcon.BackgroundTransparency = 1
warningIcon.Text = "⚠"
warningIcon.TextColor3 = Color3.fromRGB(255, 0, 0)
warningIcon.TextSize = 80
warningIcon.Font = Enum.Font.GothamBold
warningIcon.ZIndex = 11
warningIcon.Parent = blackFrame

-- Create main title text
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(0.8, 0, 0, 60)
titleLabel.Position = UDim2.new(0.1, 0, 0.5, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = SCRIPT_NAME .. " is Down"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 48
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextWrapped = true
titleLabel.ZIndex = 11
titleLabel.Parent = blackFrame

-- Create subtitle text
local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Name = "Subtitle"
subtitleLabel.Size = UDim2.new(0.8, 0, 0, 40)
subtitleLabel.Position = UDim2.new(0.1, 0, 0.58, 0)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "Come back later"
subtitleLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
subtitleLabel.TextSize = 32
subtitleLabel.Font = Enum.Font.Gotham
subtitleLabel.ZIndex = 11
subtitleLabel.Parent = blackFrame

-- Create animated loading dots
local dotsFrame = Instance.new("Frame")
dotsFrame.Name = "LoadingDots"
dotsFrame.Size = UDim2.new(0, 100, 0, 20)
dotsFrame.Position = UDim2.new(0.5, -50, 0.7, 0)
dotsFrame.BackgroundTransparency = 1
dotsFrame.ZIndex = 11
dotsFrame.Parent = blackFrame

-- Create 3 dots
for i = 1, 3 do
    local dot = Instance.new("Frame")
    dot.Name = "Dot" .. i
    dot.Size = UDim2.new(0, 12, 0, 12)
    dot.Position = UDim2.new(0, (i - 1) * 35 + 10, 0.5, -6)
    dot.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    dot.BorderSizePixel = 0
    dot.ZIndex = 11
    dot.Parent = dotsFrame
    
    -- Create UICorner for rounded dots
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = dot
    
    -- Animate dot
    spawn(function()
        while wait() do
            for j = 1, 10 do
                dot.BackgroundTransparency = j / 10
                wait(0.05)
            end
            wait((i - 1) * 0.2)
            for j = 10, 1, -1 do
                dot.BackgroundTransparency = j / 10
                wait(0.05)
            end
            wait(0.3)
        end
    end)
end

print(SCRIPT_NAME .. " maintenance screen loaded")`;

            document.getElementById('scriptCode').value = luaCode;
            document.getElementById('codeBox').style.display = 'block';
        }

        function copyScript() {
            const scriptCode = document.getElementById('scriptCode');
            scriptCode.select();
            document.execCommand('copy');
            
            const btn = event.target;
            const originalText = btn.textContent;
            btn.textContent = '✓ Copied!';
            btn.style.background = 'linear-gradient(135deg, #11998e 0%, #38ef7d 100%)';
            
            setTimeout(() => {
                btn.textContent = originalText;
                btn.style.background = 'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)';
            }, 2000);
        }

        // Generate script on page load
        window.onload = function() {
            generateScript();
        };
    </script>
</body>
</html>
