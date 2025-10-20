local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local realAttach

local head = game:GetObjects("rbxassetid://12642335348")[1].Head
head.Parent = workspace
head.Anchored = true
head.CanCollide = false

local latest = game.ReplicatedStorage.GameData.LatestRoom.Value
local room = workspace.CurrentRooms:FindFirstChild(tostring(latest - 1))
if not room then
	room = workspace.CurrentRooms:FindFirstChild(tostring(latest)) or workspace.CurrentRooms:FindFirstChild(tostring(latest + 1))
end
if room and room:FindFirstChild("RoomEntrance") then
	head.CFrame = room.RoomEntrance.CFrame * CFrame.new(0, 0, -10)
end

head.PlaySound.PlaybackSpeed = 0.1
head.PlaySound.Volume = 0.5
head.Footsteps.PlaybackSpeed = 0.1
head.Footsteps.Volume = 0.35
head.Footsteps.MaxDistance = head.PlaySound.MaxDistance

local attachConn
attachConn = RunService.Heartbeat:Connect(function()
	if not head or not head.Parent then
		attachConn:Disconnect()
		return
	end

	local attachments = head:GetChildren()
	local found = {}

	for _, child in ipairs(attachments) do
		if child:IsA("Attachment") then
			table.insert(found, child)
		end
	end

	if #found >= 2 then
		found[1]:Destroy()
		realAttach = found[2]
	elseif #found == 1 then
		realAttach = found[1]
	else
		return
	end

	local emitter = realAttach:FindFirstChild("ParticleEmitter")
	if emitter then
		emitter.Texture = "rbxassetid://101370203499250"
	end

	local trail = realAttach:FindFirstChild("BlackTrail")
	if trail then
		trail.Lifetime = NumberRange.new(0.4, 1)
		trail.Speed = NumberRange.new(6, 8)
		trail.Color = ColorSequence.new(Color3.fromRGB(0, 255, 0))
	end

	local light = realAttach:FindFirstChildOfClass("PointLight")
	if light then
		light.Color = Color3.new(0, 1, 0)
		light.Range = 15
		light.Brightness = 5
	end
end)

local moveSpeed = 6
local killDistance = 10
local canMove = true

local function isPlayerLookingAtHead()
	if not head or not head.Parent then return false end

	local camPos = camera.CFrame.Position
	local headPos = head.Position
	local dir = (headPos - camPos).Unit
	local camLook = camera.CFrame.LookVector
	local dot = camLook:Dot(dir)
	if dot < 0.65 then return false end

	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Blacklist
	rayParams.FilterDescendantsInstances = {player.Character, head}
	rayParams.IgnoreWater = true

	local result = workspace:Raycast(camPos, dir * (headPos - camPos).Magnitude, rayParams)
	if not result or (result.Instance and result.Instance:IsDescendantOf(head)) then
		return true
	end
	return false
end

local moveConn
moveConn = RunService.Heartbeat:Connect(function(dt)
	if not head or not head.Parent then
		moveConn:Disconnect()
		return
	end

	if not player.Character then return end
	local humanoidRoot = player.Character:FindFirstChild("HumanoidRootPart")
	local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
	if not humanoidRoot or not humanoid then return end

	local dist = (head.Position - humanoidRoot.Position).Magnitude
	local looking = isPlayerLookingAtHead()
	canMove = not looking

	if canMove then
		local dir = (humanoidRoot.Position - head.Position).Unit
		local newPos = head.Position + dir * moveSpeed * dt
		head.CFrame = CFrame.new(newPos, humanoidRoot.Position)
		if not head.PlaySound.IsPlaying then head.PlaySound:Resume() end
	else
		if head.PlaySound.IsPlaying then head.PlaySound:Pause() end
	end

	if not looking and dist <= killDistance and humanoid.Health > 0 then
		humanoid.Health = 0
		local stats = game:GetService("ReplicatedStorage"):FindFirstChild("GameStats")
		if stats then
			local stat = stats:FindFirstChild("Player_" .. player.Name)
			if stat and stat:FindFirstChild("Total") and stat.Total:FindFirstChild("DeathCause") then
				stat.Total.DeathCause.Value = "The Follow"
			end
		end
	end
end)

task.delay(60, function()
	if head and head.Parent then
		pcall(function()
			head.Footsteps:Stop()
			head.PlaySound:Stop()
		end)
		if attachConn then attachConn:Disconnect() end
		if moveConn then moveConn:Disconnect() end
		Debris:AddItem(head, 0.1)
	end
end)
