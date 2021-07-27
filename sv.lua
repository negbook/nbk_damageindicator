RegisterServerEvent("nbk_damageindicator:SyncEntityDamage")
AddEventHandler('nbk_damageindicator:SyncEntityDamage',function(nowhp,oldhp,bonehash,attacker) --victim,attacker,victimDied,weaponHash,isMeleeDamage,vehicleDamageTypeFlag

        TriggerClientEvent('nbk_damageindicator:OnEntityHealthChange',source,nowhp,oldhp,bonehash,attacker)
        
   
end )