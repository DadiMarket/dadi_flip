fx_version 'cerulean'
game 'gta5'
author 'DADI MARKET'

description 'DADI Flip Vehicle'
version '1.0.1'

shared_scripts {
    '@ox_lib/init.lua'
}

client_scripts {
    'client.lua'
}

files {
    'config.json',
    'locales/*.json'
}

dependencies {
    'ox_lib',
    'ox_target'
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'