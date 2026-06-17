--The Armory--








--[[
    ================================================================
    [ SCRIPT INFORMATION ]
    Project: Custom Script
    Author: OYB
    YouTube: https://www.youtube.com/channel/UCAlXXV1Hbvf7WbfXARuVtiQ
    
    [ TERMS AND CONDITIONS ]
    - You ARE allowed to use and modify this script for your own games.
    - You ARE NOT allowed to re-upload, redistribute, or claim 
      ownership of this script.
    - Removing or altering these credits is strictly prohibited.
    
    Copyright (c) 2026 OYB. All rights reserved.
    ================================================================
]]

-- ⚠️ IMPORTANT: Put this code at the VERY TOP of your Main Script (before obfuscating) ⚠️

local ProtectionConfig = {
    -- 🔴 CRITICAL: This MUST exactly match the 'Secret' value in your Key System's Config!
    -- If your Key System has: Secret = "Test"
    -- Then this must also be: SecretKey = "Test"
    SecretKey = "by123aloip0984",
    
    -- The name of your Hub (shown in the kick message if they try to bypass)
    HubName = "syrift.lua - the armory"
}

-- Anti-Bypass Logic: Checks if the Key System successfully set the global variable
if not _G[ProtectionConfig.SecretKey] then
    local player = game:GetService("Players").LocalPlayer
    if player then
        player:Kick("what a loser dont bypass" .. ProtectionConfig.HubName)
    end
    return -- Stops the rest of the script from loading!
end

-------------------------------------------------------------------------------
-- 👇 YOUR MAIN SCRIPT CODE STARTS HERE 👇
-------------------------------------------------------------------------------

print(ProtectionConfig.Syrift.lua .. " Loaded Successfully!")















local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'Syrift.lua - The Armory',
    Center = true,
    AutoShow = true,
    TabPadding = 8
})

local Tabs = {
    combat = Window:AddTab('Combat'),
    visuals = Window:AddTab('Visuals'),
    player = Window:AddTab('Player'),
    world = Window:AddTab('World'),
    ['UI Settings'] = Window:AddTab('UI and INFO'),
}

local combat1 = Tabs.combat:AddLeftTabbox()
local combat3 = Tabs.combat:AddRightGroupbox('Crosshair')

local visuals1 = Tabs.visuals:AddLeftTabbox()
local visuals2 = Tabs.visuals:AddRightGroupbox('Self-Visuals')

local world1 = Tabs.world:AddLeftGroupbox('World')
local world2 = Tabs.world:AddRightGroupbox('Sky')

local movementTabs = Tabs.player:AddLeftTabbox()
local server1 = Tabs.player:AddRightGroupbox('server')



-----------------------------------------------------------------------

-----------------------------------------------------------------------
           ---combat---
local Tab1 = combat1:AddTab('Aimbot')
local Tab2 = combat1:AddTab('Hitbox')
local Tab3 = combat1:AddTab('Gunmod')

        ---visuals---
local Tab4 = visuals1:AddTab('Player')
local Tab5 = visuals1:AddTab('World')

local moveTab = movementTabs:AddTab("Movement")
local world2 = movementTabs:AddTab("game")




---------------------------------------------------------------------
-- FOLIAGE TOGGLES
---------------------------------------------------------------------
world1:AddDivider()

local bushToggle = world1:AddToggle("BushCluster_Toggle", {
    Text = "no bushes",
    Default = false,
    Callback = function(v)
        SetBushClusterTransparency(v)
    end
})

local treeToggle = world1:AddToggle("Trees_Toggle", {
    Text = "no trees",
    Default = false,
    Callback = function(v)
        SetTreeTransparency(v)
    end
})

world1:AddDivider()

---------------------------------------------------------------------
-- COLOR CORRECTION MODS
---------------------------------------------------------------------

-- Create CC if missing
if not game.Lighting:FindFirstChild("CC_Mod") then
    local cc = Instance.new("ColorCorrectionEffect")
    cc.Name = "CC_Mod"
    cc.Parent = game.Lighting
end

local CC = game.Lighting:FindFirstChild("CC_Mod")

world1:AddSlider("CC_Saturation", {
    Text = "Saturation",
    Min = -1,
    Max = 1,
    Default = 0,
    Rounding = 2,
    Callback = function(v)
        CC.Saturation = v
    end
})

world1:AddSlider("CC_Contrast", {
    Text = "Contrast",
    Min = -1,
    Max = 1,
    Default = 0,
    Rounding = 2,
    Callback = function(v)
        CC.Contrast = v
    end
})

world1:AddSlider("CC_Exposure", {
    Text = "Exposure",
    Min = -1,
    Max = 1,
    Default = 0,
    Rounding = 2,
    Callback = function(v)
        CC.Brightness = v
    end
})

world1:AddDivider()

---------------------------------------------------------------------
-- EFFECT REMOVAL BUTTONS
---------------------------------------------------------------------

world1:AddButton("no Sun Rays", function()
    local sr = game.Lighting:FindFirstChildOfClass("SunRaysEffect")
    if sr then sr:Destroy() end
end)

world1:AddButton("no Bloom", function()
    local bloom = game.Lighting:FindFirstChildOfClass("BloomEffect")
    if bloom then bloom:Destroy() end
end)

world1:AddDivider()

---------------------------------------------------------------------
-- LOW GRAPHICS BUTTON
---------------------------------------------------------------------

world1:AddButton("low graphics", function()

    -- Remove Atmosphere
    local at = game.Lighting:FindFirstChildOfClass("Atmosphere")
    if at then at:Destroy() end

    -- Remove DepthOfField
    local dof = game.Lighting:FindFirstChildOfClass("DepthOfFieldEffect")
    if dof then dof:Destroy() end

    -- Remove ColorCorrection (except ours)
    for _, v in ipairs(game.Lighting:GetChildren()) do
        if v:IsA("ColorCorrectionEffect") and v.Name ~= "CC_Mod" then
            v:Destroy()
        end
    end

    -- Remove SunRays
    local sr = game.Lighting:FindFirstChildOfClass("SunRaysEffect")
    if sr then sr:Destroy() end

    -- Remove Bloom
    local bloom = game.Lighting:FindFirstChildOfClass("BloomEffect")
    if bloom then bloom:Destroy() end

    -- Remove Clouds
    local clouds = workspace.World.Weather:FindFirstChild("Clouds")
    if clouds then clouds:Destroy() end

    -- Remove WindFX
    local wind = workspace.World.Weather:FindFirstChild("WindFX")
    if wind then wind:Destroy() end

    -- Remove WeatherEffects folder
    local fx = workspace:FindFirstChild("WeatherEffects")
    if fx then fx:Destroy() end

    -- Set all materials to smooth plastic
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Material = Enum.Material.SmoothPlastic
        end
    end
end)

