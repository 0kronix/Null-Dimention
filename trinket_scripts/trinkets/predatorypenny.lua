local mod = NullDimention
local PredatoryPenny = {}

PredatoryPenny.Chance = 5

PredatoryPenny.description = {
	"{{Collectible486}} ".. tostring(PredatoryPenny.Chance) .."% chance for fake damage effect when picking up a coin",
}
PredatoryPenny.description_ru = {
    "{{Collectible486}} ".. tostring(PredatoryPenny.Chance) .."% шанс на фальшивый эффект урона при подборе монеты",
}
mod:CreateEID(TrinketType.predatorypenny, PredatoryPenny.description, "Predatory Penny")
mod:CreateEID(TrinketType.predatorypenny, PredatoryPenny.description_ru, "Хищный пенни", "ru")

PredatoryPenny.goldenData = {
    Numbers = {PredatoryPenny.Chance},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = 3,
}
PredatoryPenny.goldenData_ru = {
    Numbers = {PredatoryPenny.Chance},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = 3,
}
mod:AddEIDGoldenTrinketData(
    TrinketType.predatorypenny,
    PredatoryPenny.goldenData.Numbers,
    PredatoryPenny.goldenData.ExtraText,
    PredatoryPenny.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    TrinketType.predatorypenny,
    PredatoryPenny.goldenData_ru.Numbers,
    PredatoryPenny.goldenData_ru.ExtraText,
    PredatoryPenny.goldenData_ru.MaxMultiplier,
    "ru" )

function PredatoryPenny:onCoinPickup(coin, collider)
    local player = collider:ToPlayer()
    if coin.SubType ~= CoinSubType.COIN_STICKYNICKEL and player and player:HasTrinket(TrinketType.predatorypenny) then
        if math.random(1, 100) <= PredatoryPenny.Chance then
            SFXManager():Play(SoundEffect.SOUND_BOSS_LITE_ROAR, 0.8)
            player:UseActiveItem(CollectibleType.COLLECTIBLE_DULL_RAZOR, false)
        end
    end
end

mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, PredatoryPenny.onCoinPickup, PickupVariant.PICKUP_COIN)