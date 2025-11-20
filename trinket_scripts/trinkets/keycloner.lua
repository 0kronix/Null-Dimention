---- Constants ----

local mod = NullDimension
local game = Game()
local KeyCloner = {}

KeyCloner.id = Isaac.GetTrinketIdByName("Key Cloner")
KeyCloner.Chance = 5

---- Descriptions ----

KeyCloner.description = {
	"".. KeyCloner.Chance .."% that picking up a {{Key}} normal key will spawn another key"
}
KeyCloner.description_ru = {
    "".. KeyCloner.Chance .."% шанс, что при подборе {{Key}} обычного ключа появиться ещё один ключ"
}
mod:CreateEID(KeyCloner.id, KeyCloner.description, "Key Cloner")
mod:CreateEID(KeyCloner.id, KeyCloner.description_ru, "Клонировщик ключей", "ru")

KeyCloner.goldenData = {
    Numbers = {KeyCloner.Chance},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
KeyCloner.goldenData_ru = {
    Numbers = {KeyCloner.Chance},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    KeyCloner.id,
    KeyCloner.goldenData.Numbers,
    KeyCloner.goldenData.ExtraText,
    KeyCloner.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    KeyCloner.id,
    KeyCloner.goldenData_ru.Numbers,
    KeyCloner.goldenData_ru.ExtraText,
    KeyCloner.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function KeyCloner:onKeyPickup(key, collider)
    local player = collider:ToPlayer()
    local room = game:GetRoom()

    if key.SubType == KeySubType.KEY_NORMAL and player and player:HasTrinket(KeyCloner.id) then
        local mult = player:GetTrinketMultiplier(KeyCloner.id)

        if mod:trinketProbCheck(player, KeyCloner.id, KeyCloner.Chance * mult) then
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, 1,
                room:FindFreePickupSpawnPosition(mod:GetRandomAroundPosition(player.Position)), Vector(0,0), nil)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, KeyCloner.onKeyPickup, PickupVariant.PICKUP_KEY)