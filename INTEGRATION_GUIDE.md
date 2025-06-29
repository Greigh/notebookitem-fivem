# Integration Guide - Notebook Item with ox_inventory

This guide explains how to properly integrate the notebook item resource with the ox_inventory system.

## Prerequisites

Before following this guide, ensure you have:

1. **ox_inventory** properly installed and configured
   - Download: [ox_inventory Official Repository](https://github.com/overextended/ox_inventory)
   - Documentation: [ox_inventory Docs](https://overextended.dev/ox_inventory)

2. **qbx_core** (qbox framework) installed
   - Download: [qbx_core Official Repository](https://github.com/Qbox-project/qbx_core)

3. **ox_lib** for UI components
   - Download: [ox_lib Official Repository](https://github.com/overextended/ox_lib)

## Overview

Our notebook item resource is designed to work seamlessly with ox_inventory's metadata system. Here's how the integration works:

## Step 1: Add Item Definition to ox_inventory

You need to add our notebook item to the ox_inventory items database.

### Location: `your-server/resources/ox_inventory/data/items.lua`

Add the item definitions from our `items.txt` file to your ox_inventory items.lua:

```lua
['notebook'] = {
    label = 'Personal Notebook',
    weight = 200,
    stack = false,
    close = true,
    description = 'A notebook where you can write and store personal notes. Use it to add or view your notes.',
    consume = 0,
    client = {
        export = 'notebook_item.notebook'
    }
}
```

### Key Properties Explained

- **`stack = false`**: Each notebook is unique and can't be stacked
- **`close = true`**: Closes inventory when used
- **`consume = 0`**: Item isn't consumed when used
- **`client.export`**: Links to our resource's export function

## Step 2: Understanding the Export System

When a player uses the notebook item, ox_inventory calls our export function:

```lua
-- In notebook_item/client/main.lua
exports('notebook', function(data, slot)
    -- data contains item information including metadata
    -- slot is the inventory slot number
end)
```

## Step 3: Metadata Integration

Our resource uses ox_inventory's metadata system through these exports:

### Server-Side Metadata Functions

```lua
-- Get item from slot
local item = exports.ox_inventory:GetSlot(src, slot)

-- Update item metadata
local success = exports.ox_inventory:SetMetadata(src, slot, {
    note = note,
    updated = os.date('%Y-%m-%d %H:%M:%S')
})
```

### How Metadata Works

1. **Empty Notebook**: `data.info` is nil or empty
2. **Notebook with Note**: `data.info.note` contains the saved text
3. **Metadata Structure**:

   ```lua
   {
       note = "Player's written note",
       updated = "2025-06-26 15:30:45"
   }
   ```

## Step 4: Resource Load Order

Ensure proper dependency loading in your server.cfg:

```cfg
# Core dependencies first
ensure oxmysql
ensure ox_lib
ensure qbx_core

# Inventory system
ensure ox_inventory

# Our notebook resource (after dependencies)
ensure notebook_item
```

## Step 5: Integration with ox_inventory Events

Our resource integrates with ox_inventory's event system:

### Client Events

- **Item Usage**: Triggered when player uses notebook from inventory
- **UI Integration**: Uses ox_lib for dialogs (compatible with ox_inventory UI)

### Server Events

- **Metadata Updates**: Validates and saves note data
- **Security Checks**: Ensures only valid players can update metadata

## Step 6: Database Integration

ox_inventory handles all database operations for us:

- **Automatic Persistence**: Metadata is saved to ox_inventory's database
- **Player Inventories**: Notes persist across server restarts
- **Item Tracking**: Each notebook instance maintains unique metadata

## Step 7: Testing the Integration

### Give Yourself a Notebook

```console
/give [player_id] notebook 1
```

### Test Workflow

1. **First Use**: Should prompt for note input
2. **Write Note**: Enter text and submit
3. **Second Use**: Should display the saved note
4. **Server Restart**: Note should persist

## Step 8: Troubleshooting Common Issues

### Export Function Not Working

- Verify the export name matches exactly: `notebook_item.notebook`
- Check that notebook_item resource started after ox_inventory
- Ensure no typos in the item definition

### Metadata Not Saving

- Check server console for error messages
- Verify ox_inventory is properly configured
- Ensure player has valid session in qbx_core

### UI Not Displaying

- Confirm ox_lib is loaded and running
- Check browser console (F12) for JavaScript errors
- Verify NUI resources are properly loaded

## Step 9: Advanced Integration Options

### Custom Item Image

Add a `notebook.png` image to `/ox_inventory/web/images/` folder.

### Item Spawning in Shops

Add to shop configurations in ox_inventory:

```lua
-- In shop config
{
    name = 'notebook',
    price = 50,
    count = 10
}
```

### Integration with Other Resources

The notebook metadata can be accessed by other resources:

```lua
-- Get player's notebook data
local item = exports.ox_inventory:GetSlot(source, slot)
if item and item.metadata and item.metadata.note then
    local note = item.metadata.note
    -- Use the note data
end
```

## Step 10: Code Review Checklist

### ✅ ox_inventory Integration

- [ ] Item added to data/items.lua
- [ ] Export function properly named
- [ ] Metadata system used correctly
- [ ] Database persistence working

### ✅ Resource Dependencies

- [ ] ox_inventory listed in fxmanifest.lua
- [ ] Load order correct in server.cfg
- [ ] No circular dependencies

### ✅ Security

- [ ] Server-side validation implemented
- [ ] Player verification before metadata updates
- [ ] Input sanitization working

### ✅ User Experience

- [ ] Clear UI feedback
- [ ] Error handling for edge cases
- [ ] Proper notifications

## Example: Complete Integration Test

Here's a complete test scenario:

1. **Server Setup**:

   ```cfg
   ensure ox_inventory
   ensure notebook_item
   ```

2. **Add Item Definition**:

   ```lua
   -- In ox_inventory/data/items.lua
   ['notebook'] = {
       label = 'Personal Notebook',
       weight = 200,
       stack = false,
       close = true,
       description = 'A notebook where you can write and store personal notes.',
       consume = 0,
       client = {
           export = 'notebook_item.notebook'
       }
   }
   ```

3. **Test Commands**:

   ```console
   /give 1 notebook 1
   # Player uses notebook, writes "Test note"
   # Player uses notebook again, sees "Test note"
   # Server restart
   # Player uses notebook, still sees "Test note"
   ```

## Summary

The integration between our notebook item resource and ox_inventory is seamless because:

- **Metadata System**: ox_inventory's metadata system perfectly supports our note storage needs
- **Export System**: Clean integration point for item usage
- **Database Persistence**: Automatic handling of data storage
- **Framework Compatibility**: Works with qbx_core through ox_inventory's bridge system

This design follows ox_inventory's patterns and provides a robust, scalable solution for metadata-based items.
