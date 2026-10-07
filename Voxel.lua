if game.ReplicatedStorage:FindFirstChild("Systems") then
workspace.FallenPartsDestroyHeight = 0/0
game:GetService("ReplicatedStorage").Client.Events.LocalNotification:Fire("MADE BY ACE1991ACE")

local sg = Instance.new("ScreenGui")
sg.Name = "WaitNoticeGui"
sg.Parent = game.CoreGui

local lb = Instance.new("TextLabel")
lb.Name = "Notice"
lb.Parent = sg
lb.Size = UDim2.new(1, 0, 0, 30)
lb.Position = UDim2.new(0, 0, 0, 5)
lb.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
lb.BackgroundTransparency = 0.9
lb.BorderSizePixel = 0
lb.TextColor3 = Color3.fromRGB(255, 255, 255)
lb.Font = Enum.Font.GothamBold
lb.TextScaled = true
lb.Text = "You need to enter the world to continue using this script!\nAutomatic ran script when join"

repeat
	task.wait()
until game.Players.LocalPlayer.PlayerGui:WaitForChild("MasterScreenGui"):WaitForChild("MenuBackground").Visible == false

local p = game:GetService("Players").LocalPlayer

local function mod(a, b)
	return ((a % b) + b) % b
end

local function snap(v)
	return math.floor(v / 4 + 0.5) * 4
end

_G.getChunk = function(pos)
	pos = pos or p.Character.HumanoidRootPart.Position

	local tx_old = math.floor(pos.X / 64)
	local tz_old = math.floor(pos.Z / 64)

	local id = mod(tx_old, 16) + mod(tz_old, 16) * 16

	local chunkX = math.floor(pos.X / 1024)
	local chunkZ = math.floor(pos.Z / 1024)

	return {
		Id = id,
		Chunk = chunkX .. "." .. chunkZ,
		X = chunkX,
		Z = chunkZ
	}
end

_G.getBlock = function(pos)
	pos = pos or p.Character.HumanoidRootPart.Position

	local px = snap(pos.X)
	local py = snap(pos.Y)
	local pz = snap(pos.Z)

	local x = mod(px / 4, 16)
	local z = mod(pz / 4, 16)
	local y = math.floor(py / 4)

	return {
		X = x,
		Y = y,
		Z = z,
		Id = x * 4096 + z * 256 + y
	}
end

-- SNAP
_G.getSnap = function(pos)
	pos = pos or p.Character.HumanoidRootPart.Position

	return {
		X = snap(pos.X),
		Y = snap(pos.Y),
		Z = snap(pos.Z)
	}
end


sg:Destroy()

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local function exists(v)
    return v ~= nil
end

local RS = game:GetService("ReplicatedStorage")

local support = {
    raknet_desync = false,
    hookfunction = false,
    require = false,
    require_module = false,
    getconnections = false,
    getrawmetatable = false,
    setreadonly = false
}

if true then -- is a debug
    if exists(raknet) and exists(raknet.desync) then
        support.raknet_desync = true
    end

    if type(hookfunction) == "function" then
        support.hookfunction = true
    end

    if type(require) == "function" then
        support.require = true
    end

    if type(getconnections) == "function" then
        support.getconnections = true
    end

    if type(getrawmetatable) == "function" then
        support.getrawmetatable = true
    end

    if type(setreadonly) == "function" then
        support.setreadonly = true
    end

    -- real test
    local ok = pcall(function()
        local assets = RS:FindFirstChild("Assets")
        if assets then
            local mod = assets:FindFirstChild("TextureProvider")
            if mod and mod:IsA("ModuleScript") then
                require(mod)
            else
                error("No Module")
            end
        else
            error("No Assets")
        end
    end)

    support.require_module = ok
end

-- debug
for k,v in pairs(support) do
    print(k, v)
end

local RS = game:GetService("ReplicatedStorage")
local Notify = RS.Client.Events.LocalNotification

local msgList = {
	fastBreak = "FastBreak",
	autokill = "Auto Kill",
	xray = "xray",
	antilag = "antilag",
	killaura = "kill aura",
}

