fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

name 'hdrp-tarot'
version '2.5.0'

shared_script {
	'@ox_lib/init.lua',
    '@rsg-core/shared/locale.lua',
    'locales/en.lua', -- preferred language
	'config.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/img/*.png',
    'html/svg/*.svg',
    'html/script.js',
    'html/style.css',
}

dependencies {
	'rsg-core',
    'rsg-target',
	'ox_lib'
}

escrow_ignore {
}

lua54 'yes'