-- Load the Rayfield library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

print("The menu is running for Rivals")

-- Create GUI window
local Window = Rayfield:CreateWindow({
    Name = "Rivals Aimbot",
    Icon = 0,
    LoadingTitle = "Rivals Cheats",
    LoadingSubtitle = "by Drizzle and Wafle",
    Theme = "AmberGlow",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "Rivals Hub"
    },
    Discord = {
        Enabled = true,
        Invite = "uhcbF5HtC3",
        RememberJoins = true
    },
    KeySystem = true,
    KeySettings = {
        Title = "Rivals Key System",
        Subtitle = "Key System",
        Note = "Best Paid UD Rivals Cheat DRIZOID",
        FileName = "KeyLogger",
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = {"DrizoidRivals723"}
    }
})

-- Create "Aimbot" tab
local AimbotTab = Window:CreateTab("Aimbot", 4483362458)

-- Create "ESP" tab
local ESPTab = Window:CreateTab("ESP", 4483362458)

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local camera = workspace.CurrentCamera

-- Variables
local player = Players.LocalPlayer
local lockedTarget = nil
local lockEnabled = false
local ESPEnabled = false
local FOVRadius = 90  -- FOV circle size in pixels (initial value)
local ESPObjects = {}
local FOVCircle = nil  -- FOV Circle Drawing Object

-- Function to create ESP box around hitbox (HumanoidRootPart)
local function createESP(player)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        return
    end

    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        -- Create ESP box around the hitbox (HumanoidRootPart)
        local box = Drawing.new("Square")
        box.Size = Vector2.new(50, 100)  -- Size of the box (adjust as needed)
        box.Position = camera:WorldToViewportPoint(humanoidRootPart.Position)
        box.Color = Color3.fromRGB(255, 0, 0)  -- Red color
        box.Thickness = 2
        box.Visible = true

        -- Update box position continuously
        local connection
        connection = RunService.RenderStepped:Connect(function()
            if ESPEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local rootPartPosition = camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                box.Position = Vector2.new(rootPartPosition.X - box.Size.X / 2, rootPartPosition.Y - box.Size.Y / 2)
            else
                box.Visible = false
                connection:Disconnect()  -- Disconnect the connection when no longer needed
            end
        end)

        -- Store box for later removal
        table.insert(ESPObjects, box)
    end
end

-- Function to remove all ESP boxes
local function removeESP()
    for _, obj in pairs(ESPObjects) do
        obj.Visible = false
        obj:Remove()  -- Clean up the drawing object
    end
    ESPObjects = {}  -- Clear the stored objects
end