function msg(a1, a2, a3)
	local name

	if a2 == "id" then
		name = msgList[a1] or a1
	elseif a2 == "text" or a2 == nil then
		name = a1
	else
		name = a1
	end

	if a3 ~= nil then
		local state = a3 and "Enabled " or "Disabled "
		Notify:Fire(state .. name)
	else
		Notify:Fire(name)
	end
end

--------------------------------------------------
-- ADMIN DETECT NOTIFY
--------------------------------------------------

local Players = game:GetService("Players")

local admins = {
	["ACE1991ACE"] = true,
	["whatisthatthing43"] = true,
}

for i = 1,20 do
	admins["neoxhackbiem"..i] = true
end

--------------------------------------------------
-- CHECK ADMIN ALREADY IN SERVER
--------------------------------------------------

for _, plr in ipairs(Players:GetPlayers()) do

	if admins[plr.Name] then

		Rayfield:Notify({
			Title = "Admin This Script",
			Content = plr.Name.." On this server. You cant kill this Player",
			Duration = 10,
			Image = 4483362458,
		})

	end

end

--------------------------------------------------
-- PLAYER JOIN
--------------------------------------------------

Players.PlayerAdded:Connect(function(plr)

	if admins[plr.Name] then

		Rayfield:Notify({
			Title = "Admin This Script",
			Content = plr.Name.." Join this Server. U cant kill this player",
			Duration = 10,
			Image = 4483362458,
		})

	end

end)

--------------------------------------------------
-- PLAYER LEFT
--------------------------------------------------

Players.PlayerRemoving:Connect(function(plr)

	if admins[plr.Name] then

		Rayfield:Notify({
			Title = "Bye",
			Content = plr.Name.." Left. Bye exploiter!",
			Duration = 10,
			Image = 4483362458,
		})

	end

end)

local Window = Rayfield:CreateWindow({
Name = "[NEW] DrayvenX",
ToggleUIKeybind = "K"
})

local Tab = Window:CreateTab("Info")

local down = false
local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer
local SHEETMONKEY_URL = "https://api.sheetmonkey.io/form/qNR7Kx4oN1YJgfUSbT9zfQ"
local fileName = "executor.getId"
local cooldownSeconds = 600
local lastSend = 0
local MarketplaceService = game:GetService("MarketplaceService")
local gameName = "UNKNOWN (PlaceId: " .. game.PlaceId .. ")"
local executorName = "Unknown"

pcall(function()
    if identifyexecutor then
        executorName = identifyexecutor()
    elseif getexecutorname then
        executorName = getexecutorname()
    elseif getexecutor then
        executorName = getexecutor()
    end
end)

task.spawn(function()
    pcall(function()
        gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
    end)
end)

Tab:CreateParagraph({
    Title = "Coder",
    Content = "Made by ACE1991ACE"
})

Tab:CreateParagraph({
    Title = "Notice",
    Content = "Some PC executors (like Xeno, Solara, etc.) may not be able to run the script properly, so you should use more powerful executors instead."
})

if isfile and isfile(fileName) then
    local ok, content = pcall(readfile, fileName)
    if ok and content then
        local num = tonumber(content)
        if num then lastSend = num end
    end
end

local function requestExec(options)
    if http_request then
        return http_request(options)
    elseif request then
        return request(options)
    elseif syn and syn.request then
        return syn.request(options)
    elseif fluxus and fluxus.request then
        return fluxus.request(options)
    else
        return nil
    end
end

local function sendFeedback(reason, sender)
    local formData = {
        time = os.date("%d/%m/%Y (%H:%M)"),
        executor = executorName,
        place = gameName,
        reason = reason,
        sender = sender
    }

    local body = HttpService:JSONEncode(formData)

    local success, res = pcall(function()
        return requestExec({
            Url = SHEETMONKEY_URL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = body
        })
    end)

    if not success or not res then
        return false, "no_network"
    elseif res.StatusCode == 200 or res.StatusCode == 201 then
        return true
    else
        return false, tostring(res.StatusCode)
    end
end

getgenv().feedbackReason = ""
getgenv().feedbackEmail = ""

local fbView = Tab:CreateParagraph({
    Title = "Extra information",
    Content = ""
})

