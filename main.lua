-- Corrected Key Prompt GUI setup

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "KeyPromptGUI"

-- Create a Frame for the key prompt
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0

-- TextBox for entering the key
local textBox = Instance.new("TextBox", frame)
textBox.Size = UDim2.new(0, 250, 0, 30)
textBox.Position = UDim2.new(0, 25, 0, 40)
textBox.PlaceholderText = "Enter Drizoid key here"
textBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
textBox.TextColor3 = Color3.fromRGB(0, 0, 0)

-- Submit Button
local submitButton = Instance.new("TextButton", frame)
submitButton.Size = UDim2.new(0, 100, 0, 30)
submitButton.Position = UDim2.new(0.5, -50, 0, 80)
submitButton.Text = "Submit"
submitButton.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Error message Label
local errorLabel = Instance.new("TextLabel", frame)
errorLabel.Size = UDim2.new(0, 250, 0, 30)
errorLabel.Position = UDim2.new(0, 25, 0, 120)
errorLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
errorLabel.BackgroundTransparency = 1
errorLabel.TextSize = 14
errorLabel.Text = "Invalid key. Please try again."
errorLabel.Visible = false

-- Validate key and load script
submitButton.MouseButton1Click:Connect(function()
    local inputKey = textBox.Text
    if validateKey(inputKey) then
        gui:Destroy()  -- Remove the key prompt GUI
        loadCheatScript()  -- Load the cheat script
    else
        errorLabel.Visible = true  -- Show error message if key is invalid
    end
end)
