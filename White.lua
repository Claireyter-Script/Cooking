local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()

local function jc()
local shadow = game:GetObjects("rbxassetid://11503625408")[1]
		local gui = Instance.new("ScreenGui",game.Players.LocalPlayer.PlayerGui)
        local sound = Instance.new("Sound")
    	sound.SoundId = "rbxassetid://".. 89341561477578
    	sound.Looped = false
    	sound.Parent = gui
    	sound.Volume = 5
    	sound:Play()
			shadow.Parent = gui
			shadow.Visible = true
			local l__ImageLabel__1 = shadow.ImageLabel;
			local v2 = Random.new();
			local l__SizeValue__3 = shadow.SizeValue;
			local v4 = math.random(1, 4);
			if v4 == 1 then
				l__ImageLabel__1.Image = "rbxassetid://11678966779";
			end;
			if v4 == 2 then
				l__ImageLabel__1.Image = "rbxassetid://11678966779";
			end;
			if v4 == 3 then
				l__ImageLabel__1.Image = "rbxassetid://11678966779";
			end;
			if v4 == 4 then
				l__ImageLabel__1.Image = "rbxassetid://11678966779";
			end;
                  if v4 == 5 then
				l__ImageLabel__1.Image = "rbxassetid://11678966779";
			end;
			shadow.Jumpscare:Play();
			for v5 = 1, 25 do
				local v6 = math.random(1, 3);
				if v6 == 1 then
					shadow.BackgroundColor3 = Color3.new(0, 0, 0);
					l__ImageLabel__1.ImageColor3 = Color3.new(1, 1, 1);
				end;
				if v6 == 2 then
					shadow.BackgroundColor3 = Color3.new(0, 0, 0);
					l__ImageLabel__1.ImageColor3 = Color3.new(0, 0, 1);
				end;
				if v6 == 3 then
					shadow.BackgroundColor3 = Color3.new(0, 0, 0);
					l__ImageLabel__1.ImageColor3 = Color3.new(1, 1, 1);
				end;
				l__ImageLabel__1.Position = UDim2.new(v2:NextNumber(0.4, 0.6), 0, v2:NextNumber(0.45, 0.55), 0);
				l__ImageLabel__1.Size = l__ImageLabel__1.Size + UDim2.new(l__SizeValue__3.Value, 0, l__SizeValue__3.Value, 0);
				l__ImageLabel__1.Rotation = math.random(-5, 5);
				l__SizeValue__3.Value = l__SizeValue__3.Value - 0.001;
				wait(0);
			end;
			l__ImageLabel__1.ImageColor3 = Color3.new(1, 1, 1);
			shadow.BackgroundColor3 = Color3.new(0, 0, 0);
			shadow.Visible = false;
			gui:Destroy()
end

if not game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Glitchy") then
	local Glitchy = Instance.new("ScreenGui")
	local GlitchScreen = Instance.new("Frame")
	local Glitch1 = Instance.new("ImageLabel")
	local Glitch2 = Instance.new("ImageLabel")
	local Glitch3 = Instance.new("ImageLabel")
	
	--Properties:
	
	Glitchy.Name = "Glitchy"
	Glitchy.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	Glitchy.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	
	GlitchScreen.Name = "Glitch Screen"
	GlitchScreen.Parent = Glitchy
	GlitchScreen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	GlitchScreen.BackgroundTransparency = 1.000
	GlitchScreen.BorderColor3 = Color3.fromRGB(0, 0, 0)
	GlitchScreen.BorderSizePixel = 0
	GlitchScreen.Size = UDim2.new(1, 1, 1, 1)
	
	Glitch1.Name = "Glitch1"
	Glitch1.Parent = GlitchScreen
	Glitch1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Glitch1.BackgroundTransparency = 1.000
	Glitch1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Glitch1.BorderSizePixel = 0
	Glitch1.Visible = false
	Glitch1.Size = UDim2.new(1, 1, 1, 1)
	Glitch1.Image = "rbxassetid://15959966417"
	Glitch1.ImageTransparency = 0.800
	
	Glitch2.Name = "Glitch2"
	Glitch2.Parent = GlitchScreen
	Glitch2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Glitch2.BackgroundTransparency = 1.000
	Glitch2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Glitch2.BorderSizePixel = 0
	Glitch2.Visible = false
	Glitch2.Size = UDim2.new(1, 1, 1, 1)
	Glitch2.Image = "rbxassetid://15959979240"
	Glitch2.ImageTransparency = 0.800
	
	Glitch3.Name = "Glitch3"
	Glitch3.Parent = GlitchScreen
	Glitch3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Glitch3.BackgroundTransparency = 1.000
	Glitch3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Glitch3.BorderSizePixel = 0
	Glitch3.Visible = false
	Glitch3.Size = UDim2.new(1, 1, 1, 1)
	Glitch3.Image = "rbxassetid://12590547162"
	Glitch3.ImageTransparency = 0.800
end

---====== Wh1t3 ======---

local entity = spawner.Create({
	Entity = {
		Name = "Wh1t3",
		Asset = "rbxassetid://85396591341941",
		HeightOffset = 2
	},
	Lights = {
		Flicker = {
			Enabled = false,
			Duration = 1
		},
		Shatter = true,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = true,
		Range = 100,
		Values = {15, 20, 0.1, 1} -- Magnitude, Roughness, FadeIn, FadeOut
	},
	Movement = {
		Speed = 500,
		Delay = 8,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "Ambush", -- "Blitz"
		Min = 2,
		Max = 3,
		Delay = 0.01
	},
	Damage = {
		Enabled = true,
		Range = 100,
		Amount = 0.01
	},
	Crucifixion = {
		Enabled = true,
		Range = 200,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding", -- "Curious"
		Hints = {"Death", "Hints", "Go", "Here"},
		Cause = ""
	}
})

