shared_script "@SecureServe/module.lua"
fx_version 'adamant'

game 'gta5'

author 'okok#3488'
description 'fb_crafting'

ui_page 'web/ui.html'

files {
	'web/*.*',
	'web/icons/*.png'
}

shared_script 'config.lua'

client_scripts {
	'client.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}