local config = require 'shared.config'

-- Handle content update from client (new system)
RegisterNetEvent('notebook_item:updateContent', function(slot, content, itemType)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    
    if not player then
        TriggerClientEvent('notebook_item:contentUpdated', src, false, 'Player not found')
        return
    end
    
    -- Get item configuration
    local itemConfig = config.items[itemType]
    if not itemConfig then
        TriggerClientEvent('notebook_item:contentUpdated', src, false, 'Invalid item type')
        return
    end
    
    -- Validate input
    if not content or type(content) ~= 'string' or #content == 0 then
        TriggerClientEvent('notebook_item:contentUpdated', src, false, 'Invalid content')
        return
    end
    
    -- Sanitize the content (basic sanitization)
    content = string.gsub(content, '[<>]', '') -- Remove potential HTML tags
    
    if #content > itemConfig.maxLength then
        TriggerClientEvent('notebook_item:contentUpdated', src, false, 'Content is too long (max ' .. itemConfig.maxLength .. ' characters)')
        return
    end
    
    -- Get the item from the specified slot
    local item = exports.ox_inventory:GetSlot(src, slot)
    
    if not item or item.name ~= itemConfig.name then
        TriggerClientEvent('notebook_item:contentUpdated', src, false, itemConfig.label .. ' not found in specified slot')
        return
    end
    
    -- Update item metadata
    local success = exports.ox_inventory:SetMetadata(src, slot, {
        content = content,
        timestamp = os.date('%Y-%m-%d %H:%M:%S'),
        itemType = itemType,
        author = player.PlayerData.name
    })
    
    if success then
        print(('[notebook_item] Player %s (%s) updated %s in slot %d'):format(player.PlayerData.name, src, itemType, slot))
        TriggerClientEvent('notebook_item:contentUpdated', src, true, 'Content saved successfully!')
    else
        TriggerClientEvent('notebook_item:contentUpdated', src, false, 'Failed to save content')
    end
end)

-- Handle note update from client (backwards compatibility)
RegisterNetEvent('notebook_item:updateNote', function(slot, note)
    -- Convert old note system to new content system
    TriggerEvent('notebook_item:updateContent', slot, note, 'notebook')
end)

-- Add logging for debugging
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        print(('[notebook_item] Enhanced Multi-Item Resource started successfully'))
        print(('[notebook_item] Supported items: %s'):format(table.concat({
            'notebook', 'journal', 'businesscard', 'photo'
        }, ', ')))
    end
end)

-- Command to check item content (admin only)
RegisterCommand('checkitem', function(source, args, rawCommand)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    
    -- Check if player has admin permissions (adjust this based on your permission system)
    if not player or not player.PlayerData.job or player.PlayerData.job.name ~= 'admin' then
        TriggerClientEvent('chat:addMessage', src, {
            color = {255, 0, 0},
            multiline = true,
            args = {"System", "You don't have permission to use this command"}
        })
        return
    end
    
    local slot = tonumber(args[1])
    if not slot then
        TriggerClientEvent('chat:addMessage', src, {
            color = {255, 255, 0},
            multiline = true,
            args = {"System", "Usage: /checkitem [slot]"}
        })
        return
    end
    
    local item = exports.ox_inventory:GetSlot(src, slot)
    if not item then
        TriggerClientEvent('chat:addMessage', src, {
            color = {255, 0, 0},
            multiline = true,
            args = {"System", "No item found in slot " .. slot}
        })
        return
    end
    
    if item.info and item.info.content then
        TriggerClientEvent('chat:addMessage', src, {
            color = {0, 255, 0},
            multiline = true,
            args = {"Item Info", "Slot: " .. slot .. " | Type: " .. (item.info.itemType or 'unknown') .. " | Author: " .. (item.info.author or 'unknown') .. " | Content: " .. item.info.content}
        })
    else
        TriggerClientEvent('chat:addMessage', src, {
            color = {255, 255, 0},
            multiline = true,
            args = {"System", "Item in slot " .. slot .. " has no content"}
        })
    end
end, false)