-- Toggle ESP Visibility
local function toggleESP()
    ESPEnabled = not ESPEnabled
    print("ESP Enabled: " .. tostring(ESPEnabled))

    if ESPEnabled then
        -- Loop through all players and enable their ESP
        for _, otherPlayer in pairs(Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
                createESP(otherPlayer)
            end
        end
    else
        -- Remove all ESP
        removeESP()
    end
end

-- Aimbot Features
local function isValidTarget(targetPlayer)
    if targetPlayer == player then return false end  -- Ignore self

    -- Ignore specific players "Luna_Exec" and "Progamer_thebest5"
    if targetPlayer.Name == "Luna_Exec" or targetPlayer.Name == "Progamer_thebest5" then
        return false  -- Ignore these players
    end

    -- Check if the player is on a different team
    if player.Team ~= nil and targetPlayer.Team ~= nil then
        -- Ignore teammates (if teams exist)
        if player.Team == targetPlayer.Team then
            return false  -- Ignore teammates
        end
    end

    local character = targetPlayer.Character
    if not character or not character:FindFirstChild("Humanoid") or character.Humanoid.Health <= 0 then
        return false  -- Ignore dead players
    end
    return true
end

-- Function to find the closest valid enemy player
local function getClosestPlayer()
    local closest = nil
    local shortestDistance = math.huge

    if not player.Character or not player.Character:FindFirstChild("Head") then
        return nil
    end

    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if isValidTarget(otherPlayer) then
            local character = otherPlayer.Character
            local head = character and character:FindFirstChild("Head")
            if head then
                local distance = (head.Position - player.Character.Head.Position).Magnitude
                if distance < shortestDistance then
                    closest = head
                    shortestDistance = distance
                end
            end
        end
    end
    return closest
end

-- Function to toggle Aimbot
local function toggleLockOn()
    if lockEnabled then
        lockEnabled = false
        lockedTarget = nil
    else
        local target = getClosestPlayer()
        if target then
            lockedTarget = target
            lockEnabled = true
        end
    end
end

-- Update camera to follow locked target
RunService.RenderStepped:Connect(function()
    if lockEnabled and lockedTarget then
        if not lockedTarget.Parent or not lockedTarget.Parent:FindFirstChild("Humanoid") or lockedTarget.Parent.Humanoid.Health <= 0 then
            lockEnabled = false  -- Disable lock if the target dies
            lockedTarget = nil
            return
        end
        camera.CFrame = CFrame.lookAt(camera.CFrame.Position, lockedTarget.Position)
    end
end)

-- Draw FOV Circle on screen
local function createFOVCircle()
    if FOVCircle then
        FOVCircle.Visible = false
        FOVCircle:Remove()
    end
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Radius = FOVRadius
    FOVCircle.Position = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    FOVCircle.Color = Color3.fromRGB(255, 0, 0)  -- Red color
    FOVCircle.Thickness = 2
    FOVCircle.Filled = false
    FOVCircle.Visible = true

    -- Update FOV Circle position continuously
    RunService.RenderStepped:Connect(function()
        if FOVCircle then
            FOVCircle.Position = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
        end
    end)
end

-- Listen for RMB hold to toggle Aimbot
local RMBHeld = false
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then  -- RMB held
        RMBHeld = true
        toggleLockOn()
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then  -- RMB released
        RMBHeld = false
        lockEnabled = false  -- Disable lock when RMB is released
        lockedTarget = nil
    end
end)

-- FOV Slider (Updated to use pixels)
AimbotTab:CreateSlider({
    Name = "Adjust FOV Circle Size (px)",
    Range = {50, 500},  -- Size range in pixels
    Increment = 5,
    Suffix = "px",
    CurrentValue = FOVRadius,  -- Initial value for FOVRadius
    Flag = "FOVSlider",  -- Unique identifier for the slider
    Callback = function(Value)
        FOVRadius = Value  -- Update the FOV radius based on the slider value
        if FOVCircle then
            FOVCircle.Radius = FOVRadius  -- Update the FOV circle's radius
        end
        print("FOV Radius Set to: " .. FOVRadius .. "px")
    end
})

-- Aimbot Buttons
AimbotTab:CreateButton({
    Name = "Toggle Aimbot (Hold RMB)",
    Callback = function()
        toggleLockOn()
    end
})

AimbotTab:CreateButton({
    Name = "Lock to Closest Target",
    Callback = function()
        local closestTarget = getClosestPlayer()
        if closestTarget then
            lockedTarget = closestTarget
            lockEnabled = true
            print("Locked onto target: " .. closestTarget.Parent.Name)
        else
            print("No valid target found.")
        end
    end
})

AimbotTab:CreateButton({
    Name = "Enable FOV Circle",
    Callback = function()
        createFOVCircle()
    end
})

AimbotTab:CreateButton({
    Name = "Toggle ESP",
    Callback = function()
        toggleESP()
    end
})

-- ESP Toggle Switch in the ESP Tab
ESPTab:CreateToggle({
    Name = "Enable ESP",
    Default = false,
    Callback = function(state)
        ESPEnabled = state
        if ESPEnabled then
            -- Loop through all players and enable their ESP
            for _, otherPlayer in pairs(Players:GetPlayers()) do
                if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    createESP(otherPlayer)
                end
            end
        else
            -- Remove all ESP
            removeESP()
        end
    end
})

-- Notification
Rayfield:Notify({
    Title = "Rivals Cheat Loaded",
    Content = "Aimbot (Hold RMB), FOV Circle, and ESP Ready",
    Duration = 6.5,
    Image = 4483362458,
})
