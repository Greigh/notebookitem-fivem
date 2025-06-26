local config = require 'shared.config'

-- Export functions for different item types
exports('notebook', function(data, slot)
    handleItemUsage(data, slot, 'notebook')
end)

exports('journal', function(data, slot)
    handleItemUsage(data, slot, 'journal')
end)

exports('businesscard', function(data, slot)
    handleItemUsage(data, slot, 'businesscard')
end)

exports('photo', function(data, slot)
    handleItemUsage(data, slot, 'photo')
end)

-- Main handler for all item types
function handleItemUsage(data, slot, itemType)
    local playerData = exports.qbx_core:GetPlayerData()
    if not playerData then return end
    
    local itemConfig = config.items[itemType]
    if not itemConfig then 
        lib.notify({
            title = 'Error',
            description = 'Unknown item type: ' .. itemType,
            type = 'error',
            duration = config.notifications.error.duration
        })
        return 
    end
    
    local itemData = data
    local hasContent = itemData.info and itemData.info.content
    
    if hasContent then
        -- Item has content stored, display it to the player
        displayContent(itemData.info.content, itemConfig, itemData.info.timestamp)
    else
        -- Item doesn't have content, prompt user to add some
        promptForContent(slot, itemData, itemConfig)
    end
end

-- Function to display the stored content
function displayContent(content, itemConfig, timestamp)
    local timestampText = timestamp and ('\n\nSaved: ' .. timestamp) or ''
    
    lib.alertDialog({
        header = itemConfig.icon .. ' ' .. itemConfig.label,
        content = 'Content:\n\n' .. content .. timestampText,
        centered = true,
        cancel = true,
        size = config.dialog.size
    })
end

-- Function to prompt user for input and store the content
function promptForContent(slot, itemData, itemConfig)
    local input = lib.inputDialog(itemConfig.icon .. ' ' .. itemConfig.label, {
        {
            type = 'textarea',
            label = 'Enter content',
            placeholder = itemConfig.placeholder,
            required = true,
            max = itemConfig.maxLength
        }
    })
    
    if input and input[1] then
        local content = input[1]
        
        -- Send content to server to update item metadata
        TriggerServerEvent('notebook_item:updateContent', slot, content, itemConfig.name)
        
        -- Show loading notification
        lib.notify({
            title = 'Saving...',
            description = 'Saving your content',
            type = 'info',
            duration = 2000
        })
    else
        -- User cancelled input
        lib.notify({
            title = 'Cancelled',
            description = 'Content entry cancelled',
            type = 'info',
            duration = config.notifications.info.duration
        })
    end
end

-- Handle content update response from server
RegisterNetEvent('notebook_item:contentUpdated', function(success, message)
    if success then
        lib.notify({
            title = 'Success!',
            description = message or 'Content saved successfully!',
            type = 'success',
            duration = config.notifications.success.duration
        })
    else
        lib.notify({
            title = 'Error',
            description = message or 'Failed to save content',
            type = 'error',
            duration = config.notifications.error.duration
        })
    end
end)

-- Backwards compatibility for old notebook system
RegisterNetEvent('notebook_item:noteUpdated', function(success, message)
    TriggerEvent('notebook_item:contentUpdated', success, message)
end)
