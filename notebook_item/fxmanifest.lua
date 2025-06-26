fx_version 'cerulean'
game 'gta5'

name 'notebook_item'
author 'Your Name'
description 'Enhanced multi-item resource with notebook, journal, business card, and photo functionality'
version '2.0.0'

dependencies {
    'qbx_core',
    'ox_inventory',
    'ox_lib'
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'
