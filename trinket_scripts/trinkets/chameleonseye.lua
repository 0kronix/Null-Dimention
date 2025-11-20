---- Constants ----

local mod = NullDimension
local game = Game()
local ChameleonsEye = {}

ChameleonsEye.id = Isaac.GetTrinketIdByName("Chameleon's Eye")

---- Descriptions ----

ChameleonsEye.description = {
	"{{Collectible665}} Reveal the contents of sacks"
}
ChameleonsEye.description_ru = {
    "{{Collectible665}} Показывает содержимое мешков"
}
mod:CreateEID(ChameleonsEye.id, ChameleonsEye.description, "Chameleon's Eye")
mod:CreateEID(ChameleonsEye.id, ChameleonsEye.description_ru, "Глаз хамелеона", "ru")

ChameleonsEye.goldenData = {
    Numbers = {},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
ChameleonsEye.goldenData_ru = {
    Numbers = {},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    ChameleonsEye.id,
    ChameleonsEye.goldenData.Numbers,
    ChameleonsEye.goldenData.ExtraText,
    ChameleonsEye.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    ChameleonsEye.id,
    ChameleonsEye.goldenData_ru.Numbers,
    ChameleonsEye.goldenData_ru.ExtraText,
    ChameleonsEye.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function ChameleonsEye:revealSacksContents(entity)
    local pickup = entity:ToPickup()

    if PlayerManager.AnyoneHasTrinket(ChameleonsEye.id) then
        if pickup.Variant == PickupVariant.PICKUP_GRAB_BAG then
            return true
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_UPDATE_GHOST_PICKUPS, ChameleonsEye.revealSacksContents)