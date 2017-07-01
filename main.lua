local GreenCandle = RegisterMod("GreenCandle",1)

GreenCandle.COLLECTIBLE_GREEN_CANDLE = Isaac.GetItemIdByName("Green Candle")

function GreenCandle:onUpdate()

	--Beginning of run init
	if Game():GetFrameCount() == 1 then
		GreenCandle.HasGreenCandle = false
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, GreenCandle.COLLECTIBLE_GREEN_CANDLE, Vector(320,300), Vector(0,0),nil)
	end
	
    --Green Candle functionality
	for playerNum = 1, Game():GetNumPlayers() do
		local player = Game():GetPlayer(playerNum)
        if player:HasCollectible(GreenCandle.COLLECTIBLE_GREEN_CANDLE) then
			
			if not GreenCandle.HasGreenCandle then -- Init pickup
				player:AddSoulHearts(2)
				GreenCandle.HasGreenCandle = true
			end
			
			for i, entity in pairs(Isaac.GetRoomEntities()) do
				if entity:IsVulnerableEnemy() and math.random(500) <= 7 then
					entity:AddPoison(EntityRef(player),100,3.5)
				end
			end
		end
    end
end
Isaac.DebugString("Green Candle init")
GreenCandle:AddCallback(ModCallbacks.MC_POST_UPDATE,GreenCandle.onUpdate)
