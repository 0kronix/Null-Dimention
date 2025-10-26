local description = {
	"{{Collectible257}} 4% chance to fart",
    "{{Collectible401}} 1% chance to poop",
}
mod:CreateEID(TrinketType.dentalion, description)
mod:CreateEncylopedie(TrinketType.dentalion, description)

local goldenData = {
	Numbers = {},
	ExtraText = {
		Doubled = "Chances are rolled again",
		Tripled = "Chances are rolled twice more",
	},
	MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(TrinketType.dentalion, goldenData.Numbers, goldenData.ExtraText, goldenData.MaxMultiplier)

function mod:FireMind(tear)
    for i = 0, Game():GetNumPlayers() - 1 do
		local player = Game():GetPlayer(i)
		for x = 1, player:GetTrinketMultiplier(TrinketType.dentalion) do
			if mod:Random(1, 25) == 1 then
                tear:AddTearFlags(TearFlags.TEAR_BURN)
                tear:ChangeVariant(TearVariant.FIRE_MIND)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.FireMind)

function mod:Explosivo(tear)
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
        for x = 1, player:GetTrinketMultiplier(TrinketType.dentalion) do
            if mod:Random(1, 100) == 1 then
                tear:AddTearFlags(TearFlags.TEAR_STICKY)
                tear:ChangeVariant(TearVariant.EXPLOSIVO)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.Explosivo)