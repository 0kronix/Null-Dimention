---- Constants ----

local mod = NullDimension
local game = Game()
local WoodenTotem = {}

WoodenTotem.id = Isaac.GetTrinketIdByName("Wooden Totem")
WoodenTotem.Chance = 4

---- Descriptions ----

WoodenTotem.description = {
	WoodenTotem.Chance .."% chance to spawn Wooden Chest as additional room clear reward"
}
WoodenTotem.description_ru = {
    WoodenTotem.Chance .."% шанс создать Деревянный Сундук как дополнительную награду за зачистку комнаты"
}
mod:CreateEID(WoodenTotem.id, WoodenTotem.description, "Wooden Totem")
mod:CreateEID(WoodenTotem.id, WoodenTotem.description_ru, "Деревянный тотем", "ru")

WoodenTotem.goldenData = {
    Numbers = {WoodenTotem.Chance},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
WoodenTotem.goldenData_ru = {
    Numbers = {WoodenTotem.Chance},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    WoodenTotem.id,
    WoodenTotem.goldenData.Numbers,
    WoodenTotem.goldenData.ExtraText,
    WoodenTotem.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    WoodenTotem.id,
    WoodenTotem.goldenData_ru.Numbers,
    WoodenTotem.goldenData_ru.ExtraText,
    WoodenTotem.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function WoodenTotem:roomClear()
    local room = game:GetRoom()
    
    for _, player in pairs(PlayerManager.GetPlayers()) do
        if player:HasTrinket(WoodenTotem.id) then
            local mult = player:GetTrinketMultiplier(WoodenTotem.id)

            if mod:trinketProbCheck(player, WoodenTotem.id, WoodenTotem.Chance * mult) then
                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_WOODENCHEST, 0, 
                    room:FindFreePickupSpawnPosition(room:GetCenterPos()), Vector(0,0), nil)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, WoodenTotem.roomClear)