---------------------------------------------------------------------
-- FOLIAGE LOGIC
---------------------------------------------------------------------

function SetBushClusterTransparency(state)
    local Foliage = workspace.World:FindFirstChild("Foliage")
    if not Foliage then return end

    local folders = {
        Foliage:FindFirstChild("Bushes"),
        Foliage:FindFirstChild("Clusters")
    }

    for _, folder in ipairs(folders) do
        if folder then
            for _, obj in ipairs(folder:GetDescendants()) do
                if obj:IsA("BasePart") then
                    obj.Transparency = state and 1 or 0
                end
            end
        end
    end
end

function SetTreeTransparency(state)
    local Foliage = workspace.World:FindFirstChild("Foliage")
    if not Foliage then return end

    -- Trees (mesh named "leaves")
    local trees = Foliage:FindFirstChild("Trees")
    if trees then
        for _, model in ipairs(trees:GetChildren()) do
            local mesh = model:FindFirstChild("leaves", true)
            if mesh and mesh:IsA("BasePart") then
                mesh.Transparency = state and 1 or 0
            end
        end
    end

    -- Trees2 (mesh named "Tree2")
    local trees2 = Foliage:FindFirstChild("Trees2")
    if trees2 then
        for _, model in ipairs(trees2:GetChildren()) do
            local mesh = model:FindFirstChild("Tree2", true)
            if mesh and mesh:IsA("BasePart") then
                mesh.Transparency = state and 1 or 0
            end
        end
    end
end

world1:AddDivider()



Tab1:AddDivider()

Tab1:AddToggle("EnableAimlock", { Text = "Enable", Default = false })



local AimbotToggle = Tab1:AddToggle("Aimbot", { Text = "Aimbot", Default = false })
AimbotToggle:AddKeyPicker("AimbotKey", {
    Default = "MB2",
    Mode = "Hold",
    Text = "Aimbot Key",
    NoUI = false
})



local DrawFOVToggle = Tab1:AddToggle("DrawFOV", { Text = "Draw FOV", Default = false })
DrawFOVToggle:AddColorPicker("FOVColor", {
    Default = Color3.fromRGB(255, 0, 255),
    Transparency = 0,
    Title = "FOV Color"
})



Tab1:AddToggle("PlayerInfo", { Text = "Player Info", Default = false })



Tab1:AddToggle("StickyAim", { Text = "Sticky Aim", Default = false })
Tab1:AddToggle("TeamCheck", { Text = "Team Check", Default = false })
Tab1:AddToggle("WallCheck", { Text = "Wall Check", Default = false })
Tab1:AddToggle("DeadCheck", { Text = "Dead Check", Default = false })

Tab1:AddDivider()

Tab1:AddSlider("FOVSize", {
    Text = "FOV Size",
    Default = 150,
    Min = 20,
    Max = 500,
    Rounding = 0
})

Tab1:AddSlider("Prediction", {
    Text = "Prediction Amount",
    Default = 0.1,
    Min = 0,
    Max = 1,
    Rounding = 3
})

Tab1:AddSlider("Smoothness", {
    Text = "aimbot strength",
    Default = 3,
    Min = 0.05,
    Max = 5,
    Rounding = 3
})

Tab1:AddDivider()

Tab1:AddDropdown("HitPart", {
    Text = "Hit Part",
    Values = {"Head", "UpperTorso", "HumanoidRootPart"},
    Default = 1
})

Tab1:AddToggle("ExcludePlayers", { Text = "Exclude Players", Default = false })

Tab1:AddDropdown("Exclusion", {
    Text = "Player Exclusion",
    SpecialType = "Player",
    Multi = true
})

Tab1:AddDivider()

Tab1:AddDropdown("TargetPriority", {
    Text = "Target Priority",
    Values = {"Closest", "Closest In FOV", "Lowest HP"},
    Default = 1
})


local Drawing = Drawing or getgenv().Drawing

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.5
FOVCircle.NumSides = 64
FOVCircle.Radius = 150
FOVCircle.Filled = false
FOVCircle.Color = Color3.fromRGB(255, 0, 255)
FOVCircle.Visible = false

local InfoBox = Drawing.new("Square")
InfoBox.Size = Vector2.new(220, 90)
InfoBox.Color = Color3.fromRGB(0, 0, 0)
InfoBox.Transparency = 0.45
InfoBox.Filled = true
InfoBox.Visible = false

local InfoText = Drawing.new("Text")
InfoText.Size = 18
InfoText.Color = Color3.fromRGB(255, 0, 255)
InfoText.Outline = true
InfoText.Visible = false

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Toggles = getgenv().Toggles
local Options = getgenv().Options

local CurrentTarget = nil

local function GetChar(plr)
    if not plr.Character then return end
    local char = plr.Character
    return char, char:FindFirstChildOfClass("Humanoid"), char:FindFirstChild("HumanoidRootPart")
end

local function IsExcluded(plr)
    if not Toggles.ExcludePlayers.Value then return false end
    local list = Options.Exclusion.Value
    if type(list) == "table" then return list[plr.Name] end
    if type(list) == "string" then return list == plr.Name end
end

local function IsSameTeam(plr)
    return LocalPlayer.Team and plr.Team and LocalPlayer.Team == plr.Team
end

local function HasLineOfSight(origin, target)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Blacklist
    params.FilterDescendantsInstances = {LocalPlayer.Character}
    local result = workspace:Raycast(origin, (target - origin).Unit * 1000, params)
    return not result or (result.Position - target).Magnitude < 3
end

local function IsDead(plr)
    local _, hum = GetChar(plr)
    return not hum or hum.Health <= 0
end

local function WorldToScreen(pos)
    local p, vis = Camera:WorldToViewportPoint(pos)
    return Vector2.new(p.X, p.Y), vis
end