local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://131489490"
	sound.Parent = workspace
	sound.Volume = 6
	sound.PlaybackSpeed = 0.75
	sound:Play()
local CameraShaker = require(game.ReplicatedStorage.CameraShaker)
local camara = game.Workspace.CurrentCamera
local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(cf)
	camara.CFrame = camara.CFrame * cf
end)
camShake:Start()
camShake:Shake(CameraShaker.Presets.Earthquake)

local color = Instance.new("ColorCorrectionEffect", game.Lighting)
game:GetService("TweenService"):Create(color, TweenInfo.new(3), {TintColor = Color3.fromRGB(0, 0, 0)}):Play()
color.Contrast = 0
task.spawn(function()
    local a = game:GetService("TweenService"):Create(color, TweenInfo.new(6), {
        TintColor = Color3.fromRGB(255, 0, 0),
        Contrast = 1
    })
    a:Play()
end)

local redtweeninfo = TweenInfo.new(5)
local redinfo = {Color = Color3.fromRGB(100, 0, 0)}

----------

for i,v in pairs(workspace.CurrentRooms:GetDescendants()) do
			if v:IsA("Light") then
					game.TweenService:Create(v,redtweeninfo,redinfo):Play()
					if v.Parent.Name == "LightFixture" then
						    game.TweenService:Create(v.Parent,redtweeninfo,redinfo):Play()
					end
		  end
end

---====== Debug entity ======---

entity:SetCallback("OnDespawning", function()
entity:Despawn()
task.spawn(function()
    local b = game:GetService("TweenService"):Create(color, TweenInfo.new(10), {
        TintColor = Color3.fromRGB(255, 255, 255),
        Contrast = 0
    })
    b:Play()
    b.Completed:Wait()
    color:Destroy()
end)

    local Gglitchy = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Glitchy")
    local Gglitch1 = Gglitchy["Glitch Screen"].Glitch1
    local Gglitch2 = Gglitchy["Glitch Screen"].Glitch2
    local Gglitch3 = Gglitchy["Glitch Screen"].Glitch3
    Gglitch1.Visible = false
    Gglitch2.Visible = false
    Gglitch3.Visible = false
end)

entity:SetCallback("OnDamagePlayer", function(newHealth)
	if newHealth == 0 then
		print("Entity has killed the player")
	else
	game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid"):TakeDamage(30)
	game:GetService("ReplicatedStorage").GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Wh1t3"
	task.spawn(function()
	if game.Players.LocalPlayer.Character.Humanoid.Health <= 0 then
        jc()
        task.wait(3)
		game.Players.LocalPlayer:Kick(' You Die To "Wh1t3" ')
		wait(3)
        game:Shutdown()
     end
            local Debuffs = Instance.new("ScreenGui")
			local WH1T3 = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local ImageLabel = Instance.new("ImageLabel")
			local Speed_Debuff = Instance.new("TextLabel")
			Debuffs.Name = "Debuffs"
			Debuffs.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
			Debuffs.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			WH1T3.Name = "WH1T3"
			WH1T3.Parent = Debuffs
			WH1T3.BackgroundColor3 = Color3.fromRGB(9, 9, 9)
			WH1T3.BackgroundTransparency = 0.500
			WH1T3.BorderColor3 = Color3.fromRGB(0, 0, 0)
			WH1T3.BorderSizePixel = 0
			WH1T3.Position = UDim2.new(0.830811501, -1, 0.936082482, -1)
			WH1T3.Size = UDim2.new(0.169188485, 1, 0.0639175251, 1)
			UICorner.Parent = WH1T3
			ImageLabel.Parent = WH1T3
			ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ImageLabel.BackgroundTransparency = 1.000
			ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ImageLabel.BorderSizePixel = 0
			ImageLabel.Position = UDim2.new(4.92218874e-07, 0, 0, 0)
			ImageLabel.Size = UDim2.new(0.266129375, 1, 1, 1)
			ImageLabel.Image = "rbxassetid://12096064117"
			Speed_Debuff.Name = "Speed_Debuff"
			Speed_Debuff.Parent = WH1T3
			Speed_Debuff.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Speed_Debuff.BackgroundTransparency = 1.000
			Speed_Debuff.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Speed_Debuff.BorderSizePixel = 0
			Speed_Debuff.Size = UDim2.new(1, 1, 1, 1)
			Speed_Debuff.Font = Enum.Font.Unknown
			Speed_Debuff.Text = "     -50% Speed"
			Speed_Debuff.TextColor3 = Color3.fromRGB(255, 0, 0)
			Speed_Debuff.TextSize = 14.000
			Speed_Debuff.TextStrokeTransparency = 0
			game:GetService("RunService").RenderStepped:Connect(function()
            if not workspace:FindFirstChild("SeekMoving") then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = math.random(10, 12.5)
            end
            end)
       end)
	end
end)

entity:SetCallback("CrucifixionOverwrite", function()
    print("Custom crucifixion callback")
end)

---====== Run entity ======---

entity:Run()
