---- Constants ----

local mod = NullDimention
local game = Game()
local DevilsDelivery = {}

DevilsDelivery.id = Isaac.GetTrinketIdByName("Devil's Delivery")
DevilsDelivery.HeartsNeed = 3
DevilsDelivery.Cost = 2
DevilsDelivery.Vectors = { [1] = Vector(0, 50), [2] = Vector(-50, 50), [3] = Vector(50, 50) }

---- Descriptions ----

DevilsDelivery.description = {
	"At the start of new floor, if Isaac have a least {{Heart}} ".. DevilsDelivery.HeartsNeed .." heart containers, remove {{EmptyHeart}} ".. DevilsDelivery.Cost / 2 .." heart containers and spawn random {{DevilRoom}} Devil Room Item",
    "{{Warning}} The trinket is destroyed upon activation"
}
DevilsDelivery.description_ru = {
    "В начале нового этажа, если у Айзека как минимум {{Heart}} ".. DevilsDelivery.HeartsNeed .." контейнера Красного Сердца, забирает {{EmptyHeart}} ".. DevilsDelivery.Cost / 2 .." контейнера Красного Сердца и создаёт случайный предмет {{DevilRoom}} Сделки с дьяволом",
    "{{Warning}} Брелок уничтожается после активации"
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
        Doubled = "Создаёт {{BlackHeart}} Чёрное сердце после активации",
        Tripled = "Создаёт {{BlackHeart}} 2 Чёрных сердца после активации",
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
        if player:GetMaxHearts() >= DevilsDelivery.HeartsNeed * 2 then
            local devilDealItem = game:GetItemPool():GetCollectible(ItemPoolType.POOL_DEVIL, true)
            local mult = player:GetTrinketMultiplier(DevilsDelivery.id)

            player:AddMaxHearts(-DevilsDelivery.Cost * 2, true)
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, devilDealItem, room:GetCenterPos() + DevilsDelivery.Vectors[1], Vector(0,0), nil)

            player:AnimateTrinket(DevilsDelivery.id)

            if mult >= 2 then
                for i = 1, mult - 1 do
                    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, 6, 
                        room:GetCenterPos() + DevilsDelivery.Vectors[(i % 2) + 1], Vector(0,0), nil)
                end
            end
        end

        player:TryRemoveTrinket(DevilsDelivery.id)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, DevilsDelivery.NewFloor)