local function GetPriorityTarget()
    local priority = Options.TargetPriority.Value
    local fov = Options.FOVSize.Value
    local center = Camera.ViewportSize / 2

    local best = nil
    local bestValue = math.huge

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then

            if Toggles.TeamCheck.Value and IsSameTeam(plr) then continue end
            if Toggles.DeadCheck.Value and IsDead(plr) then continue end
            if IsExcluded(plr) then continue end

            local char, hum, root = GetChar(plr)
            if not char or not hum or not root then continue end

            local hit = char:FindFirstChild(Options.HitPart.Value) or root
            local screen, vis = WorldToScreen(hit.Position)
            if not vis then continue end

            if Toggles.WallCheck.Value and not HasLineOfSight(Camera.CFrame.Position, hit.Position) then continue end

            local dist = (screen - center).Magnitude

            if priority == "Closest" then
                if dist < bestValue then bestValue, best = dist, plr end

            elseif priority == "Closest In FOV" then
                if dist <= fov and dist < bestValue then bestValue, best = dist, plr end

            elseif priority == "Lowest HP" then
                if hum.Health < bestValue then bestValue, best = hum.Health, plr end
            end
        end
    end

    return best
end

local function UpdateInfo()
    if not Toggles.PlayerInfo.Value then
        InfoBox.Visible = false
        InfoText.Visible = false
        return
    end

    InfoBox.Visible = true
    InfoText.Visible = true

    local center = Camera.ViewportSize / 2
    local radius = Options.FOVSize.Value
    local y = center.Y + radius + 20

    InfoBox.Position = Vector2.new(center.X - 110, y)
    InfoText.Position = Vector2.new(center.X - 102, y + 8)

    local target = CurrentTarget or GetPriorityTarget()
    if not target or IsDead(target) then
        InfoText.Text = "NONE"
        return
    end

    local _, hum, root = GetChar(target)
    if not hum or not root then
        InfoText.Text = "NONE"
        return
    end

    local dist = (root.Position - Camera.CFrame.Position).Magnitude

    InfoText.Text = string.format(
        "Target: %s\nHealth: %d\nDistance: %d",
        target.Name,
        math.floor(hum.Health),
        math.floor(dist)
    )
end

local function AimAtTarget()
    if not CurrentTarget then return end
    if IsDead(CurrentTarget) then CurrentTarget = nil return end

    local char, hum, root = GetChar(CurrentTarget)
    local hit = char:FindFirstChild(Options.HitPart.Value) or root

    local predicted = hit.Position + hit.Velocity * Options.Prediction.Value
    local screen, vis = WorldToScreen(predicted)
    if not vis then return end

    local mouse = UserInputService:GetMouseLocation()
    local delta = (screen - mouse)

    local smooth = math.clamp(Options.Smoothness.Value, 0.01, 1)

    mousemoverel(delta.X * smooth, delta.Y * smooth)
end

RunService.RenderStepped:Connect(function()
    if not Toggles.EnableAimlock.Value then
        CurrentTarget = nil
        return
    end

    FOVCircle.Visible = Toggles.DrawFOV.Value
    if FOVCircle.Visible then
        FOVCircle.Radius = Options.FOVSize.Value
        FOVCircle.Color = Options.FOVColor.Value
        FOVCircle.Position = Camera.ViewportSize / 2
    end

    UpdateInfo()

    if Toggles.Aimbot.Value and Options.AimbotKey:GetState() then

        if Toggles.StickyAim.Value then
            if not CurrentTarget or IsDead(CurrentTarget) then
                CurrentTarget = GetPriorityTarget()
            end
        else
            CurrentTarget = GetPriorityTarget()
        end

        AimAtTarget()
    else
        CurrentTarget = nil
    end
end)







---------------------------------------------------------
-- LOAD ESP LIBRARY
---------------------------------------------------------
local ESP_SETTINGS = loadstring(game:HttpGet("https://raw.githubusercontent.com/linemaster2/esp-library/main/library.lua"))()

---------------------------------------------------------
-- UI TAB
---------------------------------------------------------


---------------------------------------------------------
-- MASTER TOGGLE
---------------------------------------------------------
Tab4:AddDivider()

local espToggle = Tab4:AddToggle('ESPEnabled', {
    Text = 'Enable ESP',
    Default = ESP_SETTINGS.Enabled
})
espToggle:OnChanged(function(v)
    ESP_SETTINGS.Enabled = v
end)

Tab4:AddDivider()

local teamToggle = Tab4:AddToggle('ESPTeamCheck', {
    Text = 'Team Check',
    Default = ESP_SETTINGS.Teamcheck
})
teamToggle:OnChanged(function(v)
    ESP_SETTINGS.Teamcheck = v
end)

---------------------------------------------------------
-- WALL CHECK
---------------------------------------------------------
local wallToggle = Tab4:AddToggle('ESPWallCheck', {
    Text = 'Wall Check',
    Default = ESP_SETTINGS.WallCheck
})
wallToggle:OnChanged(function(v)
    ESP_SETTINGS.WallCheck = v
end)

---------------------------------------------------------
-- DEAD CHECK
---------------------------------------------------------
local deadToggle = Tab4:AddToggle('ESPDeadCheck', {
    Text = 'Dead Check',
    Default = ESP_SETTINGS.DeadCheck or false
})
deadToggle:OnChanged(function(v)
    ESP_SETTINGS.DeadCheck = v
end)

Tab4:AddDivider()
---------------------------------------------------------
-- BOX TYPE DROPDOWN
---------------------------------------------------------
Tab4:AddDropdown('ESPBoxType', {
    Text = 'Box Type',
    Values = { "2D", "Corner Box Esp" },
    Default = ESP_SETTINGS.BoxType
})
Options.ESPBoxType:OnChanged(function(v)
    ESP_SETTINGS.BoxType = v
end)

Tab4:AddDivider()
---------------------------------------------------------
-- BOX ESP + COLOR
---------------------------------------------------------
local boxToggle = Tab4:AddToggle('ESPBox', {
    Text = 'Box ESP',
    Default = ESP_SETTINGS.ShowBox
})
boxToggle:AddColorPicker('ESPBoxColor', {
    Default = ESP_SETTINGS.BoxColor,
    Title = 'Box Color'
})
boxToggle:OnChanged(function(v)
    ESP_SETTINGS.ShowBox = v
end)
Options.ESPBoxColor:OnChanged(function(c)
    ESP_SETTINGS.BoxColor = c
end)

---------------------------------------------------------
-- NAME ESP + COLOR
---------------------------------------------------------
local nameToggle = Tab4:AddToggle('ESPName', {
    Text = 'Name ESP',
    Default = ESP_SETTINGS.ShowName
})
nameToggle:AddColorPicker('ESPNameColor', {
    Default = ESP_SETTINGS.NameColor,
    Title = 'Name Color'
})
nameToggle:OnChanged(function(v)
    ESP_SETTINGS.ShowName = v
end)
Options.ESPNameColor:OnChanged(function(c)
    ESP_SETTINGS.NameColor = c
end)

