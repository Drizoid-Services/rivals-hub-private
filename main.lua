-- List of valid keys for Drizoid
local validKeys = {
    "DrizoidRivals723",  -- Example valid key
    "Wafle1kdono"       -- Another valid key
}

-- Function to validate the entered key
local function validateKey(inputKey)
    for _, key in ipairs(validKeys) do
        if inputKey == key then
            return true
        end
    end
    return false
end

-- Function to load the main cheat script
local function loadCheatScript()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Drizoid-Services/rivals-hub-private/main/drizoid.lua"))()
    end)

    if not success then
        print("Error loading script: " .. err)
        game:GetService("Players").LocalPlayer:Kick("Failed to load the script.")
    end
end

-- Function to create the key prompt GUI
local function createKeyPrompt()
    local player = game.Players.LocalPlayer
    local gui = Instance.new("ScreenGui", player.PlayerGui)
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 300, 0, 150)
    frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    local textBox = Instance.new("TextBox", frame)
    textBox.Size = UDim2.new(0, 250, 0, 30)
    textBox.Position = UDim2.new(0, 25, 0, 40)
    textBox.PlaceholderText = "Enter Drizoid key here"
    textBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local submitButton = Instance.new("TextButton", frame)
    submitButton.Size = UDim2.new(0, 100, 0, 30)
    submitButton.Position = UDim2.new(0.5, -50, 0, 80)
    submitButton.Text = "Submit"
    submitButton.BackgroundColor3 = Color3.fromRGB(60, 120, 255)

    -- Submit button logic
    submitButton.MouseButton1Click:Connect(function()
        local inputKey = textBox.Text
        if validateKey(inputKey) then
            print("Key accepted. Loading script...")
            gui:Destroy()  -- Remove the GUI
            loadCheatScript()  -- Load the cheat script
        else
            print("Invalid key. Please try again.")
            -- Show error message
            local errorLabel = Instance.new("TextLabel", frame)
            errorLabel.Text = "Invalid key. Please try again."
            errorLabel.Size = UDim2.new(0, 250, 0, 30)
            errorLabel.Position = UDim2.new(0, 25, 0, 120)
            errorLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            errorLabel.BackgroundTransparency = 1
            errorLabel.TextSize = 14
        end
    end)
end

-- Call the function to show the key prompt
createKeyPrompt()
