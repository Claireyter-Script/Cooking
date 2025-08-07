local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRoot = character:WaitForChild("HumanoidRootPart")

-- Tải mô hình và xoá Part đầu tiên
local model = game:GetObjects("rbxassetid://12672410595")[1]
model.Parent = workspace

local remainingPart = model:FindFirstChildWhichIsA("BasePart")

-- Đặt Part vào giữa phòng hiện tại
local room = workspace.CurrentRooms[ReplicatedStorage.GameData.LatestRoom.Value]
local nodes = room:FindFirstChild("Nodes")
local pos = (nodes and nodes:GetChildren()[math.floor(#nodes:GetChildren()/2)]) or room:FindFirstChild(room.Name)

if remainingPart and pos then
	remainingPart.CFrame = pos.CFrame + Vector3.new(0, 8, 0)
	remainingPart.CanCollide = false
end

-- Hút người chơi từ từ
local pullSpeed = 9 -- điều chỉnh lực hút chậm/mạnh hơn

RunService.Heartbeat:Connect(function(dt)
	if not remainingPart or not remainingPart:IsDescendantOf(workspace) or character:GetAttribute("Hiding") then return end
		local dir = (remainingPart.Position - humanoidRoot.Position)
		local dist = dir.Magnitude

		if dist > 2 then
			-- Hút người lại gần
			local pull = dir.Unit * pullSpeed * dt
			humanoidRoot.CFrame = humanoidRoot.CFrame + pull
		end

		-- Nếu chạm vào Part thì TOANG
		if dist <= (remainingPart.Size.Magnitude / 2 + 2) then
			local hum = character:FindFirstChildOfClass("Humanoid")
			if hum and hum.Health > 0 then
				hum:TakeDamage(9999)
				game:GetService("ReplicatedStorage").GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Distort"
			end
		end
end)

local att = remainingPart.SoundPart.Attachment
local eff = att:WaitForChild("Background [Optional]")
local hole = att:WaitForChild("Entity ")

eff.Brightness = 0
eff.Lifetime = NumberRange.new(0.2, 0.5)
eff.Rate = 1000
eff.Rotation = NumberRange.new(-360, 360)
eff.RotSpeed = NumberRange.new(999999, 999999)
eff.Speed = NumberRange.new(2, 5)

hole.Brightness = 0.3
hole.Lifetime = NumberRange.new(1, 1)
hole.Rate = 15
hole.Rotation = NumberRange.new(-1, 1)
hole.RotSpeed = NumberRange.new(-5, 500)
hole.Speed = NumberRange.new(2, 2)

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://9056932358"
sound.Looped = true
sound.PlaybackSpeed = 0.7
sound.Pitch = 1
sound.Volume = 2
sound.MaxDistance = 500
sound.Parent = remainingPart.SoundPart
sound:Play()

spawn(function()
	game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
	model:Destroy()
	remainingPart = nil
end)