---------------------------------------------------------
-- HEALTH BAR + COLORS
---------------------------------------------------------
local healthToggle = Tab4:AddToggle('ESPHealth', {
    Text = 'Health Bar',
    Default = ESP_SETTINGS.ShowHealth
})
healthToggle:AddColorPicker('ESPHealthHigh', {
    Default = ESP_SETTINGS.HealthHighColor,
    Title = 'High HP Color'
})
healthToggle:AddColorPicker('ESPHealthLow', {
    Default = ESP_SETTINGS.HealthLowColor,
    Title = 'Low HP Color'
})
healthToggle:OnChanged(function(v)
    ESP_SETTINGS.ShowHealth = v
end)
Options.ESPHealthHigh:OnChanged(function(c)
    ESP_SETTINGS.HealthHighColor = c
end)
Options.ESPHealthLow:OnChanged(function(c)
    ESP_SETTINGS.HealthLowColor = c
end)

---------------------------------------------------------
-- DISTANCE ESP
---------------------------------------------------------
local distToggle = Tab4:AddToggle('ESPDistance', {
    Text = 'Distance ESP',
    Default = ESP_SETTINGS.ShowDistance
})
distToggle:OnChanged(function(v)
    ESP_SETTINGS.ShowDistance = v
end)

---------------------------------------------------------
-- TRACERS (NO COLOR PICKER)
---------------------------------------------------------
local tracerToggle = Tab4:AddToggle('ESPTracer', {
    Text = 'Tracer ESP',
    Default = ESP_SETTINGS.ShowTracer
})
tracerToggle:OnChanged(function(v)
    ESP_SETTINGS.ShowTracer = v
end)

Tab4:AddDivider()
---------------------------------------------------------
-- MAX DISTANCE SLIDER (FIXED)
---------------------------------------------------------
Tab4:AddSlider('ESPMaxDistance', {
    Text = 'Max Distance',
    Default = ESP_SETTINGS.MaxDistance or 1500,
    Min = 50,
    Max = 3000,
    Rounding = 0
})
Options.ESPMaxDistance:OnChanged(function(v)
    ESP_SETTINGS.MaxDistance = v
end)
Tab4:AddDivider()


---------------------------------------------------------
-- HOOK INTO YOUR ESP LOGIC
---------------------------------------------------------
getgenv().ESP_SETTINGS = ESP_SETTINGS












local HEAD_SIZE = 15
local Players = game:GetService("Players")
local PhysicsService = game:GetService("PhysicsService")

local localPlayer = Players.LocalPlayer
local collisionGroupName = "NoPlayerCollide"

pcall(function() PhysicsService:CreateCollisionGroup(collisionGroupName) end)
pcall(function() PhysicsService:CollisionGroupSetCollidable(collisionGroupName, collisionGroupName, false) end)
pcall(function() PhysicsService:CollisionGroupSetCollidable(collisionGroupName, "Default", false) end)

local function forceNoCollision(part)
    if not part:IsA("BasePart") then return end
    part.CanCollide = false
    pcall(function() part.CollisionGroup = collisionGroupName end)
    part.Changed:Connect(function(prop)
        if prop == "CanCollide" and part.CanCollide == true then
            part.CanCollide = false
        end
    end)
end

local function applyBigHead(character)
    if not character then return end
    local head = character:WaitForChild("Head", 3)
    if not head then return end

    head.Size = Vector3.new(HEAD_SIZE, HEAD_SIZE, HEAD_SIZE)
    head.Massless = true
    forceNoCollision(head)

    head.Changed:Connect(function(prop)
        if prop == "Size" and head.Size ~= Vector3.new(HEAD_SIZE, HEAD_SIZE, HEAD_SIZE) then
            head.Size = Vector3.new(HEAD_SIZE, HEAD_SIZE, HEAD_SIZE)
        end
    end)

    task.spawn(function()
        while head and head.Parent do
            head.Size = Vector3.new(HEAD_SIZE, HEAD_SIZE, HEAD_SIZE)
            task.wait(0.4)
        end
    end)
end

local function setupCharacter(character, player)
    if not character or not player then return end
    task.wait(0.6)

    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            forceNoCollision(part)
        end
    end

    if player ~= localPlayer then
        applyBigHead(character)
    end
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function(char)
        setupCharacter(char, player)
    end)
    if player.Character then
        setupCharacter(player.Character, player)
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

Players.PlayerAdded:Connect(onPlayerAdded)

getgenv().HITBOX_SETTINGS = {
    Enabled = false,
    ShowBox = false,
    BoxColor = Color3.fromRGB(255, 0, 0),
    SizeX = 15,
    SizeY = 15,
    SizeZ = 15,
}

---------------------------------------------------------
-- HITBOX UI (Tab2) — optimized
---------------------------------------------------------

Tab2:AddDivider()

local hbToggle = Tab2:AddToggle('HBEnabled', {
    Text = 'Enable Hitbox',
    Default = false
})
hbToggle:OnChanged(function(v)
    HITBOX_SETTINGS.Enabled = v
end)

local showBoxToggle = Tab2:AddToggle('HBShowBox', {
    Text = 'Show Hitbox 3D Chams',
    Default = false
})
showBoxToggle:OnChanged(function(v)
    HITBOX_SETTINGS.ShowBox = v
end)

Tab2:AddDivider()

-- LAZY-LOADED COLOR PICKER (only created when needed)
local hbColorPicker
showBoxToggle:OnChanged(function(v)
    HITBOX_SETTINGS.ShowBox = v

    if v and not hbColorPicker then
        hbColorPicker = showBoxToggle:AddColorPicker('HBBoxColor', {
            Default = HITBOX_SETTINGS.BoxColor,
            Title = 'Hitbox Cham Color'
        })

        Options.HBBoxColor:OnChanged(function(c)
            HITBOX_SETTINGS.BoxColor = c
        end)
    end
end)

Tab2:AddSlider('HBSizeX', {
    Text = 'X',
    Default = HITBOX_SETTINGS.SizeX,
    Min = 5,
    Max = 50,
    Rounding = 0
})
Options.HBSizeX:OnChanged(function(v)
    HITBOX_SETTINGS.SizeX = v
end)

Tab2:AddSlider('HBSizeY', {
    Text = 'Y',
    Default = HITBOX_SETTINGS.SizeY,
    Min = 5,
    Max = 50,
    Rounding = 0
})
Options.HBSizeY:OnChanged(function(v)
    HITBOX_SETTINGS.SizeY = v
end)

