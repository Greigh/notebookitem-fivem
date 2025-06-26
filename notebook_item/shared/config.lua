local config = {}

-- Item configurations for different types
config.items = {
    notebook = {
        name = 'notebook',
        label = 'Personal Notebook',
        description = 'A notebook where you can write and store personal notes',
        maxLength = 500,
        placeholder = 'Write your personal note here...',
        icon = '📔'
    },
    journal = {
        name = 'journal',
        label = 'Daily Journal',
        description = 'A journal for recording daily thoughts and experiences',
        maxLength = 1000,
        placeholder = 'Record your daily thoughts and experiences...',
        icon = '📖'
    },
    businesscard = {
        name = 'businesscard',
        label = 'Business Card',
        description = 'A business card that can store contact information',
        maxLength = 300,
        placeholder = 'Enter contact information...',
        icon = '💼'
    },
    photo = {
        name = 'photo',
        label = 'Personal Photo',
        description = 'A photo with a description or memory attached',
        maxLength = 250,
        placeholder = 'Describe this photo or memory...',
        icon = '📷'
    }
}

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
    header = 'Personal Notebook',
    size = 'md'
}

return config
