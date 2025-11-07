local plr = game.Players.LocalPlayer
repeat task.wait() until plr and plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
local chr, hum = plr.Character, plr.Character:FindFirstChildOfClass("Humanoid")
local TweenService = game:GetService("TweenService")
local dmg = true

-- Hàm ghi cause
local function cause(name)
	pcall(function()
		local stat = game.ReplicatedStorage.GameStats["Player_"..plr.Name].Total.DeathCause
		if stat then stat.Value = name end
	end)
end

-- Thiết lập phòng hiện tại
local currentRoom = game.ReplicatedStorage.GameData.LatestRoom.Value
local room = workspace.CurrentRooms:FindFirstChild(currentRoom)
if room then
	room:SetAttribute("Ambient", Color3.fromRGB(100, 0, 100))
end

-- Load model
local model = game:GetObjects("rbxassetid://12621816107")[1]
model.Parent = workspace

local roomCF = room and room:FindFirstChild(currentRoom)
if roomCF then
	model.CFrame = roomCF.CFrame * CFrame.new(0, 5, 0)
end

-- Sounds
local Initiate = model:FindFirstChild("Initiate")
local Change = model:FindFirstChild("Change")
local PointLight = model:FindFirstChild("PointLight")

if Initiate then Initiate.Parent = workspace end
if Change then
	Change.Volume = 10
end

PointLight.Range = 15
PointLight.Brightness = 2

model.Sound.Volume = 2
local newsound = model.Sound:Clone()
newsound.Parent = model
newsound.PlaybackSpeed = 0.05
newsound.MaxDistance = 10000
newsound.Volume = 3

-- Damage sound
local DmgSound = Instance.new("Sound")
DmgSound.SoundId = "rbxassetid://7837537174"
DmgSound.Volume = 0.8
DmgSound.PlaybackSpeed = 0.5
DmgSound.Parent = workspace

-- Eye setup
local att = model:FindFirstChild("Attachment")
local open, close = att and att:FindFirstChild("Open"), att and att:FindFirstChild("Close")
if open and close then
	open.Enabled, close.Enabled = true, false
	open.Texture, close.Texture = "rbxassetid://80978110080928", "rbxassetid://120585267036077"
end

-- Lighting effect
local Color = Instance.new("ColorCorrectionEffect", game.Lighting)

-- Auto destroy when room changes
task.spawn(function()
    local conn
    conn = game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()
		dmg = false
		pcall(function() Color:Destroy() end)
		pcall(function() Initiate:Destroy() end)
		pcall(function() DmgSound:Destroy() end)
		pcall(function() Change:Destroy() end)
		pcall(function()
		conn:Disconnect()
			if model.Sound then
				local tween = TweenService:Create(model.Sound, TweenInfo.new(3), {PlaybackSpeed = 0})
				TweenService:Create(PointLight, TweenInfo.new(5), {Range = 0})
				tween:Play()
				tween.Completed:Wait()
			end
			model:Destroy()
		end)
	end)
end)

-- Play Initiate safely
pcall(function() if Initiate then Initiate:Play() end end)

-- Helper: setup emitters
local function setupEmitter(em, ltMin, ltMax, rotMin, rotMax, rotSpeedMax, rate)
	if em and em:IsA("ParticleEmitter") then
		em.Lifetime = NumberRange.new(ltMin, ltMax)
		em.Rate = rate
		em.Rotation = NumberRange.new(rotMin, rotMax)
		em.RotSpeed = NumberRange.new(0, rotSpeedMax)
		em.Speed = NumberRange.new(0, 0)
		em.SpreadAngle = Vector2.new(-360, 360)
	end
end

setupEmitter(close, 0.1, 0.3, -1, 1, 0, 500)
setupEmitter(open, 0.1, 0.3, -1, 5, 5, 5000)

-- Eye switch
local function SwitchEye()
	if open and close then
		if open.Enabled then
			open.Enabled = false
			close.Enabled = true
		else
			open.Enabled = true
			close.Enabled = false
		end
	end
end

-- Play “Change” every 5s safely
task.spawn(function()
	while dmg do
		task.wait(5)
		if not Change or not Change.Parent then break end

		pcall(function()
    	local c = Change:Clone()
    	c.Parent = workspace
	    c:Play()
	    game.Debris:AddItem(c, c.TimeLength + 0.5)
        end)

		task.wait(0.1)
		SwitchEye()
	end
end)

wait(1)

-- Damage loop
task.spawn(function()
	while dmg and hum and hum.Health > 0 do
		task.wait(0.3)
		if not hum.Parent then break end
		
		local hrp = chr:WaitForChild("HumanoidRootPart")
		local lastPos = hrp.Position
		local vel = hrp.Velocity.Magnitude
    	local moved = (hrp.Position - lastPos).Magnitude > 0.1
    
		if open and open.Enabled and (vel > 0.5 or moved) then
			hum:TakeDamage(5)
			pcall(function()
				Color.TintColor = Color3.fromRGB(100, 0, 100)
				Color.Saturation = -1
				Color.Contrast = 0.5
				DmgSound:Play()
				TweenService:Create(Color, TweenInfo.new(5), {
					TintColor = Color3.fromRGB(255, 255, 255),
					Saturation = 0,
					Contrast = 0
				}):Play()
			end)
			cause("Blink")
			if hum.Health <= 0 then
				pcall(function()
					if model:FindFirstChild("Attack") then
						model.Attack.Volume = 5
						model.Attack:Play()
					end
				end)
				break
			end
		end
	end
end)