Tab2:AddSlider('HBSizeZ', {
    Text = 'Z',
    Default = HITBOX_SETTINGS.SizeZ,
    Min = 5,
    Max = 50,
    Rounding = 0
})
Options.HBSizeZ:OnChanged(function(v)
    HITBOX_SETTINGS.SizeZ = v
end)

Tab2:AddDivider()

---------------------------------------------------------
-- REAL 3D CHAMS USING BoxHandleAdornment
---------------------------------------------------------

local chamCache = {}

local function getCham(head)
    local existing = chamCache[head]
    if existing then return existing end

    local cham = Instance.new("BoxHandleAdornment")
    cham.Adornee = head
    cham.AlwaysOnTop = true
    cham.ZIndex = 10
    cham.Transparency = 0.95
    cham.Color3 = HITBOX_SETTINGS.BoxColor
    cham.Size = head.Size
    cham.Parent = head

    chamCache[head] = cham
    return cham
end

local function removeCham(head)
    local cham = chamCache[head]
    if cham then
        cham:Destroy()
        chamCache[head] = nil
    end
end

Players.PlayerRemoving:Connect(function(plr)
    local char = plr.Character
    if char then
        local head = char:FindFirstChild("Head")
        if head then
            removeCham(head)
        end
    end
end)

---------------------------------------------------------
-- MAIN LOOP (Hitbox + Chams)
---------------------------------------------------------

RunService.RenderStepped:Connect(function()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == localPlayer then continue end

        local char = plr.Character
        if not char then continue end

        local head = char:FindFirstChild("Head")
        if not head then continue end

        if not HITBOX_SETTINGS.Enabled then
            removeCham(head)
            head.Transparency = 0
            continue
        end

        -- INVISIBLE HITBOX
        head.Transparency = 1
        head.Size = Vector3.new(
            HITBOX_SETTINGS.SizeX,
            HITBOX_SETTINGS.SizeY,
            HITBOX_SETTINGS.SizeZ
        )

        -- REAL 3D CHAMS
        if HITBOX_SETTINGS.ShowBox then
            local cham = getCham(head)
            cham.Size = head.Size
            cham.Color3 = HITBOX_SETTINGS.BoxColor
            cham.Transparency = 0.95
            cham.Visible = true
        else
            removeCham(head)
        end
    end
end)


-- SETTINGS (used by your existing code)
HitIndicatorEnabled = true
HitIndicatorDuration = 1
HitIndicatorSpacing = 80
HitIndicatorColor = Color3.fromRGB(255, 105, 180)

Tab3:AddDivider()

Tab3:AddToggle("EnableHitIndicator", {
    Text = "Enable Hit notifications",
    Default = true,
    Callback = function(val)
        HitIndicatorEnabled = val
    end
})

Tab3:AddSlider("HitIndicatorDuration", {
    Text = "Fade Duration",
    Default = 1,
    Min = 0.1,
    Max = 3,
    Rounding = 1,
    Callback = function(val)
        HitIndicatorDuration = val
    end
})

Tab3:AddSlider("HitIndicatorSpacing", {
    Text = "Stack Spacing",
    Default = 80,
    Min = 20,
    Max = 200,
    Rounding = 0,
    Callback = function(val)
        HitIndicatorSpacing = val
    end
})


Tab3:AddDivider()

-- RIGHT SIDE 3/4 UP STACK UPWARD HIT INDICATOR (HUGE TEXT, 1 SEC)

local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local notifications = {}

local function HitText(msg)
    if not HitIndicatorEnabled then return end

    local text = Drawing.new("Text")
    text.Text = msg
    text.Size = 10000 -- stays huge
    text.Color = HitIndicatorColor -- now uses UI color
    text.Outline = true
    text.OutlineColor = Color3.fromRGB(0, 0, 0)
    text.Center = false
    text.Visible = true

    table.insert(notifications, {
        text = text,
        start = tick()
    })
end

RunService.RenderStepped:Connect(function()
    local screenX = Camera.ViewportSize.X
    local screenY = Camera.ViewportSize.Y

    for i, notif in ipairs(notifications) do
        
        -- SAME POSITIONING YOU MADE
        local x = screenX - 80
        local y = (screenY * 0.25) - ((i - 1) * HitIndicatorSpacing)

        notif.text.Position = Vector2.new(x, y)

        local age = tick() - notif.start
        if age >= HitIndicatorDuration then
            notif.text:Remove()
            table.remove(notifications, i)
        else
            local alpha = 1 - (age / HitIndicatorDuration)
            notif.text.Transparency = 1 - alpha
        end
    end
end)

--------------------------------------------------------------------
-- FIND HitRegistered EVENT
--------------------------------------------------------------------

local HitRegistered = nil

for _, obj in ipairs(game:GetDescendants()) do
    if obj.Name == "HitRegistered" and obj:IsA("BindableEvent") then
        HitRegistered = obj
        break
    end
end

--------------------------------------------------------------------
-- HOOK HIT EVENT (UNCHANGED)
--------------------------------------------------------------------

if HitRegistered then
    HitRegistered.Event:Connect(function(isHeadshot)
        if isHeadshot then
            HitText("HEADSHOT")
        else
            HitText("HIT")
        end
    end)
end




SOUND_LIBRARY = {
    ["Rust Headshot"] = "rbxassetid://5043539486",
    ["COD Hitmarker"] = "rbxassetid://160432334",
    ["Heavy Impact"] = "rbxassetid://12222005",
    ["Sharp Crack"] = "rbxassetid://4590657391",
    ["Clean Dink"] = "rbxassetid://9125640051"
}

-- SETTINGS USED BY YOUR EXISTING CODE
HitSoundsEnabled = true
SelectedHitSound = "Rust Headshot"
HitSoundVolume = 1

-- UI CONTROLS
Tab3:AddToggle("EnableHitSounds", {
    Text = "Enable Hit Sounds",
    Default = true,
    Callback = function(val)
        HitSoundsEnabled = val
    end
})

Tab3:AddDropdown("HitSoundDropdown", {
    Text = "Hit Sound",
    Values = {
        "Rust Headshot",
        "COD Hitmarker",
        "Heavy Impact",
        "Sharp Crack",
        "Clean Dink"
    },
    Default = "Rust Headshot",
    Callback = function(val)
        SelectedHitSound = val
    end
})

Tab3:AddSlider("HitSoundVolume", {
    Text = "Volume",
    Default = 1,
    Min = 0,
    Max = 5,
    Rounding = 1,
    Callback = function(val)
        HitSoundVolume = val
    end
})


