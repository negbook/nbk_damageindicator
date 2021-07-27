fx_version 'adamant'
games {'gta5'}
--credit:negbook QQ:747285250 


client_scripts {
'@threads/threads.lua',
'GameEventTriggered.lua',
'nbk_damageindicator.lua'
}

server_script "sv.lua" --for the buggy OneSync damage detect 
dependencies {
    'threads',
	'nbk_damageindicator_stream'
}