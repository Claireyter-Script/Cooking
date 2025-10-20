local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local Color = Instance.new("ColorCorrectionEffect", game.Lighting)

TweenService:Create(Color, TweenInfo.new(5), {
    TintColor = Color3.fromRGB(85, 85, 255),
}):Play()

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://84864462000645"
sound.Parent = Workspace
sound.Volume = 0.8
sound.Pitch = 1
sound:Play()
game.Debris:AddItem(sound, sound.TimeLength) 

local sound2 = Instance.new("Sound")
sound2.SoundId = "rbxassetid://9125713295"
sound2.Parent = Workspace
sound2.Volume = 1
sound2:Play()
game.Debris:AddItem(sound2, sound2.TimeLength) 

local entity = game:GetObjects("rbxassetid://121128782273259")[1]:FindFirstChildWhichIsA("BasePart")
entity.Parent = game.Workspace
entity.CanCollide = true
entity.Anchored = true
entity.Rush:Destroy()
entity:WaitForChild("Glow purple"):Destroy()
entity.GlitchEffect.Size = NumberSequence.new(15)

local att = entity.Attachment
att.Black:Destroy()
local face = att.Face
face.Brightness = 0
face.Texture = "rbxassetid://71702698503328"
face.LightInfluence = 0.3
face.LightEmission = 0.1
face.Lifetime = NumberRange.new(0.5, 0.8)
face.Rate = 10
face.Rotation = NumberRange.new(0, 0)
face.Speed = NumberRange.new(0, 5)
face.Orientation = Enum.ParticleOrientation.FacingCameraWorldUp

local Bubble = att.Bubble
Bubble.Lifetime = NumberRange.new(1, 1)
Bubble.Size = NumberSequence.new(20)
Bubble.Brightness = 20
Bubble.RotSpeed = NumberRange.new(999999999, 999999999)
Bubble.Speed = NumberRange.new(0, 1)
Bubble.Orientation = Enum.ParticleOrientation.FacingCamera

entity.Rush.PlaybackSpeed = 0.05
entity.Rush.Volume = 5
entity.Rush.MaxDistance = 350

entity.sound.PlaybackSpeed = 0.03
entity.sound.Volume = 6
entity.sound.MaxDistance = 350

entity.CFrame = Workspace.CurrentRooms:FindFirstChild(ReplicatedStorage.GameData.LatestRoom.Value)
             :FindFirstChild(ReplicatedStorage.GameData.LatestRoom.Value).CFrame * CFrame.new(0,5,0)

local dmg = true

task.spawn(function()
wait(2)
while dmg do wait(1)
if not dmg then break end
for _, player in ipairs(game.Players:GetPlayers()) do
			local char = player.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			local hum = char and char:FindFirstChildOfClass("Humanoid")

			if hrp and hum then
				local distance = (hrp.Position - entity.Position).Magnitude
				if distance <= 40 and not char:GetAttribute("Hiding") then
					hum:TakeDamage(5)
					ReplicatedStorage.GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Fr0st3r"					
				end
			end
end
end
end)

game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
dmg = false
local ah = TweenService:Create(Color, TweenInfo.new(5), {
    TintColor = Color3.fromRGB(255, 255, 255),
})

TweenService:Create(entity.Rush, TweenInfo.new(5), { PlaybackSpeed = 0 }):Play()
TweenService:Create(entity.sound, TweenInfo.new(5), { PlaybackSpeed = 0 }):Play()

ah:Play()
ah.Completed:Wait()
Color:Destroy()
entity:Destroy()
