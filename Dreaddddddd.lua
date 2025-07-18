local sound = Instance.new("Sound")
sound.Name = "Clock Tick"
sound.SoundId = "rbxassetid://4940109913"
sound.Volume = 1
sound.Looped = true
sound.Parent = workspace
sound:Play()

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "DimmedScreenGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

local dim = Instance.new("Frame")
dim.Size = UDim2.new(1, 0, 1, 0)
dim.Position = UDim2.new(0, 0, 0, 0)
dim.BackgroundColor3 = Color3.new(0, 0, 0) -- màu đen
dim.BackgroundTransparency = 1
dim.ZIndex = 10
dim.Parent = gui

local TweenService = game:GetService("TweenService")

local fadeTween = TweenService:Create(dim, TweenInfo.new(60), {BackgroundTransparency = 0.1})
fadeTween:Play()
wait(60)
sound.SoundId = "rbxassetid://118897948050872"
sound.Volume = 5
sound.Looped = false
sound.TimePosition = 0
sound:Play()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModuleEvents = require(ReplicatedStorage.ClientModules.Module_Events)
local rooms = workspace.CurrentRooms
local a = rooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)

ModuleEvents.flicker(a, 5)

local plr = game.Players.LocalPlayer
local chr = plr.Character
local hum = chr:FindFirstChildOfClass("Humanoid")

task.wait(7)

local dmg = true
task.spawn(function()
while dmg == true do wait(0.1)
if not chr:GetAttribute("Hiding") then 
dmg = false
local TweenService = game:GetService("TweenService")	
local shadow = game:GetObjects("rbxassetid://11503625408")[1]
local gui = Instance.new("ScreenGui",game.Players.LocalPlayer.PlayerGui)
shadow.Parent = gui
shadow.Visible = true
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://18459521002"
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

	l__ImageLabel__1.Image = "rbxassetid://13714729609";

end;

if v4 == 2 then

	l__ImageLabel__1.Image = "rbxassetid://13714729609";

end;

if v4 == 3 then

	l__ImageLabel__1.Image = "rbxassetid://13714729609";

end;

if v4 == 4 then

	l__ImageLabel__1.Image = "rbxassetid://13714729609";

end;

if v4 == 5 then


	l__ImageLabel__1.Image = "rbxassetid://13714729609";

end;

if v4 == 6 then

	l__ImageLabel__1.Image = "rbxassetid://13714729609";

end;

shadow.Jumpscare:Play();
for v5 = 1, 45 do
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
		TweenService:Create(shadow, TweenInfo.new(0), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play();
		l__ImageLabel__1.ImageColor3 = Color3.fromRGB(1, 0, 0);
	end;
		l__ImageLabel__1.Position = UDim2.new(v2:NextNumber(0.4, 0.6), 0, v2:NextNumber(0.45, 0.55), 0);
		l__ImageLabel__1.Size = l__ImageLabel__1.Size + UDim2.new(l__SizeValue__3.Value, 0, l__SizeValue__3.Value, 0);
		l__ImageLabel__1.Rotation = math.random(-25, 25);
		l__SizeValue__3.Value = l__SizeValue__3.Value - 0.01;
		wait(0);
end;
		l__ImageLabel__1.ImageColor3 = Color3.new(0, 0, 0);
		shadow.BackgroundColor3 = Color3.new(0, 0, 0);
		TweenService:Create(l__ImageLabel__1, TweenInfo.new(2), {ImageTransparency = 1}):Play();
		gui:destroy()

hum.Health = 0
game:GetService("ReplicatedStorage").GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Dread"
end -- If
end -- Loop
end)

wait(5)
dmg = false
gui:Destroy()
