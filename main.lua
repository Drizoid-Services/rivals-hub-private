-- Check if the script is already loaded
if getgenv().drizoidKeySystemLoaded == true then return end
getgenv().drizoidKeySystemLoaded = true

-- Define the valid key for Drizoid
local validKey = "Wafle1kdono"  -- This can be your custom key
local enteredKey = ""

-- Function to validate the entered key
local function validateKey()
    if enteredKey == validKey then
        return true
    else
        return false
    end
end

-- Function to load and execute the Drizoid script if the key is correct
local function loadDrizoidScript()
    -- URL of the Drizoid script
    local url = "https://raw.githubusercontent.com/Drizoid-Services/rivals-hub-private/refs/heads/main/drizoid.lua"
    
    -- Fetch the script content
    local scriptContent = game:HttpGet(url)

    -- Use loadstring to execute the script content
    local success, result = pcall(function()
        loadstring(scriptContent)()  -- Execute the Drizoid script
    end)

    -- Handle success or failure
    if success then
        print("Drizoid script loaded and executed successfully!")
    else
        print("Error executing Drizoid script: " .. result)
    end
end

-- Simple UI to prompt for the key input
local function createUI()
    -- Create a basic UI for key input
    local screenGui = Instance.new("ScreenGui")
    local frame = Instance.new("Frame")
    local label = Instance.new("TextLabel")
    local textBox = Instance.new("TextBox")
    local submitButton = Instance.new("TextButton")

    screenGui.Parent = game.CoreGui
    frame.Parent = screenGui
    frame.Size = UDim2.new(0, 300, 0, 150)
    frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

    label.Parent = frame
    label.Size = UDim2.new(1, 0, 0, 30)
    label.Text = "Enter the Drizoid key:"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1

    textBox.Parent = frame
    textBox.Size = UDim2.new(1, -20, 0, 30)
    textBox.Position = UDim2.new(0, 10, 0, 40)
    textBox.PlaceholderText = "Enter key here"
    textBox.TextChanged:Connect(function()
        enteredKey = textBox.Text
    end)

    submitButton.Parent = frame
    submitButton.Size = UDim2.new(1, -20, 0, 40)
    submitButton.Position = UDim2.new(0, 10, 0, 80)
    submitButton.Text = "Submit"
    submitButton.MouseButton1Click:Connect(function()
        if validateKey() then
            print("Key is valid, loading Drizoid script...")
            loadDrizoidScript()  -- Load the script if the key is correct
        else
            print("Invalid key. Please try again.")
        end
    end)
end

-- Create the UI and start the process
createUI()
