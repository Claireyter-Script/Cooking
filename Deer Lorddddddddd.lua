--// Services & Player
local RS, WS, PS = game:GetService("ReplicatedStorage"), workspace, game:GetService("Players")
local plr = PS.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

--// Ngăn spawn trùng
local flag = RS:FindFirstChild("EntitySpawned")
if not flag then
	flag = Instance.new("BoolValue")
	flag.Name = "EntitySpawned"
	flag.Parent = RS
end
if flag.Value then return end
flag.Value = true

--// Âm thanh báo spawn
local url, file = "https://raw.githubusercontent.com/Tinkgy111/Bang/main/followed.mp3", "followed.mp3"
if writefile and isfile and (getcustomasset or getsynasset) then
	if not isfile(file) then writefile(file, game:HttpGet(url)) end
else
	return
end

local s = Instance.new("Sound", workspace)
s.SoundId = (getcustomasset or getsynasset)(file)
s.Volume, s.Looped = 3, false
s:Play()

--// Load Entity
local model = game:GetObjects("rbxassetid://76464107151900")[1]
model.Parent = WS
local entity = model:FindFirstChildWhichIsA("BasePart")
entity.Anchored, entity.CanCollide, entity.Massless = true, false, true
entity.CFrame = hrp.CFrame * CFrame.new(0, 0, 50)

--// Chase Sound
local chase = Instance.new("Sound", model)
chase.Name, chase.SoundId, chase.Volume, chase.Looped = "ChaseLoop", "rbxassetid://73754333725028", 5, true
chase:Play()

--// Stop main + chỉnh âm
local main = model:FindFirstChild("Sound") if main then main:Stop() end
local sfx = entity:FindFirstChild("Static...") if sfx then sfx.PlaybackSpeed = 0.8 end
local breath = entity:FindFirstChild("Breathing") if breath then breath.Volume = 10 end
for _, s in pairs(entity:GetChildren()) do
	if s:IsA("Sound") and s.Name == "Footsteps" then s.Volume = 2 end
end

--// Chỉnh ParticleEmitter
for _, partName in {"Body", "Face"} do
	local part = entity:FindFirstChild(partName)
	if part and part:FindFirstChild("ParticleEmitter") then
		local p = part.ParticleEmitter
		if partName == "Body" then
			p.Lifetime, p.Rate, p.Rotation = NumberRange.new(0.1,1), 300, NumberRange.new(-15)
			p.RotSpeed, p.Speed, p.SpreadAngle = NumberRange.new(-15,15), NumberRange.new(0,1), Vector2.new(180,-180)
			p.Brightness, p.LightEmission, p.LightInfluence = 3, 0.2, 3
		else
			p.Texture = "rbxassetid://115721169488337"
			p.Lifetime, p.Rate = NumberRange.new(0.1,0.5), 150
			p.Rotation, p.RotSpeed = NumberRange.new(-3,0), NumberRange.new(-10,25)
			p.Speed, p.SpreadAngle = NumberRange.new(0,0.5), Vector2.new(180,180)
			p.Brightness, p.LightEmission, p.LightInfluence = 10, 0, 0.5
		end
	end
end

--// màu tím
local purple = Color3.fromRGB(170, 0, 255)
local seq = ColorSequence.new(purple)

for _, obj in pairs(entity:GetDescendants()) do
	local parent = obj.Parent
	if obj:IsA("ParticleEmitter") and obj.Name == "ParticleEmitter" and (parent and (parent.Name == "Face" or parent.Name == "Body")) then
		continue
	end
	if obj:IsA("BasePart") then
		obj.Color = purple
	elseif obj:IsA("Decal") then
		obj.Color3 = purple
	elseif obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("ParticleEmitter") then
		obj.Color = seq
	elseif obj:IsA("PointLight") then
		obj.Color = purple
	elseif obj:IsA("SpecialMesh") then
		obj.VertexColor = Vector3.new(1.7, 0, 2.55)
	end
end

--// Theo dõi & xử lý nhìn
local speed, died = 5, false

local conn; conn = game:GetService("RunService").RenderStepped:Connect(function(dt)
	if died or not entity:IsDescendantOf(WS) then conn:Disconnect() return end
	if char:GetAttribute("Hiding") then return end
	if hum.Health <= 0 then return end

	local dir = hrp.Position - entity.Position
	if dir.Magnitude <= 10 then
		died = true
		s:Destroy()
		hum.Health = 0
		local stats = RS:FindFirstChild("GameStats")
		if stats and stats:FindFirstChild("Player_"..plr.Name) then
			stats["Player_"..plr.Name].Total.DeathCause.Value = "The Deer God"
		end
		model:Destroy()
		flag:Destroy()
		conn:Disconnect()
		return
	end

	local step = math.min(speed * dt, dir.Magnitude)
	local nextPos = entity.Position + Vector3.new(dir.Unit.X * step, 0, dir.Unit.Z * step)
	entity.Position = Vector3.new(nextPos.X, hrp.Position.Y, nextPos.Z)
	entity.CFrame = CFrame.new(entity.Position, Vector3.new(hrp.Position.X, entity.Position.Y, hrp.Position.Z))
end)

--// Tự hủy sau khi nhạc phát xong
s.Ended:Connect(function()
	if model:IsDescendantOf(WS) then model:Destroy() end
	flag:Destroy()
	s:Destroy()
end)
