---- Constants ----

local mod = NullDimention
local game = Game()
local PotatoBattery = {}

PotatoBattery.id = Isaac.GetTrinketIdByName("Potato Battery")
PotatoBattery.MaxCharges = 6

---- Descriptions ----

PotatoBattery.description = {
	"{{Battery}} Use holded active item after entering an uncleared room, if it has 0 charges",
    "{{Warning}} Uses only those items that can have no more than ".. PotatoBattery.MaxCharges .." charges"
}
PotatoBattery.description_ru = {
    "{{Battery}} Использует имеющийся активный предмет привходу в незачищенную комнату, если он имеет 0 зарядов",
    "{{Warning}} Использует только те предметы, которые могут иметь не более ".. PotatoBattery.MaxCharges .." зарядов"
}
mod:CreateEID(PotatoBattery.id, PotatoBattery.description, "Potato Battery")
mod:CreateEID(PotatoBattery.id, PotatoBattery.description_ru, "Картофельная батарейка", "ru")

PotatoBattery.goldenData = {
    Numbers = {},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
PotatoBattery.goldenData_ru = {
    Numbers = {},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    PotatoBattery.id,
    PotatoBattery.goldenData.Numbers,
    PotatoBattery.goldenData.ExtraText,
    PotatoBattery.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    PotatoBattery.id,
    PotatoBattery.goldenData_ru.Numbers,
    PotatoBattery.goldenData_ru.ExtraText,
    PotatoBattery.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function PotatoBattery:roomEnter()
    local player = game:GetPlayer()
    local room = game:GetRoom()

    if player:HasTrinket(PotatoBattery.id) and not room:IsClear() then
        local activeItem = (Isaac.GetItemConfig():GetCollectible(player:GetActiveItem(ActiveSlot.SLOT_PRIMARY))).MaxCharges

        if activeItem and activeItem <= PotatoBattery.MaxCharges 
            and player:GetActiveCharge(ActiveSlot.SLOT_PRIMARY) == 0 then
            player:UseActiveItem(player:GetActiveItem(ActiveSlot.SLOT_PRIMARY), UseFlag.USE_MIMIC)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, PotatoBattery.roomEnter)