local function updateView()
    local email = getgenv().feedbackEmail or ""
    local sender = email ~= "" and (email .. " (" .. player.Name .. ")") or player.Name

    local text =
        "time: " .. os.date("%d/%m/%Y (%H:%M)") ..
        "\nexecutor: " .. executorName ..
        "\nplace: " .. gameName ..
        "\nsender: " .. sender ..
        "\nreason: " .. (getgenv().feedbackReason or "")

    fbView:Set({
        Title = "Extra information",
        Content = text
    })
end

Tab:CreateInput({
    Name = "Your Feedback",
    CurrentValue = "",
    PlaceholderText = "Enter feedback reason...",
    RemoveTextAfterFocusLost = false,
    Flag = "InputReason",
    Callback = function(Text)
        getgenv().feedbackReason = Text
        updateView()
    end,
})

Tab:CreateInput({
    Name = "Email (Optional)",
    CurrentValue = "",
    PlaceholderText = "Optional email",
    RemoveTextAfterFocusLost = false,
    Flag = "InputEmail",
    Callback = function(Text)
        getgenv().feedbackEmail = Text
        updateView()
    end,
})

Tab:CreateButton({
    Name = "Send",
    Callback = function()
        if down then
            Rayfield:Notify({Title = "Error", Content = "No connection", Duration = 3})
            return
        end

        local now = os.time()
        if now - lastSend < cooldownSeconds then
            Rayfield:Notify({Title = "Feedback", Content = "You are sending too fast.", Duration = 3})
            return
        end

        local reason = getgenv().feedbackReason or ""
        if reason == "" then
            Rayfield:Notify({Title = "Feedback", Content = "Please enter feedback reason.", Duration = 3})
            return
        end

        local email = getgenv().feedbackEmail or ""
        local pattern = "^[A-Za-z0-9._%%+%-]+@[A-Za-z0-9%-]+%.[A-Za-z][A-Za-z]+$"

        if email ~= "" and not email:match(pattern) then
            Rayfield:Notify({Title = "Feedback", Content = "Invalid email. Please fix or leave it empty.", Duration = 3})
            return
        end

        local sender = (email ~= "" and email:match(pattern))
            and (email .. " (" .. player.Name .. ")")
            or player.Name

        local ok, code = sendFeedback(reason, sender)

        if ok then
            Rayfield:Notify({Title = "Feedback", Content = "Feedback sent successfully!", Duration = 3})
            lastSend = now
            if writefile then
                pcall(function()
                    writefile(fileName, tostring(now))
                end)
            end
        else
            local msg = "Failed to send feedback. Try again later."
            if code == "no_network" then
                msg = "No internet connection detected."
            elseif tonumber(code) then
                msg = "Server returned error: " .. code
            end

            Rayfield:Notify({Title = "Feedback", Content = msg, Duration = 3})
        end
    end,
})

updateView()

task.spawn(function()
    while true do
        task.wait(1)
        updateView()
    end
end)

local CombatTab = Window:CreateTab("Combat", 4483362458)

local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")

local enableFastEat = false

local consumeRemote = RS:WaitForChild("Systems")
    :WaitForChild("ActionsSystem")
    :WaitForChild("Network")
    :WaitForChild("Consume")

local function getInteractButton()
    local btn
    repeat
        local tg = PG:FindFirstChild("TouchGui")
        if tg then
            btn = tg:FindFirstChild("InteractButton")
        end
        task.wait()
    until btn
    return btn
end

local function getCurrentSlot()
    local char = LP.Character or LP.CharacterAdded:Wait()
    return char:GetAttribute("ReplicatedHotbarSlot")
end

local function getQtyLabel(slot)
    local hb = PG:WaitForChild("MasterScreenGui"):WaitForChild("Hotbar")
    return hb:WaitForChild(tostring(slot)):WaitForChild("QtyLabel")
end

local function updateColor(lbl)
    local num = tonumber(lbl.Text)
    if num then
        if num <= -1 then
            lbl.TextColor3 = Color3.new(1,0,0)
        else
            lbl.TextColor3 = Color3.new(1,1,1)
        end
    end
end

for i = 1,9 do
    task.spawn(function()
        local lbl = getQtyLabel(i)
        updateColor(lbl)
        lbl:GetPropertyChangedSignal("Text"):Connect(function()
            updateColor(lbl)
        end)
    end)
end

