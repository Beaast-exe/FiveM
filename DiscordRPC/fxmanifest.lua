fx_version 'adamant'
game 'gta5'


author 'Beaast_exe'
description 'Discord Rich Presence Client'
version '1.0.0'

shared_script {
	'@es_extended/imports.lua',
	'config.lua'
}

client_script {
	'client/main.lua'
}

server_script {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua'
}