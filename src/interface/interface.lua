---@diagnostic disable: duplicate-set-field, lowercase-global

interface = {}

---Opens a UI element and sets NUI focus
---@param ui string The UI element to open (e.g. 'settings')
function interface:open(ui)
    if not ui then return end
    
    state.currentUI = ui
    state.isOpen = true
    
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "setVisible",
        data = {
            visible = true,
            ui = ui
        }
    })
end

---Closes the UI and removes NUI focus
function interface:close()
    if not state.isOpen then return end
    
    state.currentUI = nil
    state.isOpen = false
    
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "setVisible",
        data = {
            visible = false
        }
    })
end

---Sends an update to the NUI with a custom action and data
---@param action string The action/event name for the NUI
---@param data table The data to send
function interface:update(action, data)
    if type(action) ~= 'string' or not data then return end
    SendNUIMessage({
        action = action,
        data = data
    })
end

---Saves settings to KVP storage
---@param settings table The settings to save
function interface:save()
    if not settings then return end
    
    local existing = state.load() or {}
    
    for k, v in pairs(settings) do
        existing[k] = v
    end
    
    SetResourceKvp('rkHud_settings', json.encode(existing))
end

---Loads settings from KVP storage
---@return table|nil The loaded settings or nil if none found
function interface:load()
    local raw = GetResourceKvpString('rkHud_settings')
    if not raw then return nil end

    local success, decoded = pcall(json.decode, raw)
    return success and decoded or nil
end