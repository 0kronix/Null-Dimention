local mod = NullDimention

function mod:GetRandomAroundPosition(position)
    local offsets = {
        Vector(-30, -30), Vector(0, -30), Vector(30, -30),
        Vector(-30, 0), Vector(30, 0),
        Vector(-30, 30), Vector(0, 30), Vector(30, 30)
    }
    return position + offsets[math.random(1, #offsets)]
end

function mod:TearsUp(firedelay, val)
    local currentTears = 30 / (firedelay + 1)
    local newTears = currentTears + val
    return math.max((30 / newTears) - 1, -0.99)
end

function mod:CreateEID(id, description, name, language)
	if EID then
		local combinedDescription

		-- Create the description
		for i, line in pairs(description) do
			if i == 1 then
				combinedDescription = line
			else
				combinedDescription = combinedDescription .. "#" .. line
			end
		end

		EID:addTrinket(id, combinedDescription, name, language)
	end
end

function mod:AddEIDGoldenTrinketData(id, numbersToMultiply, extraText, maxMultiplier, language)
	if EID then
		EID:addGoldenTrinketMetadata(id, {extraText.Doubled, extraText.Tripled}, numbersToMultiply, maxMultiplier, language)
	end
end