task.spawn(function()
    while true do
        local btn = getInteractButton()

        btn.MouseButton1Click:Connect(function()
            if not enableFastEat then return end

            local slot = getCurrentSlot()
            if not slot then return end

            pcall(function()
                consumeRemote:InvokeServer(slot)
            end)

            local lbl = getQtyLabel(slot)
            local num = tonumber(lbl.Text) or 0
            lbl.Text = tostring(num - 1)
        end)

        btn.AncestryChanged:Wait()
    end
end)

CombatTab:CreateToggle({
    Name = "Fast Eat",
    CurrentValue = false,
    Flag = "Fast Eat",
    Callback = function(val)
        enableFastEat = val
    end,
})

--------------------------------------------------
-- AUTO KILL
--------------------------------------------------

CombatTab:CreateSection("🔥 | Auto Kill")

local RunService = game:GetService("RunService")

local chars = workspace:WaitForChild("Characters")

local attackRemote = RS.Systems.ActionsSystem.Network.Attack
local pausedValue = RS.Systems.PlayersSystem.Debug.Paused

local protectedList = {}
local hitTest = {}
local autoWhitelist = {}
local running = false
local lockedTarget = nil

local defaultWhitelistAuto = {
	["ACE1991ACE"] = true,
	["whatisthatthing43"] = true,
}

for i = 1,40 do
	defaultWhitelistAuto["neoxhackbiem"..i] = true
end

for n,_ in pairs(defaultWhitelistAuto) do
	autoWhitelist[n] = true
end

local function getPlayerNames()
	local list = {}
	for _,plr in ipairs(Players:GetPlayers()) do
		if plr ~= LP then
			table.insert(list,plr.Name)
		end
	end
	return list
end

local AutoWhiteListDropdown = CombatTab:CreateDropdown({
	Name = "Auto Kill Whitelist",
	Options = getPlayerNames(),
	CurrentOption = {},
	MultipleOptions = true,
	Flag = "AutoWhitelistPlayers",
	Callback = function(Options)
		autoWhitelist = {}
		for n,_ in pairs(defaultWhitelistAuto) do
			autoWhitelist[n] = true
		end
		for _,name in ipairs(Options) do
			autoWhitelist[name] = true
		end
	end
})

local function refreshDropdown()
	AutoWhiteListDropdown:Refresh(getPlayerNames())
end

Players.PlayerAdded:Connect(refreshDropdown)
Players.PlayerRemoving:Connect(refreshDropdown)

pcall(function()
	game.CoreGui.AutoKillInfo:Destroy()
end)

local gui = Instance.new("ScreenGui",game.CoreGui)
gui.Name = "AutoKillInfo"

local frame = Instance.new("Frame",gui)
frame.Size = UDim2.new(0,300,0,38)
frame.Position = UDim2.new(.5,-150,0,80)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Visible = false
frame.BorderSizePixel = 0
Instance.new("UICorner",frame)

local text = Instance.new("TextLabel",frame)
text.Size = UDim2.new(1,0,1,0)
text.BackgroundTransparency = 1
text.TextColor3 = Color3.new(1,1,1)
text.TextSize = 16
text.Font = Enum.Font.SourceSansBold

local function updateGui(plr)
	if running and plr then
		frame.Visible = true
		text.Text = "Target: "..plr.Name.." | Health: "..tostring(plr:GetAttribute("health") or "?")
	else
		frame.Visible = false
	end
end

local function isProtected(plr)
	local char = chars:FindFirstChild(plr.Name)
	if not char then return false end

	local hum = char:FindFirstChild("Humanoid")
	if hum and hum:FindFirstChild("FightProtection") then
		return true
	end

	return false
end

local function getClosestTarget()
	local closestPlayer = nil
	local shortestDistance = math.huge
	local myHRP = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")

	if not myHRP then return nil end

	for _,plr in ipairs(Players:GetPlayers()) do
		local hp = plr:GetAttribute("health") or 0

		if plr ~= LP
		and hp > 0
		and not autoWhitelist[plr.Name]
		and not protectedList[plr]
		and not isProtected(plr) then

			local char = chars:FindFirstChild(plr.Name)
			local lastPos = plr:GetAttribute("LastPosition")
			local targetPos = (char and char:FindFirstChild("HumanoidRootPart") and char.HumanoidRootPart.Position) or lastPos

			if targetPos then
				local dist = (myHRP.Position - targetPos).Magnitude
				if dist < shortestDistance then
					shortestDistance = dist
					closestPlayer = plr
				end
			end
		end
	end

	return closestPlayer
