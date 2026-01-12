-- Wave a brainrot | New Year GUI
-- PC only | Open with E

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "WaveABrainrotGUI"
gui.ResetOnSpawn = false
gui.Enabled = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.35, 0.45)
main.Position = UDim2.fromScale(0.325, 0.275)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
main.BorderSizePixel = 0
main.AnchorPoint = Vector2.new(0,0)

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 20, 0, 10)
title.Text = "❄️ Wave a brainrot ❄️"
title.TextColor3 = Color3.fromRGB(230, 240, 255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.BackgroundTransparency = 1

-- Close button
local close = Instance.new("TextButton", main)
close.Size = UDim2.fromOffset(30, 30)
close.Position = UDim2.new(1, -35, 0, 10)
close.Text = "✕"
close.TextScaled = true
close.Font = Enum.Font.GothamBold
close.TextColor3 = Color3.fromRGB(255, 120, 120)
close.BackgroundTransparency = 1

close.MouseButton1Click:Connect(function()
 gui.Enabled = false
end)

-- Tabs
local tabFrame = Instance.new("Frame", main)
tabFrame.Size = UDim2.new(1, -40, 0, 40)
tabFrame.Position = UDim2.new(0, 20, 0, 60)
tabFrame.BackgroundTransparency = 1

local function makeTab(text, x)
 local b = Instance.new("TextButton", tabFrame)
 b.Size = UDim2.new(0.5, -5, 1, 0)
 b.Position = UDim2.new(x, 0, 0, 0)
 b.Text = text
 b.Font = Enum.Font.GothamBold
 b.TextScaled = true
 b.TextColor3 = Color3.fromRGB(200, 220, 255)
 b.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
 Instance.new("UICorner", b).CornerRadius = UDim.new(0, 12)
 return b
end

local tpTab = makeTab("Teleport", 0)
local crTab = makeTab("Creator", 0.5)

-- Pages
local pages = Instance.new("Frame", main)
pages.Size = UDim2.new(1, -40, 1, -120)
pages.Position = UDim2.new(0, 20, 0, 110)
pages.BackgroundTransparency = 1

local teleportPage = Instance.new("Frame", pages)
teleportPage.Size = UDim2.fromScale(1,1)
teleportPage.BackgroundTransparency = 1

local creatorPage = Instance.new("Frame", pages)
creatorPage.Size = UDim2.fromScale(1,1)
creatorPage.BackgroundTransparency = 1
creatorPage.Visible = false

local function switch(page)
 teleportPage.Visible = false
 creatorPage.Visible = false
 page.Visible = true
end

tpTab.MouseButton1Click:Connect(function()
 switch(teleportPage)
end)

crTab.MouseButton1Click:Connect(function()
 switch(creatorPage)
end)

-- Teleport buttons
local function tpButton(text, y, cf)
 local b = Instance.new("TextButton", teleportPage)
 b.Size = UDim2.new(1, 0, 0, 45)
 b.Position = UDim2.new(0, 0, 0, y)
 b.Text = text
 b.Font = Enum.Font.GothamBold
 b.TextScaled = true
 b.TextColor3 = Color3.fromRGB(240, 240, 255)
 b.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
 Instance.new("UICorner", b).CornerRadius = UDim.new(0, 12)

 b.MouseButton1Click:Connect(function()
  local char = player.Character
  if char and char:FindFirstChild("HumanoidRootPart") then
   char.HumanoidRootPart.CFrame = cf
  end
 end)
end

tpButton("Lobby", 0, CFrame.new(
 148.065033, 7.52932262, 0,
 0.90629667, -0.422642082, 0,
 0.422642082, 0.90629667, 0,
 0, 0, 1
))

tpButton("Celestial", 55, CFrame.new(
 2607.5, -9.02498817, 0,
 0, 0, 1,
 -1, 0, 0,
 0, -1, 0
))

-- Immortality (simple anti-tsunami)
local function makeImmortal(char)
 local hum = char:WaitForChild("Humanoid")
 hum.MaxHealth = math.huge
 hum.Health = math.huge
 hum:GetPropertyChangedSignal("Health"):Connect(function()
  if hum.Health < hum.MaxHealth then
   hum.Health = hum.MaxHealth
  end
 end)
end

if player.Character then
 makeImmortal(player.Character)
end
player.CharacterAdded:Connect(makeImmortal)

-- Creator page
local creatorLabel = Instance.new("TextLabel", creatorPage)
creatorLabel.Size = UDim2.fromScale(1,1)
creatorLabel.Text = "Creator:\nBrayserX"
creatorLabel.Font = Enum.Font.GothamBold
creatorLabel.TextScaled = true
creatorLabel.TextColor3 = Color3.fromRGB(200, 255, 200)
creatorLabel.BackgroundTransparency = 1

-- Snow effect
for i = 1, 35 do
 local snow = Instance.new("Frame", main)
 snow.Size = UDim2.fromOffset(6,6)
 snow.BackgroundColor3 = Color3.fromRGB(255,255,255)
 snow.BackgroundTransparency = 0.2
 Instance.new("UICorner", snow).CornerRadius = UDim.new(1,0)

 snow.Position = UDim2.fromScale(math.random(), -0.1)

 task.spawn(function()
  while true do
   snow.Position = UDim2.fromScale(math.random(), -0.1)
   local t = 0
   while t < 1 do
    t += RunService.RenderStepped:Wait() * 0.1
    snow.Position += UDim2.fromScale(0, 0.005)
   end
  end
 end)
end

-- Keybind E
UIS.InputBegan:Connect(function(input, gpe)
 if gpe then return end
 if input.KeyCode == Enum.KeyCode.E then
  gui.Enabled = not gui.Enabled
 end
end)

-- === OPEN BUTTON (ALWAYS VISIBLE) ===

local openButton = Instance.new("TextButton")
openButton.Parent = gui
openButton.Size = UDim2.fromOffset(80, 40)
openButton.Position = UDim2.new(0, 10, 0.5, -20)
openButton.Text = "OPEN"
openButton.Font = Enum.Font.GothamBold
openButton.TextScaled = true
openButton.BackgroundColor3 = Color3.fromRGB(60, 90, 140)
openButton.TextColor3 = Color3.fromRGB(240, 240, 255)
openButton.ZIndex = 100

Instance.new("UICorner", openButton).CornerRadius = UDim.new(0, 12)

openButton.MouseButton1Click:Connect(function()
 main.Visible = not main.Visible
end)

-- === HOTKEY TELEPORTS ===

local lobbyCF = CFrame.new(
 148.065033, 7.52932262, 0,
 0.90629667, -0.422642082, 0,
 0.422642082, 0.90629667, 0,
 0, 0, 1
)

local celestialCF = CFrame.new(
 2607.5, -9.02498817, 0,
 0, 0, 1,
 -1, 0, 0,
 0, -1, 0
)

UIS.InputBegan:Connect(function(input, gpe)
 if gpe then return end

 local char = player.Character
 local hrp = char and char:FindFirstChild("HumanoidRootPart")
 if not hrp then return end

 if input.KeyCode == Enum.KeyCode.Q then
  hrp.CFrame = lobbyCF
 elseif input.KeyCode == Enum.KeyCode.F then
  hrp.CFrame = celestialCF
 end
end)
