---- Constants ----

local mod = NullDimension
local game = Game()
local eBitMush = {}

eBitMush.id = Isaac.GetTrinketIdByName("8-bit Mush")
eBitMush.Percent = 5
eBitMush.Chance = 25

---- Descriptions ----

eBitMush.description = {
	"-".. eBitMush.Percent .."% size at start of each floor",
    "{{Warning}} ".. eBitMush.Chance .."% chance to be destroyed and give +50% size instead"
}
eBitMush.description_ru = {
    "-".. eBitMush.Percent .."% к размеру в начале каждого этажа",
    "{{Warning}} ".. eBitMush.Chance .."% шанс быть уничтоженным и получить +50% к размеру, вместо этого"
}
mod:CreateEID(eBitMush.id, eBitMush.description, "8-bit Mush")
mod:CreateEID(eBitMush.id, eBitMush.description_ru, "8-битный грибочек", "ru")

eBitMush.goldenData = {
    Numbers = {eBitMush.Percent},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
eBitMush.goldenData_ru = {
    Numbers = {eBitMush.Percent},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    eBitMush.id,
    eBitMush.goldenData.Numbers,
    eBitMush.goldenData.ExtraText,
    eBitMush.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    eBitMush.id,
    eBitMush.goldenData_ru.Numbers,
    eBitMush.goldenData_ru.ExtraText,
    eBitMush.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function eBitMush:NewFloor()
    local player = game:GetPlayer()
    local data = player:GetData()
    
    if player:HasTrinket(eBitMush.id) then
        local mult = player:GetTrinketMultiplier(eBitMush.id)

        data.bitMush = data.bitMush or 0
        data.bitMush = data.bitMush + eBitMush.Percent * mult

        if mod:trinketProbCheck(player, eBitMush.id, eBitMush.Chance * mult) then
            player:TryRemoveTrinket(eBitMush.id)

            data.bitMush = -50

            player:AnimateSad()
        else
            player:AnimateTrinket(eBitMush.id)
            SFXManager():Play(SoundEffect.SOUND_1UP, 0.8)
        end

        player:AddCacheFlags(CacheFlag.CACHE_SIZE, true)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, eBitMush.NewFloor)

function eBitMush:onCache(player, cacheFlag)
    if cacheFlag & CacheFlag.CACHE_SIZE == CacheFlag.CACHE_SIZE then
        if player:HasTrinket(eBitMush.id) then
            local data = player:GetData()

            data.bitMush = data.bitMush or 0

            player.SpriteScale = player.SpriteScale - player.SpriteScale * data.bitMush * 0.01
        end
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, eBitMush.onCache)