---- Constants ----

local mod = NullDimention
local game = Game()
local ChameleonsEye = {}

ChameleonsEye.id = Isaac.GetTrinketIdByName("Chameleon's Eye")

---- Descriptions ----

ChameleonsEye.description = {
	""
}
ChameleonsEye.description_ru = {
    ""
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
    return PlayerManager.AnyoneHasTrinket(ChameleonsEye.id)
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_UPDATE_GHOST_PICKUPS, ChameleonsEye.revealSacksContents, PickupVariant.PICKUP_GRAB_BAG)