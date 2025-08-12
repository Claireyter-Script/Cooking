local RunService = game:GetService("RunService")
local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local hrp = chr:WaitForChild("HumanoidRootPart")
local hum = chr:WaitForChild("Humanoid")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local part = Instance.new("Part")
part.Size = Vector3.new(5, 5, 5)
part.CFrame = hrp.CFrame * CFrame.new(0, 0, 35)
part.Anchored = true
part.Transparency = 1
part.CanCollide = false
part.CastShadow = false
part.Parent = workspace

local smoke = Instance.new("Smoke")
smoke.Color = Color3.new(0.5, 0.5, 0.5)
smoke.Size = 5
smoke.Opacity = 5
smoke.TimeScale = 50
smoke.Parent = part

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://1845391099"
sound.Volume = 1
sound.MaxDistance = 30
sound.PlaybackSpeed = 1
sound.Pitch = 2
sound.Looped = true
sound.Parent = part
sound:Play()

local billboard = Instance.new("BillboardGui")
billboard.Size = UDim2.new(5, 0, 5, 0)
billboard.AlwaysOnTop = true
billboard.Parent = part
billboard.Adornee = part

local imageLabel = Instance.new("ImageLabel")
imageLabel.Size = UDim2.new(1, 0, 1, 0)
imageLabel.BackgroundTransparency = 1
imageLabel.Image = "rbxassetid://91367612128883"
imageLabel.Parent = billboard

local speed = 4
local hitCooldown = false

-- Lưu connection để sau này có thể disconnect
local heartbeatConnection
heartbeatConnection = RunService.Heartbeat:Connect(function(dt)
	-- Kiểm tra nếu part đã bị destroy (hoặc part.Parent nil) thì ngắt connection
	if not part or not part.Parent or hum.Health <= 0 then
		if heartbeatConnection then
			heartbeatConnection:Disconnect()
			heartbeatConnection = nil
		end
		return
	end

	if not hrp then return end

	local dir = (hrp.Position - part.Position)
	local dist = dir.Magnitude

	if dist > 3 then
		part.CFrame = part.CFrame + dir.Unit * speed * dt
	elseif not hitCooldown then
		hitCooldown = true
		hum.Health = hum.Health - 20
		if ReplicatedStorage then
			ReplicatedStorage.GameStats["Player_"..plr.Name].Total.DeathCause.Value = "Haze"
		end

		if hum.Health > 0 then
			local offset = math.random(0, 1) == 0 and 25 or -25
			part.CFrame = hrp.CFrame * CFrame.new(0, 0, offset)
		end

		task.delay(1, function()
			hitCooldown = false
		end)
	end
end)

-- Hủy chạy và destroy part đúng thời điểm
task.delay(30, function()
	if part then
		part:Destroy()
	end
	-- Dọn connection nếu chưa dọn
	if heartbeatConnection then
		heartbeatConnection:Disconnect()
		heartbeatConnection = nil
	end
end)
