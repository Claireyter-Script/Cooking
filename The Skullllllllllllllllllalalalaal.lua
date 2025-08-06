local rep = game:GetService("ReplicatedStorage")
local debris = game:GetService("Debris")
local rs = game:GetService("RunService")
local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local hum = chr:WaitForChild("Humanoid")
local root = chr:WaitForChild("HumanoidRootPart")

-- Tạo Head
local head = game:GetObjects("rbxassetid://12642335348")[1].Head
head.Parent = workspace
head.Anchored = true
head.CanCollide = false
head.PlaySound:Stop()

-- Lấy phòng hiện tại và kế tiếp
local index = rep.GameData.LatestRoom.Value
local rooms = workspace.CurrentRooms
local roomNow = rooms:FindFirstChild(index)
local roomNext = rooms:FindFirstChild(index + 1)
if not roomNow or not roomNext then return end

-- Vị trí bắt đầu và mục tiêu
local startPos = roomNext.RoomEntrance.Position + Vector3.new(0, 0, -30)
local targetPos = roomNow.RoomEntrance.Position
head.Position = startPos
task.wait(3)

-- Di chuyển bình thường
local speed = 10
local moving
local rushing = false
local returning = false

head.PlaySound:Play()

local function moveTo(pos, spd, onReached)
	local conn
	conn = rs.Heartbeat:Connect(function(dt)
		if not head or not head.Parent then conn:Disconnect() return end
		local dir = pos - head.Position
		if dir.Magnitude > 1 then
			head.CFrame = head.CFrame + dir.Unit * spd * dt
		else
			conn:Disconnect()
			if onReached then onReached() end
		end
	end)
	return conn
end

-- Di chuyển ban đầu đến RoomEntrance
moving = moveTo(targetPos, speed, function()
	head.Anchored = false
	head.Velocity = Vector3.new(0, -100, 0)
	debris:AddItem(head, 2)
end)

-- Cơ chế Rush + Cancel nếu Hiding
task.spawn(function()
	while head and head.Parent do
		task.wait(0.2)
		if rushing or returning then continue end

		local ray = workspace:Raycast(head.Position, root.Position - head.Position)
		if ray and ray.Instance:IsDescendantOf(chr) and not chr:GetAttribute("Hiding") then
			rushing = true
			if moving then moving:Disconnect() end

			local rushConn
			rushConn = rs.Heartbeat:Connect(function(dt)
				if not head or not head.Parent then rushConn:Disconnect() return end

				local dir = root.Position - head.Position
				if dir.Magnitude > 1 then
					-- Nếu đang trốn -> huỷ rush, quay về
					if chr:GetAttribute("Hiding") then
						rushing = false
						rushConn:Disconnect()
						returning = true
						moveTo(targetPos, speed, function()
							returning = false
						end)
						return
					end

					head.CFrame = head.CFrame + dir.Unit * 15 * dt
				else
					-- Chạm người chơi
					rushConn:Disconnect()
					if not chr:GetAttribute("Hiding") and hum.Health > 0 then
						hum:TakeDamage(math.random(20, 30))
						game:GetService("ReplicatedStorage").GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "The Skull"
					end
					head.Anchored = false
					head.Velocity = Vector3.new(0, -100, 0)
					debris:AddItem(head, 2)
				end
			end)
		end
	end
end)
