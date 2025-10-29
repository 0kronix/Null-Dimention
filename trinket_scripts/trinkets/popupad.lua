local mod = NullDimention
local game = Game()
local PopUpAd = {}

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
mod:CreateEID(TrinketType.popupad, PopUpAd.description, "Pop-Up Ad")
mod:CreateEID(TrinketType.popupad, PopUpAd.description_ru, "Всплывающая реклама", "ru")

PopUpAd.goldenData = {
    Numbers = {},
    ExtraText = {
        Doubled = "Spawn {{Nickel}}Nickel in first room of each floor",
        Tripled = "Spawn {{Dime}}Dime in first room of each floor",
    },
    MaxMultiplier = 3,
}
PopUpAd.goldenData_ru = {
    Numbers = {},
    ExtraText = {
        Doubled = "Создаёт {{Nickel}}Никель в начале каждого этажа",
        Tripled = "Создаёт {{Dime}Дайм в начале каждого этажа",
    },
    MaxMultiplier = 3,
}
mod:AddEIDGoldenTrinketData(
    TrinketType.popupad,
    PopUpAd.goldenData.Numbers,
    PopUpAd.goldenData.ExtraText,
    PopUpAd.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    TrinketType.popupad,
    PopUpAd.goldenData_ru.Numbers,
    PopUpAd.goldenData_ru.ExtraText,
    PopUpAd.goldenData_ru.MaxMultiplier,
    "ru" )

function PopUpAd:NewFloor()
    local room = game:GetRoom()
    local player = game:GetPlayer()
    if player:HasTrinket(TrinketType.popupad) then
        if math.random(1, 100) <= player:GetNumCoins() then
            SFXManager():Play(SoundEffect.SOUND_ULTRA_GREED_COINS_FALLING, 1.1)
            Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PORTAL_TELEPORT, 0, room:GetCenterPos() + Vector(100, 0), Vector(0, 0), nil)
        end
        if player:GetTrinketMultiplier(TrinketType.popupad) == 2 then
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 2, room:GetCenterPos() + Vector(0, 50), Vector(0,0), nil)
        elseif player:GetTrinketMultiplier(TrinketType.popupad) == 3 then
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 3, room:GetCenterPos() + Vector(0, 50), Vector(0,0), nil)
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, PopUpAd.NewFloor)