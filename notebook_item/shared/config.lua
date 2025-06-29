local config = {}

-- Notebook item configurations (only notebook items supported)
config.items = {
    notebook = {
        name = 'notebook',
        label = 'Personal Notebook',
        description = 'A notebook where you can write and store personal notes',
        maxLength = 500,
        placeholder = 'Write your personal note here...',
        icon = '📔',
        type = 'notebook_item'
    },
    journal = {
        name = 'journal',
        label = 'Daily Journal',
        description = 'A journal for recording daily thoughts and experiences',
        maxLength = 1000,
        placeholder = 'Record your daily thoughts and experiences...',
        icon = '📖',
        type = 'notebook_item'
    },
    businesscard = {
        name = 'businesscard',
        label = 'Business Card',
        description = 'A business card that can store contact information',
        maxLength = 300,
        placeholder = 'Enter contact information...',
        icon = '💼',
        type = 'notebook_item'
    },
    photo = {
        name = 'photo',
        label = 'Personal Photo',
        description = 'A photo with a description or memory attached',
        maxLength = 250,
        placeholder = 'Describe this photo or memory...',
        icon = '📷',
        type = 'notebook_item'
    }
}

-- List of supported notebook item types
config.supportedItems = { 'notebook', 'journal', 'businesscard', 'photo' }

-- Backwards compatibility
config.item = config.items.notebook

-- Notification settings
config.notifications = {
    success = {
        type = 'success',
        duration = 3000
    },
    error = {
        type = 'error',
        duration = 5000
    },
    info = {
        type = 'info',
        duration = 4000
    }
}

-- Input dialog settings
config.dialog = {
    header = 'Notebook Items',
    size = 'md'
}

-- Function to check if an item is a supported notebook item
config.isNotebookItem = function(itemName)
    for _, supportedItem in ipairs(config.supportedItems) do
        if itemName == supportedItem then
            return true
        end
    end
    return false
end

return config
