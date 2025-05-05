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

-- Create a basic UI for key input and submit button
local function createUI()
    -- Create a basic UI for key input
    local screenGui = Instance.new("ScreenGui")
    local frame = Instance.new("Frame")
    local label = Instance.new("TextLabel")
    local textBox = Instance.new("TextBox")
    local submitButton = Instance.new("TextButton")
    local errorMessage = Instance.new("TextLabel")

    -- Set Parent to CoreGui to make it appear in the player’s screen
    screenGui.Parent = game.CoreGui

    -- Frame for the UI
    frame.Parent = screenGui
    frame.Size = UDim2.new(0, 300, 0, 200)
    frame.Position = UDim2.new(0.5, -150, 0.5, -100)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

    -- Label to show instructions
    label.Parent = frame
    label.Size = UDim2.new(1, 0, 0, 30)
    label.Text = "Enter the Drizoid key:"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1

    -- TextBox for user input (key)
    textBox.Parent = frame
    textBox.Size = UDim2.new(1, -20, 0, 30)
    textBox.Position = UDim2.new(0, 10, 0, 40)
    textBox.PlaceholderText = "Enter key here"
    textBox.TextChanged:Connect(function()
        enteredKey = textBox.Text
    end)

    -- Submit button for key validation
    submitButton.Parent = frame
    submitButton.Size = UDim2.new(1, -20, 0, 40)
    submitButton.Position = UDim2.new(0, 10, 0, 80)
    submitButton.Text = "Submit"
    submitButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)

    -- Error message label (Initially hidden)
    errorMessage.Parent = frame
    errorMessage.Size = UDim2.new(1, -20, 0, 30)
    errorMessage.Position = UDim2.new(0, 10, 0, 130)
    errorMessage.Text = "Invalid key! Try again."
    errorMessage.TextColor3 = Color3.fromRGB(255, 0, 0)
    errorMessage.BackgroundTransparency = 1
    errorMessage.Visible = false

    -- When the submit button is clicked, validate the key and load the script
    submitButton.MouseButton1Click:Connect(function()
        if validateKey() then
            -- Hide UI elements after key validation
            screenGui:Destroy()

            -- Load and execute the Drizoid script
            loadDrizoidScript()
        else
            -- Show error message if the key is incorrect
            errorMessage.Visible = true
        end
    end)
end

-- Call the function to create the UI
createUI()
