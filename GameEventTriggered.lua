local ThisIsUtilForLocalScript = true
local decor = {} 

function LocalDecorExistOn(ped,proper)
    return decor and decor[ped] and decor[ped][proper] and true or false
end 
function LocalDecorSetInt(ped,proper,value)
    if not decor[ped] then decor[ped] = {} end 
    decor[ped][proper] = value 
end 
function LocalDecorGetInt(ped,proper)
    if not decor[ped] then decor[ped] = {} end 
    return decor[ped] and decor[ped][proper] 
end 
AddEventHandler('gameEventTriggered',function(name,args)
   GameEventTriggered(name,args)
end)



CreateThread(function()
    while true do 
        local PPed = PlayerPedId()
        if not LocalDecorExistOn(PPed,"lasthp") then 
            LocalDecorSetInt(PPed,"lasthp",GetEntityHealth(PPed, false))
        end 
        if not LocalDecorExistOn(PPed,"lastarmour") then 
            LocalDecorSetInt(PPed,"lastarmour",GetPedArmour(PPed, false))
        end 
        Wait(0)
    end 
end )

function GameEventTriggered(eventName, data)
    if eventName == "CEventNetworkEntityDamage" then
        victim = tonumber(data[1])
        attacker = tonumber(data[2])
        victimDied = tonumber(data[4]) == 1 and true or false 
        weaponHash = tonumber(data[5])
        isMeleeDamage = tonumber(data[10]) ~= 0 and true or false 
        vehicleDamageTypeFlag = tonumber(data[11]) 
        local FoundLastDamagedBone, LastDamagedBone = GetPedLastDamageBone(victim)
        local bonehash = nil 
        if FoundLastDamagedBone then
            bonehash = tonumber(LastDamagedBone)
        end
        local PPed = PlayerPedId()
        if victim == PPed then 
            CreateThread(function()

                while not LocalDecorExistOn(victim,"lasthp") do 
                    Wait(0)
                end 
                if LocalDecorExistOn(victim,"lasthp") then 
                    local nowhp = victimDied and 0 or GetEntityHealth(victim)
                    local oldhp = LocalDecorGetInt(victim,"lasthp")
                    if nowhp  < oldhp then
                        TriggerServerEvent("nbk_damageindicator:SyncEntityDamage",nowhp,oldhp,bonehash,attacker)
                        
                    end 
                    if victimDied then 
                        DecorRemove(victim,"lasthp")
                    else
                        LocalDecorSetInt(victim,"lasthp",nowhp)
                    end 
                end 
                
                return
            end )
            CreateThread(function()

                while not LocalDecorExistOn(victim,"lastarmour") do 
                    Wait(0)
                end 
                if LocalDecorExistOn(victim,"lastarmour") then 
                    local nowarmour = victimDied and 0 or GetPedArmour(victim)
                    local oldarmour = LocalDecorGetInt(victim,"lastarmour")
                    if nowarmour  < oldarmour then
                        TriggerServerEvent("nbk_damageindicator:SyncEntityDamage",nowarmour,oldarmour,bonehash,attacker)
                        
                    end 
                    if victimDied then 
                        DecorRemove(victim,"lastarmour")
                    else
                        LocalDecorSetInt(victim,"lastarmour",nowhp)
                    end 
                end 
                
                return
            end )
            
        
        end 

        
    end
end
