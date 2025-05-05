-- Custom Key System
local keySystem = {
    -- Define the valid key
    validKey = "Wafle1kdono",  -- Replace with your desired key
    enteredKey = "",

    -- Prompt for key input
    promptKey = function()
        -- For a console-based input (adjust as needed for your platform)
        print("Enter the cheat key:")
        local userInput = io.read()  -- Assuming console input
        if userInput == keySystem.validKey then
            print("Key accepted! Loading script...")
            keySystem.enteredKey = userInput
            return true
        else
            print("Invalid key. Please try again.")
            return false
        end
    end
}

-- Function to initialize the key system and validate the key
local function initializeKeySystem()
    local isKeyValid = false
    while not isKeyValid do
        isKeyValid = keySystem.promptKey()  -- Ask for the key until it's valid
    end
end

-- Initialize the key system
initializeKeySystem()

-- Script URL to load
local scriptURL = "https://raw.githubusercontent.com/Drizoid-Services/rivals-hub-private/refs/heads/main/drizoid.lua"  -- Example URL

-- Function to load and execute the script after the key is validated
local function loadAndExecuteScript(url)
    -- Fetch the script from the provided URL
    local scriptContent = game:HttpGet(url)  -- Assuming game environment (like Roblox)
    
    -- Execute the script using loadstring
    local success, result = pcall(loadstring(scriptContent))
    
    if success then
        print("Script loaded and executed successfully!")
    else
        print("Error executing the script: " .. result)
    end
end

-- Now that the key has been validated, load and execute the script
loadAndExecuteScript(scriptURL)
