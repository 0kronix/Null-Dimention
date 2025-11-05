---- Constants ----

local mod = NullDimention
local game = Game()
local DevilsDelivery = {}

DevilsDelivery.id = Isaac.GetTrinketIdByName("Key Cloner")
DevilsDelivery.HeartsNeed = 2 * 3

---- Descriptions ----

DevilsDelivery.description = {
	""
}
DevilsDelivery.description_ru = {
    ""
}
mod:CreateEID(DevilsDelivery.id, DevilsDelivery.description, "Devil's Delivery")
mod:CreateEID(DevilsDelivery.id, DevilsDelivery.description_ru, "Дьявольская доставка", "ru")

DevilsDelivery.goldenData = {
    Numbers = {},
    ExtraText = {
        Doubled = "Spawn {{BlackHeart}} Black heart after activation",
        Tripled = "Spawn {{BlackHeart}} 2 Black hearts after activation",
    },
    MaxMultiplier = nil,
}
DevilsDelivery.goldenData_ru = {
    Numbers = {},
    ExtraText = {
        Doubled = "Spawn {{BlackHeart}} Black heart after activation",
        Tripled = "Spawn 2 {{BlackHeart}} Black hearts after activation",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    DevilsDelivery.id,
    DevilsDelivery.goldenData.Numbers,
    DevilsDelivery.goldenData.ExtraText,
    DevilsDelivery.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    DevilsDelivery.id,
    DevilsDelivery.goldenData_ru.Numbers,
    DevilsDelivery.goldenData_ru.ExtraText,
    DevilsDelivery.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function DevilsDelivery:NewFloor()
    local room = game:GetRoom()
    local player = game:GetPlayer()
    
    if player:HasTrinket(DevilsDelivery.id) then
        if player:GetMaxHearts() >= DevilsDelivery.HeartsNeed then
            player:AddMaxHearts(2, true)
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, 6, room:GetCenterPos() + Vector(0, 50), Vector(0,0), nil)
        end

        if player:GetTrinketMultiplier(DevilsDelivery.id) == 2 then
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, 6, room:GetCenterPos() + Vector(0, 50), Vector(0,0), nil)
        elseif player:GetTrinketMultiplier(DevilsDelivery.id) >= 3 then
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, 6, room:GetCenterPos() + Vector(0, 50), Vector(0,0), nil)
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, 6, room:GetCenterPos() + Vector(-50, 50), Vector(0,0), nil)
        end
        
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, DevilsDelivery.NewFloor)