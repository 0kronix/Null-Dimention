---- Constants ----

local mod = NullDimention
local game = Game()
local CollectableCard = {}

CollectableCard.id = Isaac.GetTrinketIdByName("Collectable Card")

---- Descriptions ----

CollectableCard.description = {
	"{{Card}} Tarot cards in shops are free"
}
CollectableCard.description_ru = {
    "{{Card}} Карты таро в магазинах продаются бесплатно"
}
mod:CreateEID(CollectableCard.id, CollectableCard.description, "Collectable Card")
mod:CreateEID(CollectableCard.id, CollectableCard.description_ru, "Коллекционная карточка", "ru")

CollectableCard.goldenData = {
    Numbers = {},
    ExtraText = {
        Doubled = "{{Card}} Spawn random Tarot card upon entering shop",
        Tripled = "{{Card}} Spawn random Tarot card upon entering shop",
    },
    MaxMultiplier = nil,
}
CollectableCard.goldenData_ru = {
    Numbers = {},
    ExtraText = {
        Doubled = "{{Card}} Создаёт случайную Карту таро при входе в магазин",
        Tripled = "{{Card}} Создаёт случайную Карту таро при входе в магазин",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    CollectableCard.id,
    CollectableCard.goldenData.Numbers,
    CollectableCard.goldenData.ExtraText,
    CollectableCard.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    CollectableCard.id,
    CollectableCard.goldenData_ru.Numbers,
    CollectableCard.goldenData_ru.ExtraText,
    CollectableCard.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function CollectableCard:shopEnter()
    local player = game:GetPlayer()
    local room = game:GetRoom()

    if player:HasTrinket(CollectableCard.id) then
        local mult = player:GetTrinketMultiplier(CollectableCard.id)

        if room:GetType() == RoomType.ROOM_SHOP then
            for _, item in ipairs(Isaac.FindByType(5, 300)) do
                local pickup = item:ToPickup()

                if pickup then
                    pickup.AutoUpdatePrice = false
                    pickup.Price = -1000
                end
            end

            if mult >= 2 and room:IsFirstVisit() then
                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, 0,
                    room:FindFreePickupSpawnPosition(room:GetCenterPos()), Vector(0,0), nil)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, CollectableCard.shopEnter)