Tab3:AddDivider()

local function playSound(id)
    if not HitSoundsEnabled then return end

    local s = Instance.new("Sound")
    s.SoundId = id
    s.Volume = HitSoundVolume
    s.PlayOnRemove = true
    s.Parent = workspace
    s:Destroy()
end

local HitRegistered

for _, obj in ipairs(game:GetDescendants()) do
    if obj.Name == "HitRegistered" and obj:IsA("BindableEvent") then
        HitRegistered = obj
        break
    end
end

if not HitRegistered then
    warn("1")
    return
end

HitRegistered.Event:Connect(function(isHeadshot)
    local soundId = SOUND_LIBRARY[SelectedHitSound]
    if soundId then
        playSound(soundId)
    end
end)





Tab5:AddLabel('SOON!!!')


local CrosshairSettings = {
    Enabled = false,
    Types = {}, -- multi-select
    Color = Color3.fromRGB(0, 170, 255),
    Size = 8,
    Transparency = 0.2,
    Spin = false,
    SpinSpeed = 2,
}



combat3:AddDivider()

-- Enable toggle
local enableCross = combat3:AddToggle("Cross_Enable", {
    Text = "Enable Crosshair",
    Default = false
})
enableCross:OnChanged(function(v)
    CrosshairSettings.Enabled = v
end)

-- Multi-select dropdown
combat3:AddDropdown("Cross_Type", {
    Text = "Crosshair Type",
    Multi = true,
    Values = { "Dot", "Lines", "Swastica" },
    AllowNull = true
})
Options.Cross_Type:OnChanged(function(v)
    CrosshairSettings.Types = v
end)

-- Color toggle + picker
local colorToggle = combat3:AddToggle("Cross_ColorToggle", {
    Text = "Enable Custom Color",
    Default = true
})
local colorPicker = colorToggle:AddColorPicker("Cross_Color", {
    Default = CrosshairSettings.Color
})
Options.Cross_Color:OnChanged(function(c)
    CrosshairSettings.Color = c
end)

-- Size slider
combat3:AddSlider("Cross_Size", {
    Text = "Size",
    Default = 8,
    Min = 2,
    Max = 40,
    Rounding = 0
})
Options.Cross_Size:OnChanged(function(v)
    CrosshairSettings.Size = v
end)

-- Transparency slider
combat3:AddSlider("Cross_Trans", {
    Text = "Transparency",
    Default = 0.2,
    Min = 0,
    Max = 1,
    Rounding = 2
})
Options.Cross_Trans:OnChanged(function(v)
    CrosshairSettings.Transparency = v
end)

-- Spin toggle
local spinToggle = combat3:AddToggle("Cross_Spin", {
    Text = "Spin Crosshair",
    Default = false
})
spinToggle:OnChanged(function(v)
    CrosshairSettings.Spin = v
end)

-- Spin speed slider
combat3:AddSlider("Cross_SpinSpeed", {
    Text = "Spin Speed",
    Default = 2,
    Min = 0,
    Max = 10,
    Rounding = 1
})
Options.Cross_SpinSpeed:OnChanged(function(v)
    CrosshairSettings.SpinSpeed = v
end)

combat3:AddDivider()
---------------------------------------------------------
-- CROSSHAIR DRAWING ENGINE
---------------------------------------------------------

local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local drawDot = Drawing.new("Circle")
drawDot.Filled = true
drawDot.Visible = false

local lines = {}
for i = 1, 4 do
    local l = Drawing.new("Line")
    l.Visible = false
    lines[i] = l
end

local swas = {}
for i = 1, 4 do
    local l = Drawing.new("Line")
    l.Visible = false
    swas[i] = l
end

local spinAngle = 0

RunService.RenderStepped:Connect(function(dt)
    if not CrosshairSettings.Enabled then
        drawDot.Visible = false
        for _, l in ipairs(lines) do l.Visible = false end
        for _, l in ipairs(swas) do l.Visible = false end
        return
    end

    local center = Camera.ViewportSize / 2
    local size = CrosshairSettings.Size
    local col = CrosshairSettings.Color
    local trans = 1 - CrosshairSettings.Transparency

    -- Spin
    if CrosshairSettings.Spin then
        spinAngle += dt * CrosshairSettings.SpinSpeed * 4
    end

    -----------------------------------------------------
    -- BLUE DOT
    -----------------------------------------------------
    if CrosshairSettings.Types["Dot"] then
        drawDot.Visible = true
        drawDot.Position = center
        drawDot.Radius = size
        drawDot.Color = col
        drawDot.Transparency = trans
    else
        drawDot.Visible = false
    end

    -----------------------------------------------------
    -- LINES
    -----------------------------------------------------
    if CrosshairSettings.Types["Lines"] then
        for i, l in ipairs(lines) do
            l.Visible = true
            l.Color = col
            l.Transparency = trans
            l.Thickness = 2

            local angle = math.rad((i - 1) * 90) + spinAngle
            local dx = math.cos(angle)
            local dy = math.sin(angle)

            l.From = center + Vector2.new(dx, dy) * (size * 1.5)
            l.To   = center + Vector2.new(dx, dy) * (size * 3)
        end
    else
        for _, l in ipairs(lines) do l.Visible = false end
    end

    -----------------------------------------------------
    -- SWASTICA STYLE
    -----------------------------------------------------
    if CrosshairSettings.Types["Swastica"] then
        for i, l in ipairs(swas) do
            l.Visible = true
            l.Color = col
            l.Transparency = trans
            l.Thickness = 2

            local angle = math.rad((i - 1) * 90) + spinAngle
            local dx = math.cos(angle)
            local dy = math.sin(angle)

            local base = center + Vector2.new(dx, dy) * (size * 2)
            local side = Vector2.new(-dy, dx) * (size * 1.5)

            l.From = base
            l.To = base + side
        end
    else
        for _, l in ipairs(swas) do l.Visible = false end
    end
end)

---------------------------------------------------------
-- SELF VISUALS CONFIG
---------------------------------------------------------

local SelfVis = {
    Enabled = false,
    Material = "ForceField",
    Transparency = 0,
    Glow = false,
    GlowSpeed = 5,
    Rainbow = false,
    Strobe = false,
    StrobeSpeed = 5,
    BodyColorEnabled = false,
    BodyColor = Color3.fromRGB(255, 0, 0)
}

---------------------------------------------------------
-- SELF VISUALS UI (PRO)
---------------------------------------------------------

