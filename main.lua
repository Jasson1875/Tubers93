-- Importieren der Orion Library
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Erstellen des Fensters
local Window = OrionLib:MakeWindow({
    Name = "Tubers93 Hub | Brookhaven RP | Executor: Solara",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "OrionTest"
})

-- === Informationen Tab ===
local InfoTab = Window:MakeTab({
    Name = "Information",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Informationen hinzufügen
InfoTab:AddLabel("Danke, dass du meine Skripte nutzt!")
InfoTab:AddLabel("Version: V1.05")

-- Owner-Section
local ownerSection = InfoTab:AddSection({ Name = "Owner" })
ownerSection:AddLabel("Owner: Jasson1875")
ownerSection:AddLabel("Tiktok: deakerk18")

-- Designer-Section
local designerSection = InfoTab:AddSection({ Name = "Designer" })
designerSection:AddLabel("Designer: Noobie22152")

-- Hier kannst du weiterhin Tabs und deren Funktionen hinzufügen


-- TAB NUMMER EINS (ANFANG)
local Tab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Tab:AddSlider({
    Name = "Walkspeed",
    Min = 1,
    Max = 1000,
    Default = 16, 
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 1,
    ValueName = "Walkspeed",
    Callback = function(Value)
        local localPlayer = game:GetService("Players").LocalPlayer
        local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = Value
        end
    end
})

local localPlayer = game:GetService("Players").LocalPlayer
local uis = game:GetService("UserInputService")
local isRunning = false
local multiplier = 1

task.spawn(function()
    local hint = Instance.new("Hint", workspace)
    hint.Text = "Speed Loaded by Tubers93"
    task.wait(2)
    hint:Destroy()
end)

uis.InputBegan:Connect(function(i, gp)
    if gp then return end
    if i.KeyCode == Enum.KeyCode.Q then
        isRunning = true
        while isRunning do
            task.wait()
            local character = localPlayer.Character
            local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                humanoidRootPart.CFrame = humanoidRootPart.CFrame + humanoidRootPart.CFrame.LookVector * multiplier
            end
        end
    end
end)

uis.InputEnded:Connect(function(i, gp)
    if gp then return end
    if i.KeyCode == Enum.KeyCode.Q then
        isRunning = false
    end
end)
local observing = false
local selectedPlayer = nil
local camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Section = Tab:AddSection({
    Name = "Player view"
})

local observing = false
local selectedPlayer = nil
local camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
Tab:AddTextbox({
    Name = "Player",
    Default = "input",
    TextDisappear = true,
    Callback = function(Value)
        local player = Players:FindFirstChild(Value)
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            selectedPlayer = player
            print("Selected player: " .. Value)
        else
            print("Player not found or player has no character")
        end
    end
})

Tab:AddToggle({
	Name = "View",
	Default = false,
	Callback = function(Value)
		observing = Value

        if observing and selectedPlayer then
            camera.CameraSubject = selectedPlayer.Character.Humanoid
            camera.CameraType = Enum.CameraType.Attach
            print("Observing player: " .. selectedPlayer.Name)

            local function onInput(input, gameProcessedEvent)
                if gameProcessedEvent then return end
                if input.KeyCode == Enum.KeyCode.Escape then
                    camera.CameraSubject = LocalPlayer.Character:FindFirstChild("Humanoid")
                    camera.CameraType = Enum.CameraType.Custom
                    UserInputService.InputBegan:Disconnect(onInput)
                    print("Observation cancelled, back to own character")
                end
            end

            UserInputService.InputBegan:Connect(onInput)
        else
            camera.CameraSubject = LocalPlayer.Character:FindFirstChild("Humanoid")
            camera.CameraType = Enum.CameraType.Custom
            print("Stopped observing, back to own character")
        end
	end    
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Section = Tab:AddSection({
    Name = "Player TP"
})
Tab:AddTextbox({
    Name = "Username",
    Default = "Input",
    TextDisappear = true,
    Callback = function(Value)
        SelectedPlayer = Value
    end	  
})

Tab:AddButton({
    Name = "Teleport",
    Callback = function()
        local targetPlayer = Players:FindFirstChild(SelectedPlayer)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
        else
            print("Spieler nicht gefunden oder der Spieler hat keinen Charakter.")
        end
    end
})
 
-- ESP Script (ANFANG)

local Section = Tab:AddSection({
    Name = "ESP"
})

local ESPEnabled = false
local FillTransparency = 0.5

local function EnableESP()
    local FillColor = Color3.fromRGB(175, 25, 255)
    local DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    local OutlineColor = Color3.fromRGB(255, 255, 255)
    local OutlineTransparency = 0

    local CoreGui = game:GetService("CoreGui")
    local Players = game:GetService("Players")
    local connections = {}

    local Storage = Instance.new("Folder")
    Storage.Parent = CoreGui
    Storage.Name = "Highlight_Storage"

    local function Highlight(plr)
        local Highlight = Instance.new("Highlight")
        Highlight.Name = plr.Name
        Highlight.FillColor = FillColor
        Highlight.DepthMode = DepthMode
        Highlight.FillTransparency = FillTransparency
        Highlight.OutlineColor = OutlineColor
        Highlight.OutlineTransparency = OutlineTransparency
        Highlight.Parent = Storage

        local plrchar = plr.Character
        if plrchar then
            Highlight.Adornee = plrchar
        end

        connections[plr] = plr.CharacterAdded:Connect(function(char)
            Highlight.Adornee = char
        end)
    end

    Players.PlayerAdded:Connect(Highlight)
    for i, v in next, Players:GetPlayers() do
        Highlight(v)
    end

    Players.PlayerRemoving:Connect(function(plr)
        local plrname = plr.Name
        if Storage:FindFirstChild(plrname) then
            Storage[plrname]:Destroy()
        end
        if connections[plr] then
            connections[plr]:Disconnect()
        end
    end)
end

local function DisableESP()
    local CoreGui = game:GetService("CoreGui")
    local Storage = CoreGui:FindFirstChild("Highlight_Storage")
    if Storage then
        Storage:Destroy()
    end
    ESPEnabled = false
end


Tab:AddButton({
    Name = "Enable ESP",
    Callback = function()
        if not ESPEnabled then
            EnableESP()
            ESPEnabled = true
        end
    end
})

Tab:AddSlider({
    Name = "Fill Transparency",
    Min = 0,
    Max = 1,
    Default = 0.5,
    Color = Color3.fromRGB(175, 25, 255),
    Increment = 0.05,
    Callback = function(value)
        FillTransparency = value
        if ESPEnabled then
            local CoreGui = game:GetService("CoreGui")
            local Storage = CoreGui:FindFirstChild("Highlight_Storage")
            if Storage then
                for _, highlight in pairs(Storage:GetChildren()) do
                    if highlight:IsA("Highlight") then
                        highlight.FillTransparency = FillTransparency
                    end
                end
            end
        end
    end
})

Tab:AddButton({
    Name = "Disable ESP",
    Callback = function()
        if ESPEnabled then
            DisableESP()
        end
    end
})
-- TAB NUMMER ZWEI (ANFANG)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer


local Tab = Window:MakeTab({
    Name = "Player",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local function resetCharacterByKilling()
    local Character = LocalPlayer.Character
    if Character then
        local humanoid = Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = 0
        end
    end
end

Tab:AddLabel("Reset Character:")

Tab:AddButton({
    Name = "Reset by Kill",
    Callback = function()
        resetCharacterByKilling()
    end
})

local Section = Tab:AddSection({
    Name = "Skin Rainbow"
})

local colors = {
    "Earth green",
    "Magenta",
    "Maroon",
    "Toothpaste",
    "Institutional white"
}

local isAutoColorEnabled = false

local function AutoColorToggle(toggleValue)
    isAutoColorEnabled = toggleValue

    if not toggleValue then
        return
    end

    local index = 1
    while isAutoColorEnabled do
        local args = {
            [1] = "skintone",
            [2] = colors[index]
        }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Updat1eAvata1r"):FireServer(unpack(args))
        index = index % #colors + 1
        wait(0.3)
    end
end

Tab:AddToggle({
    Name = "Rainbow Skin",
    Default = false,
    Callback = function(Value)
        AutoColorToggle(Value)
    end
})

local Section = Tab:AddSection({
    Name = "Avatar Size"
})

local function setAvatarSize(sizeMultiplier)
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

    if Character then
        for _, part in ipairs(Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Size = part.Size * sizeMultiplier
            end
        end
    end
end

local function resetAvatarSize()
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

    if Character then
        for _, part in ipairs(Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Size = Vector3.new(2, 2, 1) 
            end
        end
    end
end

local function setSmallAvatar()
    setAvatarSize(0.5) -- Klein
end

local function setMediumAvatar()
    setAvatarSize(1) -- Mittel
end

local function setBigAvatar()
    setAvatarSize(2) -- Groß
end

Tab:AddButton({
    Name = "Small",
    Callback = function()
        setSmallAvatar()
    end
})

Tab:AddButton({
    Name = "Medium",
    Callback = function()
        setMediumAvatar()
    end
})

Tab:AddButton({
    Name = "Big",
    Callback = function()
        setBigAvatar()
    end
})

Tab:AddButton({
    Name = "Refresh",
    Callback = function()
        resetAvatarSize()
    end
})

local Section = Tab:AddSection({
    Name = "[FE] Headless"
})

Tab:AddButton({
    Name = "Headless",
    Callback = function()
        local args = {
            [1] = "CharacterChange",
            [2] = {
                [1] = 1,
                [2] = 1,
                [3] = 1,
                [4] = 1,
                [5] = 1,
                [6] = 134082579
            },
            [3] = "by Jasson1875"
        }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Avata1rOrigina1l"):FireServer(unpack(args))
    end
})

-- TAB NUMMER DREI (ANFANG)
local Tab = Window:MakeTab({
    Name = "House",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local houseNumber = ""

Tab:AddTextbox({
    Name = "House Number",
    Default = "",
    TextDisappear = true,
    Callback = function(Value)
        houseNumber = Value
    end    
})

Tab:AddButton({
    Name = "Get Permission",
    Callback = function()
        local function executePermissionCode()
            local args = {
                [1] = "GivePermissionLoopToServer",
                [2] = game.Players.LocalPlayer,
                [3] = tonumber(houseNumber)  
            }

            local event = game:GetService("ReplicatedStorage"):FindFirstChild("RE"):FindFirstChild("1Playe1rTrigge1rEven1t")
            if event then
                event:FireServer(unpack(args))
            else
                warn("Event '1Playe1rTrigge1rEven1t' nicht gefunden.")
            end
        end

        executePermissionCode()
    end
})
 
local Section = Tab:AddSection({
    Name = "House Fire"
})

Tab:AddButton({
    Name = "Fire ON",
    Description = "Ativa o Fogo da casa",
    Callback = function()
        local args = {
            [1] = "PlayerWantsFireOnFirePassNotShowingAnyone"
        }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Player1sHous1e"):FireServer(unpack(args))
    end
})

Tab:AddButton({
    Name = "Fire OFF",
    Description = "Desativa o Fogo da casa",
    Callback = function()
        local args = {
            [1] = "PlayerWantsFireOffFirePass"
        }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Player1sHous1e"):FireServer(unpack(args))
    end
})

local Section = Tab:AddSection({
    Name = "coming coon"
})

local Section = Tab:AddSection({
    Name = "coming coon"
})

local Section = Tab:AddSection({
    Name = "coming coon"
})

local Section = Tab:AddSection({
    Name = "coming coon"
})

local Section = Tab:AddSection({
    Name = "coming coon"
})

local Section = Tab:AddSection({
    Name = "coming coon"
})

-- TAB NUMMER VIER (ANFANG)
local Tab = Window:MakeTab({
	Name = "Cars",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Tab:AddSection({
    Name = "coming coon"
})

local Section = Tab:AddSection({
    Name = "coming coon"
})

local Section = Tab:AddSection({
    Name = "coming coon"
})
local Section = Tab:AddSection({
    Name = "coming coon"
})

-- TAB NUMMER FÜNF (ANFANG)
local Tab = Window:MakeTab({
    Name = "Teleport",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local function addButton(tab, name, position)
    tab:AddButton({
        Name = name,
        Callback = function()
            local Players = game:GetService("Players")
            local localPlayer = Players.LocalPlayer
            local camera = game.Workspace.CurrentCamera
            
            local function teleportLocalPlayer()
                if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local originalCameraCFrame = camera.CFrame
                    localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position)
                    camera.CFrame = originalCameraCFrame
                end
            end

            teleportLocalPlayer()
        end
    })
end

local Section = Tab:AddSection({
    Name = "All"
})

addButton(Tab, "Spawn", Vector3.new(0, 3, 0))
addButton(Tab, "Bank", Vector3.new(-1.25, 3.19, 246.87))
addButton(Tab, "Rockstar", Vector3.new(-41.16, 3.19, 246.40))
addButton(Tab, "Dentiste", Vector3.new(-57.78, 20.69, 270.43))
addButton(Tab, "Shelter", Vector3.new(-89.07, 20.59, 264.91))
addButton(Tab, "Starbrooks Coffee", Vector3.new(-96.15, 3.19, 249.44))
addButton(Tab, "Library", Vector3.new(-130.07, 3.19, 248.89))
addButton(Tab, "Little Shop", Vector3.new(-129.40, 19.79, 245.20))
addButton(Tab, "Post Office", Vector3.new(-161.89, 3.19, 260.90))
addButton(Tab, "Car Dealership", Vector3.new(-171.43, 19.69, 269.25))
addButton(Tab, "Laudromat", Vector3.new(-170.84, 19.79, 283.87))
addButton(Tab, "School", Vector3.new(-322.07, 3.29, 211.58))
addButton(Tab, "Hospital", Vector3.new(-302.25, 3.17, 30.32))
addButton(Tab, "Secret Light 1", Vector3.new(-529.63, -0.95, 903.03))
addButton(Tab, "Camping House Secret", Vector3.new(-273.48, 22.68, 1107.28))
addButton(Tab, "Solar Panel House", Vector3.new(232.33, 3.33, 811.68))
addButton(Tab, "Bank Access Card", Vector3.new(6.52, 3.19, 271.10))
addButton(Tab, "Scary Hospital", Vector3.new(-335.22, 16.27, 79.60))
addButton(Tab, "Solar Panel House Access Card", Vector3.new(-114.13, 19.08, 34.35))
addButton(Tab, "Police Tower Hide", Vector3.new(-145.52, 21.08, 3.86))
addButton(Tab, "Food Mart Hide", Vector3.new(158.64, 4.09, -380.94))

local Section = Tab:AddSection({
    Name = "House"
})

addButton(Tab, "House #1", Vector3.new(268.38, 3.49, 126.20))
addButton(Tab, "House #2", Vector3.new(244.10, 3.49, 150.79))
addButton(Tab, "House #3", Vector3.new(223.57, 3.49, 171.73))


-- TAB NUMMER SECHS (ANFANG)
local Tab = Window:MakeTab({
	Name = "Other Scripts",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddButton({
    Name = "Infinite yield",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
    })

-- TAB NUMMER SIEBEN (ANFANG)
local Tab = Window:MakeTab({
    Name = "Updates",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Section = Tab:AddSection({
    Name = "Discord"
})

Tab:AddLabel("https://discord.gg/tmJ7fqc8j4")
