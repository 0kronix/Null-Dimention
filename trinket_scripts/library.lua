--[[ Utility functions ]]--
local mod = NullDimention

function mod:TearsUp(firedelay, val)
    local currentTears = 30 / (firedelay + 1)
    local newTears = currentTears + val
    return math.max((30 / newTears) - 1, -0.99)
end

function mod:GetMaxTrinketMultiplier(trinket, player, values)
	values = values or {1, 2, 3}
	local maxMulti = 0
	if player then
		if not player:HasTrinket(trinket) then
			return 0
		end
		maxMulti = values[1]
		if player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_BOX) and player:HasGoldenTrinket(trinket) then
			maxMulti = values[3]
		elseif player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_BOX) or player:HasGoldenTrinket(trinket) then
			maxMulti = values[2]
		end
	else
		for _, p in pairs(PlayerManager.GetPlayers()) do
			local multi = 0
			if p:HasTrinket(trinket) then
				multi = values[1]
				if p:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_BOX) and p:HasGoldenTrinket(trinket) then
					multi = values[3]
				elseif p:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_BOX) or p:HasGoldenTrinket(trinket) then
					multi = values[2]
				end
			end
			if maxMulti < multi then
				maxMulti = multi
			end
		end
	end
	return maxMulti
end

-- Get a vector with a random angle
function mod:RandomVector(length)
	local vector = Vector.FromAngle(mod:Random(359))
	if length then
		vector = vector:Resized(length)
	end
	return vector
end


-- Get a random sign
function mod:RandomSign()
	if mod:Random(1) == 0 then
		return -1
	end
	return 1
end


-- Get a random index from a table
function mod:RandomIndex(fromTable)
	return fromTable[mod:Random(1, #fromTable)]
end



--[[ Item functions ]]--
-- Check if any players have the specified item
function mod:DoesAnyoneHaveItem(id, onlyRealItem)
	for i = 0, Game():GetNumPlayers() - 1 do
		if Isaac.GetPlayer(i):HasCollectible(id, onlyRealItem) then
			return true
		end
	end
	return false
end

-- Check if any players have the specified trinket
function mod:DoesAnyoneHaveTrinket(id, onlyRealItem)
	for i = 0, Game():GetNumPlayers() - 1 do
		if Isaac.GetPlayer(i):HasTrinket(id, onlyRealItem) then
			return true
		end
	end
	return false
end


-- Create EID entry
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

-- Create EID golden trinket metadata
function mod:AddEIDGoldenTrinketData(id, numbersToMultiply, extraText, maxMultiplier, language)
	if EID then
		EID:addGoldenTrinketMetadata(id, {extraText.Doubled, extraText.Tripled}, numbersToMultiply, maxMultiplier, language)
	end
end