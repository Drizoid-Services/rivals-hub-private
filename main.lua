-- Load Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

print("Rivals Menu Running")

-- Valid keys
local validKeys = {
    "DrizoidRivals723",
    "Wafle1kdono"
}

-- Validate key
local function validateKey(input)
    for _, key in ipairs(validKeys) do
        if input == key then
            return true
        end
    end
    return false
end

-- Load cheat logic
local function loadMainScript()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Drizoid-Services/rivals-hub-private/main/drizoid.lua"))()
    end)
    if not success then
        Rayfield:Notify({
            Title = "Error",
            Content = "Failed to load main cheat script.\n" .. tostring(err),
            Duration = 6
        })
    end
end

-- Prompt for key
Rayfield:Prompt({
    Title = "Rivals Key System",
    SubTitle = "Enter your access key",
    InputPlaceholder = "Enter key here...",
    ConfirmText = "Submit",
    CancelVisible = false,
    Callback = function(input)
        if validateKey(input) then
            Rayfield:Notify({
                Title = "Access Granted",
                Content = "Key accepted. Loading cheat...",
                Duration = 3.5
            })
            task.wait(1)
            loadMainScript()
        else
            Rayfield:Notify({
                Title = "Access Denied",
                Content = "Invalid key. Try again.",
                Duration = 4
            })
        end
    end
})
