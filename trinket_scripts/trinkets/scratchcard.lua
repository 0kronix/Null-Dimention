---- Constants ----

local mod = NullDimension
local game = Game()
local ScratchCard = {}

ScratchCard.id = Isaac.GetTrinketIdByName("Scratch Card")
ScratchCard.Chances = {[1] = 54,
                       [2] = 74,
                       [3] = 98,
    }

---- Descriptions ----

ScratchCard.description = {
	"One of the following after clearing room:",
    "".. ScratchCard.Chances[1] .."% to recieve nothing",
    "↓ ".. (ScratchCard.Chances[2] - ScratchCard.Chances[1]) .."% to lose 5 coins",
    "↑ ".. (ScratchCard.Chances[3] - ScratchCard.Chances[2]) .."% to recieve 3 coins",
    "↑ ".. (100 - ScratchCard.Chances[3]) .."% to spawn Golden coin"
}
ScratchCard.description_ru = {
    "Один из эффектов после зачистки комнаты:",
    "".. ScratchCard.Chances[1] .."% ничего не получить",
    "↓ ".. (ScratchCard.Chances[2] - ScratchCard.Chances[1]) .."% потерять 5 монет",
    "↑ ".. (ScratchCard.Chances[3] - ScratchCard.Chances[2]) .."% получить 3 монеты",
    "↑ ".. (100 - ScratchCard.Chances[3]) .."% создать Золотую монету"
}
mod:CreateEID(ScratchCard.id, ScratchCard.description, "Scratch Card")
mod:CreateEID(ScratchCard.id, ScratchCard.description_ru, "Скретч Карта", "ru")

ScratchCard.goldenData = {
    Numbers = {},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
ScratchCard.goldenData_ru = {
    Numbers = {},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    ScratchCard.id,
    ScratchCard.goldenData.Numbers,
    ScratchCard.goldenData.ExtraText,
    ScratchCard.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    ScratchCard.id,
    ScratchCard.goldenData_ru.Numbers,
    ScratchCard.goldenData_ru.ExtraText,
    ScratchCard.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function ScratchCard:roomClear()
    local room = game:GetRoom()
    
    for _, player in pairs(PlayerManager.GetPlayers()) do
        if player:HasTrinket(ScratchCard.id) then
            local rng = player:GetTrinketRNG(ScratchCard.id)
            local random = rng:RandomInt(1, 101)

            if random > ScratchCard.Chances[1] and random <= ScratchCard.Chances[2] then
                player:AddCoins(-5)
                player:AnimateSad()
            elseif random > ScratchCard.Chances[2] and random <= ScratchCard.Chances[3] then
                player:AddCoins(3)
                player:AnimateHappy()
            elseif random > ScratchCard.Chances[3] then
                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_GOLDEN, 
                    room:FindFreePickupSpawnPosition(mod:GetRandomAroundPosition(player.Position)), Vector(0,0), nil)
                SFXManager():Play(SoundEffect.SOUND_1UP, 0.5)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, ScratchCard.roomClear)