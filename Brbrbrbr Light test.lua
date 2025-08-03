local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local head = character:WaitForChild("Head")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LightToggleGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 130, 0, 80)
button.Position = UDim2.new(1, -70, 0, 60)
button.AnchorPoint = Vector2.new(1, 0)
button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
button.TextColor3 = Color3.new(1, 1, 1)
button.TextScaled = true
button.Font = Enum.Font.SciFi
button.Text = "Turn Off"
button.Parent = screenGui

local light = Instance.new("PointLight")
light.Color = Color3.fromRGB(255, 255, 200)
light.Brightness = 1.5
light.Range = 15
light.Parent = head
light.Enabled = false

button.MouseButton1Click:Connect(function()
	if button.Text == "Turn Off" then
		button.Text = "Turn On"
		button.BackgroundColor3 = Color3.fromRGB(200, 100, 50)
		light.Enabled = true
	else
		button.Text = "Turn Off"
		button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
		light.Enabled = false
	end
end)