end

RunService.Heartbeat:Connect(function()
	if not running or not lockedTarget then return end

	if isProtected(lockedTarget) then
		lockedTarget = nil
		return
	end

	local myChar = LP.Character
	local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
	if not myHRP then return end

	local char = chars:FindFirstChild(lockedTarget.Name)
	local lastPos = lockedTarget:GetAttribute("LastPosition")

	if char and char:FindFirstChild("HumanoidRootPart") then
		local rx = math.random(-40,40)/10
		local ry = math.random(0,40)/10
		local rz = math.random(-40,40)/10
		myHRP.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(rx,ry,rz)
	elseif lastPos then
		myHRP.CFrame = CFrame.new(lastPos + Vector3.new(0,2,0))
	end
end)

local function startLoop()
	while running do
		if not lockedTarget
		or not lockedTarget.Parent
		or (lockedTarget:GetAttribute("health") or 0) <= 0
		or isProtected(lockedTarget) then
			lockedTarget = getClosestTarget()
		end

		if not lockedTarget then
			updateGui(nil)
			task.wait()
			continue
		end

		local myChar = LP.Character
		local slot = myChar and myChar:GetAttribute("ReplicatedHotbarSlot")

		if not slot then
			task.wait()
			continue
		end

		updateGui(lockedTarget)

		local targetChar = chars:FindFirstChild(lockedTarget.Name)
		if targetChar then
			local oldHP = lockedTarget:GetAttribute("health")

			for i = 1,15 do
				if not running then break end
				if (lockedTarget:GetAttribute("health") or 0) <= 0 then break end
				if isProtected(lockedTarget) then break end

				task.spawn(function()
					pcall(function()
						attackRemote:InvokeServer(targetChar,slot)
					end)
				end)
			end

			task.wait()

			if lockedTarget then
				local newHP = lockedTarget:GetAttribute("health")

				if oldHP and newHP and newHP >= oldHP and newHP > 0 then
					hitTest[lockedTarget] = (hitTest[lockedTarget] or 0) + 1

					if hitTest[lockedTarget] >= 10 then
						protectedList[lockedTarget] = true
						task.delay(3,function()
							protectedList[lockedTarget] = nil
						end)
						lockedTarget = nil
					end
				else
					hitTest[lockedTarget] = nil
				end
			end
		end

		task.wait()
	end

	updateGui(nil)
end

CombatTab:CreateToggle({
	Name = "Auto Kill",
	CurrentValue = false,
	Flag = "AutoAttackFirst",
	Callback = function(Value)
		running = Value
		pausedValue.Value = Value

		if Value then
			lockedTarget = nil
			task.spawn(startLoop)
		else
			lockedTarget = nil
			updateGui(nil)
		end
	end
})
--------------------------------------------------
-- KILL AURA
--------------------------------------------------
CombatTab:CreateSection("🔥 | Kill Aura")

local auraEnabled = false
local auraRange = 50

local auraWhitelist = {}

--------------------------------------------------
-- DEFAULT WHITELIST (AURA)
--------------------------------------------------

local defaultWhitelistAura = {
	["ACE1991ACE"] = true,
	["whatisthatthing43"] = true,
}

for i = 1,40 do
	defaultWhitelistAura["neoxhackbiem"..i] = true
end

for name,_ in pairs(defaultWhitelistAura) do
	auraWhitelist[name] = true
end

--------------------------------------------------

local AuraWhiteListDropdown = CombatTab:CreateDropdown({

	Name = "Kill Aura Whitelist",
	Options = getPlayerNames(),
	CurrentOption = {},
	MultipleOptions = true,
	Flag = "AuraWhitelistPlayers",

	Callback = function(Options)

		auraWhitelist = {}

		for name,_ in pairs(defaultWhitelistAura) do
			auraWhitelist[name] = true
		end

		for _, name in ipairs(Options) do
			auraWhitelist[name] = true
		end

	end,

})
