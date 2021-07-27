--[[
CreateThread(function()
    while true do 
    Wait(100)
    local entity=PlayerPedId()
    local coords = GetFinalRenderedCamCoord()
    local v = GetOffsetFromEntityGivenWorldCoords(entity,coords)
 print(v)
end 
end)--]]
OnEntityHealthChange = function(victim,newhp,oldhp,bonehash,attacker)
    init()
    local datas = {}
    local isDead = (IsEntityDead(victim) or IsPedDeadOrDying(victim) or newhp == 0)
    local value = oldhp - newhp
    local coords = GetEntityCoords(attacker)
    
    if coords then 
        local v = GetOffsetFromEntityGivenWorldCoords(victim,coords)
        local newlevel = 1 
        if value <= 5 then 
            newlevel = 1
        elseif value >5 and value <= 20 then 
            newlevel = 2
        elseif value > 20 then 
            newlevel = 3
        end 
        
        if v.y <=0 then 
            indicatormessage("Up",newlevel)
            indicatormessage("Down",newlevel)
            indicatormessage("Right",newlevel)
            indicatormessage("Left",newlevel)
        else 
            if v.z >=0 then 
            indicatormessage("Up",newlevel)
            else 
                indicatormessage("Down",newlevel)
            end 
            if v.x >=0 then 
                indicatormessage("Right",newlevel)
            else 
                indicatormessage("Left",newlevel)
            end 
        end 
        
        
    end 

end
RegisterNetEvent('nbk_damageindicator:OnEntityHealthChange')
AddEventHandler('nbk_damageindicator:OnEntityHealthChange',function(newhp,oldhp,bonehash,attacker)
    local victim = PlayerPedId()
        OnEntityHealthChange(victim,newhp,oldhp,bonehash,attacker)
end)

indicatormessage = function(direction,newlevel)
	grun("SHOW_DAMAGE_DIRECTION")
        gsend(direction,newlevel)
    gstop()
    
end
init = function()
	Threads.Scaleforms.Call("nbk_damageindicator",function(run,send,stop,handle)
        grun = run 
        gsend = send 
        gstop = stop 
        Threads.Scaleforms.Draw("nbk_damageindicator")
	end)
end