visuals2:AddDivider()

local svToggle = visuals2:AddToggle("SV_Enable", {
    Text = "Enable Self Visuals",
    Default = false
})
svToggle:OnChanged(function(v)
    SelfVis.Enabled = v
end)

visuals2:AddDropdown("SV_Material", {
    Text = "Material",
    Values = { "ForceField", "Neon", "Plastic", "Glass", "SmoothPlastic", "Metal" },
    Default = "ForceField"
})
Options.SV_Material:OnChanged(function(v)
    SelfVis.Material = v
end)

visuals2:AddDivider()

visuals2:AddSlider("SV_Transparency", {
    Text = "Transparency",
    Default = 0,
    Min = 0.5,
    Max = 1,
    Rounding = 0.5
})
Options.SV_Transparency:OnChanged(function(v)
    SelfVis.Transparency = v
end)

local glowToggle = visuals2:AddToggle("SV_Glow", {
    Text = "Glow Effect",
    Default = false
})
glowToggle:OnChanged(function(v)
    SelfVis.Glow = v
end)

visuals2:AddSlider("SV_GlowSpeed", {
    Text = "Glow Speed",
    Default = 5,
    Min = 1,
    Max = 50,
    Rounding = 0
})
Options.SV_GlowSpeed:OnChanged(function(v)
    SelfVis.GlowSpeed = v
end)

local rainbowToggle = visuals2:AddToggle("SV_Rainbow", {
    Text = "Rainbow Effect",
    Default = false
})
rainbowToggle:OnChanged(function(v)
    SelfVis.Rainbow = v
end)

local strobeToggle = visuals2:AddToggle("SV_Strobe", {
    Text = "Strobe Effect",
    Default = false
})
strobeToggle:OnChanged(function(v)
    SelfVis.Strobe = v
end)

visuals2:AddSlider("SV_StrobeSpeed", {
    Text = "Strobe Speed",
    Default = 5,
    Min = 1,
    Max = 50,
    Rounding = 0
})
Options.SV_StrobeSpeed:OnChanged(function(v)
    SelfVis.StrobeSpeed = v
end)


visuals2:AddDivider()

local bodyColorToggle = visuals2:AddToggle("SV_BodyColorToggle", {
    Text = "Enable Body Color",
    Default = false
})
bodyColorToggle:OnChanged(function(v)
    SelfVis.BodyColorEnabled = v
end)

local bodyPicker = bodyColorToggle:AddColorPicker("SV_BodyColor", {
    Default = Color3.fromRGB(255, 0, 0)
})
Options.SV_BodyColor:OnChanged(function(c)
    SelfVis.BodyColor = c
end)

visuals2:AddDivider()

visuals2:AddButton("Delete Shirt", function()
    local char = workspace.Entities:FindFirstChild(game.Players.LocalPlayer.Name)
    if char then
        local shirt = char:FindFirstChildOfClass("Shirt")
        if shirt then shirt:Destroy() end
    end
end)

visuals2:AddButton("Delete Pants", function()
    local char = workspace.Entities:FindFirstChild(game.Players.LocalPlayer.Name)
    if char then
        local pants = char:FindFirstChildOfClass("Pants")
        if pants then pants:Destroy() end
    end
end)

visuals2:AddButton("Remove All Cosmetics", function()
    local char = workspace.Entities:FindFirstChild(game.Players.LocalPlayer.Name)
    if char then
        for _, v in ipairs(char:GetChildren()) do
            if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") then
                v:Destroy()
            end
        end
    end
end)


visuals2:AddDivider()
---------------------------------------------------------
-- SELF VISUALS ENGINE (WITH FULL RESET)
---------------------------------------------------------

local RunService = game:GetService("RunService")
local lp = game.Players.LocalPlayer

local function getChar()
    return workspace.Entities:FindFirstChild(lp.Name)
end

local glowPulse = 0
local strobeTimer = 0
local Original = {}

RunService.RenderStepped:Connect(function(dt)
    local char = getChar()
    if not char then return end

    -- RESET EVERYTHING WHEN DISABLED
    if not SelfVis.Enabled then
        for part, data in pairs(Original) do
            if part and part.Parent then
                part.Material = data.Material
                part.Color = data.Color
                part.Transparency = data.Transparency
                part.Reflectance = data.Reflectance
            end
        end
        return
    end

    -- APPLY VISUALS
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then

            -- SAVE ORIGINAL VALUES ONCE
            if not Original[part] then
                Original[part] = {
                    Material = part.Material,
                    Color = part.Color,
                    Transparency = part.Transparency,
                    Reflectance = part.Reflectance
                }
            end

            -- MATERIAL
            part.Material = Enum.Material[SelfVis.Material]

            -- TRANSPARENCY
            part.Transparency = SelfVis.Transparency

            -- BODY COLOR
            if SelfVis.BodyColorEnabled then
                part.Color = SelfVis.BodyColor
            end

            -- RAINBOW
            if SelfVis.Rainbow then
                part.Color = Color3.fromHSV((tick() * 0.2) % 1, 1, 1)
            end

            -- GLOW
            if SelfVis.Glow then
                glowPulse += dt * SelfVis.GlowSpeed
                local glow = (math.sin(glowPulse) + 1) / 2
                part.Color = part.Color:Lerp(Color3.new(1,1,1), glow * 0.5)
            end

            -- STROBE
            if SelfVis.Strobe then
                strobeTimer += dt * SelfVis.StrobeSpeed
                if math.floor(strobeTimer) % 2 == 0 then
                    part.Transparency = 0
                else
                    part.Transparency = 1
                end
            end
        end
    end
end)


local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer
local Toggles = getgenv().Toggles
local Options = getgenv().Options

local function GetChar()
    local char = LP.Character or LP.CharacterAdded:Wait()
    return char, char:WaitForChild("Humanoid"), char:WaitForChild("HumanoidRootPart")
end

---------------------------------------------------------------------
-- PLAYER MODS
---------------------------------------------------------------------

local PlayerMods = {
    Speedhack = {Enabled = false, Speed = 16},
    MegaJump = {Enabled = false, Height = 50},
    Noclip   = {Enabled = false},
    Spinbot  = {Enabled = false, Speed = 5},
    GhostFly = {Enabled = false, Speed = 3},
}


moveTab:AddDivider()

-- SPEEDHACK
local speedToggle = moveTab:AddToggle("Speedhack_Toggle", {
    Text = "Speedhack",
    Default = false,
    Callback = function(v)
        PlayerMods.Speedhack.Enabled = v
    end
})

