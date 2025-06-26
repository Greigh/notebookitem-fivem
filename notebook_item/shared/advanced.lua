-- Advanced Features Configuration
-- This file contains additional configurations for advanced features

local advanced = {}

-- Content sharing system (future feature)
advanced.sharing = {
    enabled = false, -- Set to true to enable sharing between players
    maxSharedItems = 5, -- Maximum items a player can share
    shareRadius = 10.0, -- Radius in which players can share items
}

-- Content encryption (future feature)
advanced.encryption = {
    enabled = false, -- Set to true to enable password protection
    maxPasswordLength = 20,
    minPasswordLength = 4,
}

-- Content categories/tags (future feature)
advanced.categories = {
    enabled = false, -- Set to true to enable categorization
    maxCategories = 10,
    defaultCategories = {
        'Personal',
        'Business',
        'Ideas',
        'Reminders',
        'Contacts'
    }
}

-- Export restrictions based on job/permissions
advanced.permissions = {
    enabled = true,
    restrictions = {
        businesscard = {
            jobs = {'lawyer', 'judge', 'realestate', 'mechanic'}, -- Jobs that can use business cards
            allowAll = true -- Set to false to restrict to specific jobs only
        },
        journal = {
            allowAll = true -- Everyone can use journals
        }
    }
}

-- Statistics tracking
advanced.stats = {
    enabled = true,
    trackUsage = true, -- Track how often items are used
    trackCreation = true, -- Track when items are created
}

return advanced
