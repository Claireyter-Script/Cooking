local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local stop = false

-- Hiệu ứng ánh sáng
local SmileColor = Instance.new("ColorCorrectionEffect", game.Lighting)
game.Debris:AddItem(SmileColor, 12)
SmileColor.TintColor = Color3.fromRGB(0, 0, 0)
SmileColor.Saturation = -0.7
SmileColor.Contrast = 0.2

TweenService:Create(SmileColor, TweenInfo.new(3), {
	TintColor = Color3.fromRGB(255, 255, 255),
	Saturation = 0,
	Contrast = 0
}):Play()

local damage1 = Instance.new("Sound")
damage1.SoundId = "rbxassetid://5507830449"
damage1.Pitch = 1.2
damage1.Volume = 2
local damage2 = Instance.new("Sound")
damage2.SoundId = "rbxassetid://5507830815"
damage2.Pitch = 1.2
damage2.Volume = 2
local damage3 = Instance.new("Sound")
damage3.SoundId = "rbxassetid://5507829691"
damage3.Pitch = 1.2
damage3.Volume = 2

-- Eyes model
local eyes = game:GetObjects("rbxassetid://121121926426152")[1].Core
eyes.Parent = workspace.CurrentRooms
eyes.Name = "Darkness Eye"
eyes.CFrame = workspace.CurrentRooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
	:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value).CFrame * CFrame.new(0,7,0)
	
eyes.BillboardGui:Destroy()
eyes.Initiate:Play()
eyes.Initiate.PlaybackSpeed = 0.1
eyes.Initiate.Volume = 10
eyes.Ambience:Play()
eyes.Ambience.PlaybackSpeed = 0.09
eyes.Ambience.Volume = 5
eyes.Attachment.Bite:Destroy()
eyes.Attachment.Visible = false

damage1.Parent = playerGui
damage2.Parent = playerGui
damage3.Parent = playerGui

local dmgsound = {damage1, damage2, damage3}

eyes.Attachment.Angry.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0))
eyes.Attachment.Spark.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0))
eyes.Attachment.Angry.Size = NumberSequence.new(8)
eyes.Attachment.Spark.Size = NumberSequence.new(10)

eyes.Attachment.Eyes.Texture = "rbxassetid://135837607805571"
eyes.Attachment.Eyes.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
eyes.Attachment.Eyes.Brightness = 5
eyes.Attachment.Eyes.LightInfluence = 0.2
eyes.Attachment.Eyes.Rate = 100
eyes.Attachment.Eyes.Rotation = NumberRange.new(-10, 10)
eyes.Attachment.Eyes.RotSpeed = NumberRange.new(-15, 15)
eyes.Attachment.Eyes.Speed = NumberRange.new(0, 1)

for _, obj in ipairs(eyes:GetChildren()) do
	if obj:IsA("PointLight") then
		obj:Destroy()
	end
end

local function dmg()
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.Health -= 7
		game:GetService("ReplicatedStorage").GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "The Guardian"
	end

	local dmg = Instance.new("ColorCorrectionEffect", game.Lighting)
	dmg.TintColor = Color3.fromRGB(255, 0, 0)
	dmg.Saturation = -1
	dmg.Contrast = 0.5

	local endmg = TweenService:Create(dmg, TweenInfo.new(3), {
		TintColor = Color3.fromRGB(255, 255, 255),
		Saturation = 0,
		Contrast = 0
	})
	endmg:Play()
	endmg.Completed:Wait()
	game.Debris:AddItem(dmg, 0.1)
end

wait(1)
task.spawn(function()
	while true do
		wait(2)
		local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if not humanoid then break end
		if stop or humanoid.Health <= 0 then break end
		dmgsound[math.random(1, #dmgsound)]:Play()
		dmg()
	end
end)

game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()
stop = true
eyes.Attachment.Eyes.Enabled = false
damage1:Destroy()
damage2:Destroy()
damage3:Destroy()
wait(2)
eyes:Destroy()
end)
