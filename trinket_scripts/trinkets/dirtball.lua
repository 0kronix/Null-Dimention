---- Constants ----

local mod = NullDimention
local game = Game()
local DirtBall = {}

DirtBall.id = Isaac.GetTrinketIdByName("Dirt Ball")
DirtBall.Tear = 12
DirtBall.TearMult = 2

---- Descriptions ----

DirtBall.description = {
	"Each ".. DirtBall.Tear .."th tear become Rock and have {{Damage}} X".. DirtBall.TearMult .." Damage multiplier"
}
DirtBall.description_ru = {
    "Каждая ".. DirtBall.Tear .."-ая слеза становиться Каменной и получает {{Damage}} X".. DirtBall.TearMult .." множитель Урона"
}
mod:CreateEID(DirtBall.id, DirtBall.description, "Dirt Ball")
mod:CreateEID(DirtBall.id, DirtBall.description_ru, "Шар из земли", "ru")

DirtBall.goldenData = {
    Numbers = {},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
DirtBall.goldenData_ru = {
    Numbers = {},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    DirtBall.id,
    DirtBall.goldenData.Numbers,
    DirtBall.goldenData.ExtraText,
    DirtBall.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    DirtBall.id,
    DirtBall.goldenData_ru.Numbers,
    DirtBall.goldenData_ru.ExtraText,
    DirtBall.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function DirtBall:fireTear(tear)
    local player = tear.SpawnerEntity:ToPlayer() or Isaac.GetPlayer()

    if player:HasTrinket(DirtBall.id) and tear.TearIndex % DirtBall.Tear == 0 then
        tear:AddTearFlags(TearFlags.TEAR_ROCK)
        tear:ChangeVariant(TearVariant.ROCK)
        tear.CollisionDamage = tear.CollisionDamage * DirtBall.TearMult
        SFXManager():Play(SoundEffect.SOUND_ROCK_CRUMBLE, 0.6)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, DirtBall.fireTear)