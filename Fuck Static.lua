local rooms = workspace.CurrentRooms
local fuck = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModuleEvents = require(ReplicatedStorage.ClientModules.Module_Events)

ModuleEvents.flicker(fuck, 6)
wait(5)
local RunService = game:GetService("RunService")
local Rep = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local hrp = chr:WaitForChild("HumanoidRootPart")
local hum = chr:WaitForChild("Humanoid")

-- Spawn model
local model = game:GetObjects("rbxassetid://117119524773038")[1]:WaitForChild("OOGA BOOGAAAA")
model.Parent = workspace
model.CanCollide = false
if model:FindFirstChild("GlitchEffect") then
	model.GlitchEffect:Destroy()
end

-- Hiệu ứng
local att = model:WaitForChild("Attachment")
local Bolts = att:WaitForChild("Bolts")
local face = att:WaitForChild("ParticleEmitter")
if att:FindFirstChild("BlackTrail") then
	att.BlackTrail.Enabled = false
end

Bolts.Brightness = 10
Bolts.Rate = 25
Bolts.Lifetime = NumberRange.new(0.3, 0.3)
Bolts.RotSpeed = NumberRange.new(0, 3600)
Bolts.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.new(0, 1, 0)),
	ColorSequenceKeypoint.new(0.25, Color3.new(1, 0, 0)),
	ColorSequenceKeypoint.new(0.5, Color3.new(0, 1, 0)),
	ColorSequenceKeypoint.new(0.75, Color3.new(1, 0, 0)),
	ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
})

face.Texture = "rbxassetid://88131525372744"
face.Rate = 1500
face.Lifetime = NumberRange.new(0.5, 1)
face.Rotation = NumberRange.new(0, 0)
face.RotSpeed = NumberRange.new(0, 0)
face.Speed = NumberRange.new(0, 1)
face.LightEmission = 0
face.Brightness = 0.5
face.Size = NumberSequence.new(4)
face.Color = Bolts.Color

-- Spawn room
local rooms = workspace.CurrentRooms
local latest = Rep.GameData.LatestRoom.Value
local spawnRoom = rooms:FindFirstChild(latest + 1)
if spawnRoom and spawnRoom:FindFirstChild("RoomEntrance") then
	model.CFrame = spawnRoom.RoomEntrance.CFrame * CFrame.new(0, 2, -5)
end

-- Patrol path: phòng hiện tại → -1 → -2
local patrolTargets = {}
for i = latest, latest - 2, -1 do
	local r = rooms:FindFirstChild(i)
	if r then
		-- Thêm Floor
		if r:FindFirstChild("Parts") and r.Parts:FindFirstChild("Floor") then
			table.insert(patrolTargets, r.Parts.Floor.CFrame.Position + Vector3.new(0, 3, 0))
		end
		-- Thêm RoomEntrance
		if r:FindFirstChild("RoomEntrance") then
			table.insert(patrolTargets, r.RoomEntrance.Position + Vector3.new(0, 3, 0))
		end
	end
end

local speed = 12
local detectRange = 55
local chasing = false
local targetPos = patrolTargets[1]
local patrolIndex = 1
local savedPatrolIndex = patrolIndex

-- Hàm quay lại tuần tra
local function returnToPatrol()
	chasing = false
	-- Quay lại điểm patrol cũ hoặc sang điểm kế tiếp để tránh đứng yên
	patrolIndex = math.max(1, savedPatrolIndex)
	if patrolTargets[patrolIndex] then
		targetPos = patrolTargets[patrolIndex]
	else
		patrolIndex = 1
		targetPos = patrolTargets[1]
	end
end

-- Hàm gây sát thương
local function dealDamage()
	if model and model.Parent then
		hum:TakeDamage(10)
		game:GetService("ReplicatedStorage").GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "The Static"
		model:Destroy()
	end
end

-- Main loop
local conn
conn = RunService.Heartbeat:Connect(function(dt)
	if not model or not model.Parent then
		conn:Disconnect()
		return
	end

	-- Nếu đang chase
	if chasing then
		-- Player Hiding → quay về tuần tra
		if chr:GetAttribute("Hiding") then
			returnToPatrol()
		else
			-- Di chuyển về player
			targetPos = hrp.Position
			local dir = targetPos - model.Position
			if dir.Magnitude > 2 then
				model.CFrame = model.CFrame + dir.Unit * (speed * 1.5) * dt
			else
				dealDamage()
				return
			end
		end
	end

	-- Nếu không chasing → tuần tra bình thường
	if not chasing and targetPos then
		local dir = targetPos - model.Position
		if dir.Magnitude > 1 then
			model.CFrame = model.CFrame + dir.Unit * speed * dt
		else
			patrolIndex += 1
			if patrolTargets[patrolIndex] then
				targetPos = patrolTargets[patrolIndex]
			else
				model:Destroy()
				return
			end
		end
	end

	-- Kiểm tra chase player nếu không đang chase
	if not chasing then
		local distance = (hrp.Position - model.Position).Magnitude
		if distance <= detectRange then
			local rayParams = RaycastParams.new()
			rayParams.FilterDescendantsInstances = {model}
			rayParams.FilterType = Enum.RaycastFilterType.Blacklist
			local rayResult = workspace:Raycast(model.Position, (hrp.Position - model.Position).Unit * distance, rayParams)
			if not rayResult or rayResult.Instance:IsDescendantOf(chr) then
				savedPatrolIndex = patrolIndex
				chasing = true
			end
		end
	end
end)