speedToggle:AddKeyPicker("Speedhack_Key", {
    Default = "NONE",
    Mode = "Toggle",
    Text = "speedhack"
})

moveTab:AddSlider("Speedhack_Slider", {
    Text = "Speed",
    Min = 1,
    Max = 40,
    Default = 16,
    Rounding = 1,
    Callback = function(v)
        PlayerMods.Speedhack.Speed = v
    end
})

-- MEGA JUMP
local mjToggle = moveTab:AddToggle("MegaJump_Toggle", {
    Text = "Mega Jump",
    Default = false,
    Callback = function(v)
        PlayerMods.MegaJump.Enabled = v
    end
})

mjToggle:AddKeyPicker("MegaJump_Key", {
    Default = "NONE",
    Mode = "Toggle",
    Text = "Mega Jump"
})

moveTab:AddSlider("MegaJump_Slider", {
    Text = "Jump Height",
    Min = 20,
    Max = 200,
    Default = 50,
    Rounding = 1,
    Callback = function(v)
        PlayerMods.MegaJump.Height = v
    end
})

-- NOCLIP
local ncToggle = moveTab:AddToggle("Noclip_Toggle", {
    Text = "Noclip",
    Default = false,
    Callback = function(v)
        PlayerMods.Noclip.Enabled = v
    end
})

ncToggle:AddKeyPicker("Noclip_Key", {
    Default = "NONE",
    Mode = "Toggle",
    Text = "noclip"
})

-- SPINBOT
local sbToggle = moveTab:AddToggle("Spinbot_Toggle", {
    Text = "Spinbot",
    Default = false,
    Callback = function(v)
        PlayerMods.Spinbot.Enabled = v
    end
})

sbToggle:AddKeyPicker("Spinbot_Key", {
    Default = "NONE",
    Mode = "Toggle",
    Text = "spinbot"
})

moveTab:AddSlider("Spinbot_Slider", {
    Text = "Spin Speed",
    Min = 1,
    Max = 30,
    Default = 5,
    Rounding = 1,
    Callback = function(v)
        PlayerMods.Spinbot.Speed = v
    end
})

-- GHOST FLY
local gfToggle = moveTab:AddToggle("GhostFly_Toggle", {
    Text = "Ghost Fly",
    Default = false,
    Callback = function(v)
        PlayerMods.GhostFly.Enabled = v
    end
})

gfToggle:AddKeyPicker("GhostFly_Key", {
    Default = "NONE",
    Mode = "Toggle",
    Text = "gfly"
})

moveTab:AddSlider("GhostFly_Slider", {
    Text = "Fly Speed",
    Min = 1,
    Max = 20,
    Default = 3,
    Rounding = 1,
    Callback = function(v)
        PlayerMods.GhostFly.Speed = v
    end
})

moveTab:AddDivider()
---------------------------------------------------------------------
-- KEYBIND LOGIC (USES KEYPICKERS, SAME PATTERN AS AIMBOT)
---------------------------------------------------------------------

UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

    for name, mod in pairs(PlayerMods) do
        local opt = Options[name .. "_Key"]
        if opt then
            local key = opt.Value
            if key ~= "NONE" and input.KeyCode == Enum.KeyCode[key] then
                local new = not mod.Enabled
                mod.Enabled = new

                local toggle = Toggles[name .. "_Toggle"]
                if toggle then
                    toggle:SetValue(new)
                end
            end
        end
    end
end)

---------------------------------------------------------------------
-- MOVEMENT LOGIC
---------------------------------------------------------------------

-- SPEEDHACK
RunService.RenderStepped:Connect(function()
    local _, hum = GetChar()
    hum.WalkSpeed = PlayerMods.Speedhack.Enabled and PlayerMods.Speedhack.Speed or 16
end)

-- MEGA JUMP
UIS.JumpRequest:Connect(function()
    if PlayerMods.MegaJump.Enabled then
        local _, hum, hrp = GetChar()
        hum:ChangeState("Jumping")
        hrp.Velocity = Vector3.new(hrp.Velocity.X, PlayerMods.MegaJump.Height, hrp.Velocity.Z)
    end
end)

-- NOCLIP
RunService.Stepped:Connect(function()
    if PlayerMods.Noclip.Enabled then
        local char = LP.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- SPINBOT
RunService.RenderStepped:Connect(function()
    if PlayerMods.Spinbot.Enabled then
        local char = LP.Character
        if not char then return end

        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame *= CFrame.Angles(0, math.rad(PlayerMods.Spinbot.Speed), 0)
        end
    end
end)

-- GHOST FLY
local flying = false
local ghost = nil

local function makeGhost()
    local g = Instance.new("Part")
    g.Size = Vector3.new(2,2,2)
    g.Transparency = 1
    g.CanCollide = false
    g.Anchored = true

    local _, _, hrp = GetChar()
    g.CFrame = hrp.CFrame
    g.Parent = workspace
    return g
end

RunService.RenderStepped:Connect(function()
    if PlayerMods.GhostFly.Enabled and not flying then
        flying = true
        local _, hum, hrp = GetChar()
        hum.PlatformStand = true
        hrp.Anchored = true

        ghost = makeGhost()
        workspace.CurrentCamera.CameraSubject = ghost
    end

    if not PlayerMods.GhostFly.Enabled and flying then
        flying = false
        local _, hum, hrp = GetChar()

        if ghost then hrp.CFrame = ghost.CFrame end

        hrp.Anchored = false
        hum.PlatformStand = false
        workspace.CurrentCamera.CameraSubject = hum

        if ghost then ghost:Destroy() ghost = nil end
    end
end)

RunService.RenderStepped:Connect(function()
    if flying and ghost then
        local cam = workspace.CurrentCamera
        local move = Vector3.zero
        local speed = PlayerMods.GhostFly.Speed

        if UIS:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then move *= 2 end

        if move.Magnitude > 0 then
            ghost.CFrame += move.Unit * speed
        end
    end
end)







































































Library:SetWatermarkVisibility(true)
Library:Notify("Syrift.lua - The Armory - free keyless", 10) -- Text, Time
Library:SetWatermark('Syrift.lua - The Armory - discord.gg/ws9sW2xk27')
Library.KeybindFrame.Visible = true;
Library:OnUnload(function()
    print('Unloaded!')
    Library.Unloaded = true
end)
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })
Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('Syrift')
SaveManager:SetFolder('Syrift/The Armory')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])
SaveManager:LoadAutoloadConfig()
