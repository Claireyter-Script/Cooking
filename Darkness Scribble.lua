local function jc()
local TweenService = game:GetService("TweenService")	
local shadow = game:GetObjects("rbxassetid://11503625408")[1]
local gui = Instance.new("ScreenGui",game.Players.LocalPlayer.PlayerGui)
shadow.Parent = gui
shadow.Visible = true
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://18564431123"
sound.Parent = gui
sound.Volume = 0.5

local octave = Instance.new("PitchShiftSoundEffect",sound)
octave.Octave = 0.5
local level = Instance.new("DistortionSoundEffect",sound)
level.Level = 0.97

local a = Instance.new("DistortionSoundEffect",sound)
a.Level = 0.75
local b = Instance.new("DistortionSoundEffect",sound)
b.Level = 0.75

sound:Play()

local l__ImageLabel__1 = shadow.ImageLabel;
local v2 = Random.new();
local l__SizeValue__3 = shadow.SizeValue;
local v4 = math.random(1, 6);

if v4 == 1 then

	l__ImageLabel__1.Image = "rbxassetid://104301532085372";

end;

if v4 == 2 then

	l__ImageLabel__1.Image = "rbxassetid://104301532085372";

end;

if v4 == 3 then

	l__ImageLabel__1.Image = "rbxassetid://104301532085372";

end;

if v4 == 4 then

	l__ImageLabel__1.Image = "rbxassetid://104301532085372";

end;

if v4 == 5 then


	l__ImageLabel__1.Image = "rbxassetid://104301532085372";

end;

if v4 == 6 then

	l__ImageLabel__1.Image = "rbxassetid://104301532085372";

end;

shadow.Jumpscare:Play();
for v5 = 1, 35 do
local v6 = math.random(1, 6);
	if v6 == 1 then
		TweenService:Create(shadow, TweenInfo.new(0), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play();
		l__ImageLabel__1.ImageColor3 = Color3.new(0, 0, 0);
	end;
	if v6 == 2 then
		TweenService:Create(shadow, TweenInfo.new(0), {BackgroundColor3 = Color3.fromRGB(0, 0, 0)}):Play();
		l__ImageLabel__1.ImageColor3 = Color3.new(1, 1, 1);
	end;
	if v6 == 3 then
		TweenService:Create(shadow, TweenInfo.new(0), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}):Play();
		l__ImageLabel__1.ImageColor3 = Color3.fromRGB(0, 0, 0);
	end;
		l__ImageLabel__1.Position = UDim2.new(v2:NextNumber(0.4, 0.6), 0, v2:NextNumber(0.45, 0.55), 0);
		l__ImageLabel__1.Size = l__ImageLabel__1.Size + UDim2.new(l__SizeValue__3.Value, 0, l__SizeValue__3.Value, 0);
		l__ImageLabel__1.Rotation = math.random(-25, 25);
		l__SizeValue__3.Value = l__SizeValue__3.Value - 0.01;
		wait(0.001);
end;
		l__ImageLabel__1.ImageColor3 = Color3.new(0, 0, 0);
		shadow.BackgroundColor3 = Color3.new(0, 0, 0);
		TweenService:Create(l__ImageLabel__1, TweenInfo.new(2), {ImageTransparency = 1}):Play();
		TweenService:Create(shadow, TweenInfo.new(3), {BackgroundTransparency = 1}):Play();
		wait(2);
		gui:destroy()
end

function LoadCustomInstance(source, parent)
	local model

	-- Normalize GitHub URL if needed
	local function NormalizeGitHubURL(url)
		if url:match("^https://github.com/.+%.rbxm$") and not url:find("?raw=true") then
			return url .. "?raw=true"
		end
		return url
	end

	while task.wait() and not model do
		if type(source) == "number" or tostring(source):match("^%d+$") then
			-- Asset ID loading
			local success, result = pcall(function()
				return game:GetObjects("rbxassetid://" .. tostring(source))[1]
			end)

			if success and result then
				model = result
			end

		elseif type(source) == "string" and source:match("^https?://") and source:match("%.rbxm") then
			-- GitHub URL loading
			local url = NormalizeGitHubURL(source)
			
			local success, result = pcall(function()
				local fileName = "temp_" .. tostring(math.random(100000, 999999)) .. ".rbxm"
				writefile(fileName, game:HttpGet(url))
				local obj = game:GetObjects((getcustomasset or getsynasset)(fileName))[1]
				delfile(fileName)
				return obj
			end)

			if success and result then
				model = result
			end

		else
					break
		end

		if model then
			model.Parent = parent or workspace

			for _, obj in ipairs(model:GetDescendants()) do
				if obj:IsA("Script") or obj:IsA("LocalScript") then
					obj:Destroy()
				end
			end

			pcall(function()
				model:SetAttribute("LoadedByExecutor", true)
			end)
		end
	end

	return model
end

local s = LoadCustomInstance("https://github.com/plamen6789/CustomDoorsMonsters/raw/main/A-120.rbxm", workspace)
local primary_part = s:FindFirstChildWhichIsA("BasePart") or s:FindFirstChildWhichIsA("Part")
entity = primary_part

local plr = game.Players.LocalPlayer
local chr = plr.Character

entity.CFrame = workspace.CurrentRooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value):WaitForChild("RoomEntrance").CFrame * CFrame.new(0,2,-15)
entity.CanCollide = false
entity.Anchored = true
entity.ParticleEmitter3.Texture = "rbxassetid://104301532085372"

local sound = entity.PlaySound
local far = entity.Footsteps

sound.PlaybackSpeed = 0.45
sound.Volume = 1

local ab = Instance.new("DistortionSoundEffect",sound)
ab.Level = 0.5

far.PlaybackSpeed = 0.1
far.Volume = 0.3

local cd = Instance.new("DistortionSoundEffect",sound)
cd.Level = 0.5

local att = entity.LightAttach
local a = att.ParticleEmitter1
local b = att.ParticleEmitter2
local c = att.ParticleEmitter3
a.Brightness = 20
a.Texture = "rbxassetid://104301532085372"
b.Brightness = 20
b.Texture = "rbxassetid://104301532085372"
c.Brightness = 20
c.Texture = "rbxassetid://104301532085372"

a.Size = NumberSequence.new(5)
b.Size = NumberSequence.new(5)
c.Size = NumberSequence.new(5)

c.Lifetime = NumberRange.new(0.5, 1)
local dmg = true	

local light = Instance.new("PointLight",entity)
light.Color = Color3.fromRGB(255, 0, 0)
light.Brightness = 50
light.Range = 10

game.Workspace.CurrentRooms.ChildAdded:Connect(function()
dmg = false
s:Destroy()
end)

task.wait(2)
    task.spawn(function()
		while dmg == true do
			task.wait(0.3)
			
			local player = game.Players.LocalPlayer
			local char = player.Character
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			
			if hum and hrp and (hrp.Position - entity.Position).Magnitude <= 10 then
			if not chr:GetAttribute("Hiding") then
	            game.Players.LocalPlayer.Character.Humanoid.Health -= 1.3
	            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed -= 0.25
                game:GetService("ReplicatedStorage").GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Darkness Scribble"
                
                if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then
                dmg = false          
                jc() 
                end
            end
            end
		end
	end)
