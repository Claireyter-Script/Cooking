local redtweeninfo = TweenInfo.new(10)
local redinfo = {Color = Color3.new(0, 0.5, 1)}
----------
for i,v in pairs(workspace.CurrentRooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value):GetDescendants()) do
    if v:IsA("Light") then
        game.TweenService:Create(v, redtweeninfo, redinfo):Play()
    end
end

local plr = game.Players.LocalPlayer
local chr = plr.Character
local TweenService = game:GetService("TweenService")

local dmg = true
local s = game:GetObjects("rbxassetid://121128782273259")[1]
s.Parent = game.Workspace
s.Name = "Abyss"
local entity = s:FindFirstChildWhichIsA("BasePart")
entity.CanCollide = true
entity.Anchored = true
entity.Rush:Destroy()

local att = entity.Attachment
local face = att.Face
face.Brightness = 0
face.Texture = "rbxassetid://135054149040772"
face.LightInfluence = 0.1
face.LightEmission = 0.1
face.Lifetime = NumberRange.new(0.1, 0.8)
face.Rate = 1000
face.Rotation = NumberRange.new(0, 0)
face.Speed = NumberRange.new(0, 5)

local Bubble = att.Bubble
Bubble.Lifetime = NumberRange.new(1, 10)
Bubble.Size = NumberSequence.new(20)
Bubble.Brightness = 20

entity.Rush.PlaybackSpeed = 0.04
entity.Rush.Volume = 5
entity.Rush.MaxDistance = 150

entity.sound.PlaybackSpeed = 0.03
entity.sound.Volume = 5
entity.sound.MaxDistance = 150

entity.Rush:Stop()
entity.sound:Stop()

task.wait(4)
task.spawn(function()
while true do wait(1)
local ray = game.Workspace:Raycast(entity.Position,game.Players.LocalPlayer.Character.HumanoidRootPart.Position - entity.Position)
        if ray.Instance.Parent == game.Players.LocalPlayer.Character or ray.Instance.Parent.Parent == game.Players.LocalPlayer.Character then
        if dmg == true then
        if not chr:GetAttribute("Hiding") then
           game.Players.LocalPlayer.Character.Humanoid.Health -= 5
           game:GetService("ReplicatedStorage").GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Abyss"
        end
        end
        end
end
end)

task.spawn(function()
		while dmg == true do
			task.wait(0.1)
			
			local player = game.Players.LocalPlayer
			local char = player.Character
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			
			if hum and hrp and (hrp.Position - entity.Position).Magnitude <= 10 then
			if not chr:GetAttribute("Hiding") then
	            game.Players.LocalPlayer.Character.Humanoid.Health -= 50
                game:GetService("ReplicatedStorage").GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Abyss"
                
                if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then
                dmg = false
                end
            end
            end
		end
end)

local rooms = workspace.CurrentRooms
local a = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value + 1)
local b = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
local c = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 1)
local d = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value - 2)

entity.CFrame = a.RoomEntrance.CFrame * CFrame.new(0,3,-5)
entity.Rush:Play()
entity.sound:Play()
local to = game.TweenService:Create(entity, TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = b.RoomEntrance.Position + Vector3.new(0, 2, 0)})
          to:Play()
          to.Completed:Wait()
local tso = game.TweenService:Create(entity, TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = c.RoomEntrance.Position + Vector3.new(0, 2, 0)})
          tso:Play()
          tso.Completed:Wait()
local hehe = game.TweenService:Create(entity, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = d.RoomEntrance.Position + Vector3.new(0, 2, 0)})
          hehe:Play()
          hehe.Completed:Wait()
dmg = false
entity.Rush:Stop()
entity.sound:Stop()
entity.Anchored = false
entity.CanCollide = false
local debris = game:GetService("Debris")
debris:AddItem(s, 3)
