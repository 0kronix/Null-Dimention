---- Constants ----

local mod = NullDimension
local PredatoryPenny = {}

PredatoryPenny.id = Isaac.GetTrinketIdByName("Predatory Penny")
PredatoryPenny.Chance = 5

---- Descriptions ----

PredatoryPenny.description = {
	"{{Collectible486}} ".. PredatoryPenny.Chance .."% chance for fake damage effect when picking up a coin",
}
PredatoryPenny.description_ru = {
    "{{Collectible486}} ".. PredatoryPenny.Chance .."% шанс на фальшивый эффект урона при подборе монеты",
}
mod:CreateEID(PredatoryPenny.id, PredatoryPenny.description, "Predatory Penny")
mod:CreateEID(PredatoryPenny.id, PredatoryPenny.description_ru, "Хищный пенни", "ru")

PredatoryPenny.goldenData = {
    Numbers = {PredatoryPenny.Chance},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
PredatoryPenny.goldenData_ru = {
    Numbers = {PredatoryPenny.Chance},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    PredatoryPenny.id,
    PredatoryPenny.goldenData.Numbers,
    PredatoryPenny.goldenData.ExtraText,
    PredatoryPenny.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    PredatoryPenny.id,
    PredatoryPenny.goldenData_ru.Numbers,
    PredatoryPenny.goldenData_ru.ExtraText,
    PredatoryPenny.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function PredatoryPenny:onCoinPickup(coin, collider)
    local player = collider:ToPlayer()

    if coin.SubType ~= CoinSubType.COIN_STICKYNICKEL and player and player:HasTrinket(PredatoryPenny.id) then
        local mult = player:GetTrinketMultiplier(PredatoryPenny.id)

        if mod:trinketProbCheck(player, PredatoryPenny.id, PredatoryPenny.Chance * mult) then
            SFXManager():Play(SoundEffect.SOUND_BOSS_LITE_ROAR, 0.8)
            player:UseActiveItem(CollectibleType.COLLECTIBLE_DULL_RAZOR, UseFlag.USE_NOANIM | UseFlag.USE_MIMIC)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, PredatoryPenny.onCoinPickup, PickupVariant.PICKUP_COIN)