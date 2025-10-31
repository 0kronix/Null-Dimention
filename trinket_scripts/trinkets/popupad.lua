---- Constants ----

local mod = NullDimention
local game = Game()
local PopUpAd = {}

PopUpAd.id = Isaac.GetTrinketIdByName("Pop-up Ad")

---- Descriptions ----

PopUpAd.description = {
	"{{Collectible660}} Chance to spawn portal to {{TreasureRoom}} Treasure Room in first room of each floor",
    "{{Coin}} Chance is based on coins Isaac have",
    "Leaving the room despawns portal"
}
PopUpAd.description_ru = {
    "{{Collectible660}} Шанс создать портал в {{TreasureRoom}} Комнату сокровищ в начале каждого этажа",
    "{{Coin}} Шанс основан на количестве имеющихся у персонажа монет",
    "Портал исчезнет при выходе из комнаты"
}
mod:CreateEID(PopUpAd.id, PopUpAd.description, "Pop-Up Ad")
mod:CreateEID(PopUpAd.id, PopUpAd.description_ru, "Всплывающая реклама", "ru")

PopUpAd.goldenData = {
    Numbers = {},
    ExtraText = {
        Doubled = "Spawn {{Nickel}}Nickel in first room of each floor",
        Tripled = "Spawn {{Dime}}Dime in first room of each floor",
    },
    MaxMultiplier = nil,
}
PopUpAd.goldenData_ru = {
    Numbers = {},
    ExtraText = {
        Doubled = "Создаёт {{Nickel}}Никель в начале каждого этажа",
        Tripled = "Создаёт {{Dime}Дайм в начале каждого этажа",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    PopUpAd.id,
    PopUpAd.goldenData.Numbers,
    PopUpAd.goldenData.ExtraText,
    PopUpAd.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    PopUpAd.id,
    PopUpAd.goldenData_ru.Numbers,
    PopUpAd.goldenData_ru.ExtraText,
    PopUpAd.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function PopUpAd:NewFloor()
    local room = game:GetRoom()
    local player = game:GetPlayer()
    
    if player:HasTrinket(PopUpAd.id) then
        local rng = player:GetTrinketRNG(PopUpAd.id)
        local portalChance = rng:RandomInt(1, 101)

        if portalChance <= player:GetNumCoins() then
            Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PORTAL_TELEPORT, 0, room:GetCenterPos() + Vector(100, 0), Vector(0, 0), nil)
        end

        if player:GetTrinketMultiplier(PopUpAd.id) == 2 then
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 2, room:GetCenterPos() + Vector(0, 50), Vector(0,0), nil)
        elseif player:GetTrinketMultiplier(PopUpAd.id) >= 3 then
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 3, room:GetCenterPos() + Vector(0, 50), Vector(0,0), nil)
        end
        
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, PopUpAd.NewFloor)