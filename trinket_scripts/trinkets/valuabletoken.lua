---- Constants ----

local mod = NullDimension
local game = Game()
local ValuableToken = {}

ValuableToken.id = Isaac.GetTrinketIdByName("Valuable Token")
ValuableToken.MoneyNeed = 50

---- Descriptions ----

ValuableToken.description = {
	""
}
ValuableToken.description_ru = {
    ""
}
mod:CreateEID(ValuableToken.id, ValuableToken.description, "Valuable Token")
mod:CreateEID(ValuableToken.id, ValuableToken.description_ru, "Ценный токен", "ru")

ValuableToken.goldenData = {
    Numbers = {},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
ValuableToken.goldenData_ru = {
    Numbers = {},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    ValuableToken.id,
    ValuableToken.goldenData.Numbers,
    ValuableToken.goldenData.ExtraText,
    ValuableToken.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    ValuableToken.id,
    ValuableToken.goldenData_ru.Numbers,
    ValuableToken.goldenData_ru.ExtraText,
    ValuableToken.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function ValuableToken:postShopPurchase(_, player, money)
    local data = player:GetData()
    local room = game:GetRoom()
    data.valTokenCount = (data.valTokenCount or 0) + money

    if player:HasTrinket(ValuableToken.id) then
        if data.valTokenCount >= ValuableToken.MoneyNeed then
            data.valTokenCount = nil

            player:TryRemoveTrinket(ValuableToken.id)
            SFXManager():Play(SoundEffect.SOUND_FORTUNE_COOKIE, 0.8)

            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, 2, 
                    room:FindFreePickupSpawnPosition(mod:GetRandomAroundPosition(player.Position)), Vector(0,0), nil)
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, 4, 
                    room:FindFreePickupSpawnPosition(mod:GetRandomAroundPosition(player.Position)), Vector(0,0), nil)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_SHOP_PURCHASE, ValuableToken.postShopPurchase)