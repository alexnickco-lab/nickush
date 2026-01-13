-- Rookie scenario template

-- Helper function to get tier 5 buildings for capital based on race
-- Returns buildings list and branch choices for mercenary alignment
-- Implements conditional building chains with random branch selection
function autobuilt(playerRace)
	local buildings = {}
	local branchChoices = {}
	
	if playerRace == Race.Human then
		-- Empire conditional buildings:
		-- if g000bb0019 then g000bb0020 and g000bb0021
		-- if g000bb0016 then (g000bb0017 and g000bb0018) or (g000bb0168 and g000bb0169)
		-- if g000bb0012 then (g000bb0013 and g000bb0014) or (g000bb0182 and g000bb0183) or (g000bb0015 and g000bb0143)
		-- if g000bb0001 then g000bb0002
		-- if g000bb0136 then g000bb0137
		-- if g000bb0007 then g000bb0008
		
		-- Base building
		table.insert(buildings, 'g000bb0012')
		
		-- g000bb0012 branch - choose one of 3 options
		local choice1 = math.random(3)
		if choice1 == 1 then
			table.insert(buildings, 'g000bb0013')
			table.insert(buildings, 'g000bb0014')
			branchChoices.empireBranch = 'g000bb0013'
		elseif choice1 == 2 then
			table.insert(buildings, 'g000bb0182')
			table.insert(buildings, 'g000bb0183')
			branchChoices.empireBranch = 'g000bb0182'
		else
			table.insert(buildings, 'g000bb0015')
			table.insert(buildings, 'g000bb0143')
			branchChoices.empireBranch = 'g000bb0015'
		end
		
		-- Choose between g000bb0016 and g000bb0019
		local choice2 = math.random(2)
		if choice2 == 1 then
			table.insert(buildings, 'g000bb0016')
			branchChoices.empireBranch2 = 'g000bb0016'
			-- g000bb0016 branch - choose one of 2 options
			local choice2a = math.random(2)
			if choice2a == 1 then
				table.insert(buildings, 'g000bb0017')
				table.insert(buildings, 'g000bb0018')
			else
				table.insert(buildings, 'g000bb0168')
				table.insert(buildings, 'g000bb0169')
			end
		else
			table.insert(buildings, 'g000bb0019')
			table.insert(buildings, 'g000bb0020')
			table.insert(buildings, 'g000bb0021')
			branchChoices.empireBranch2 = 'g000bb0019'
		end
		
		-- Add one of the three mage tower branches (g000bb0001, g000bb0136, or g000bb0007) with their dependents
		local choice3 = math.random(3)
		if choice3 == 1 then
			table.insert(buildings, 'g000bb0001')
			table.insert(buildings, 'g000bb0002')
			branchChoices.empireMageBranch = 'g000bb0001'
		elseif choice3 == 2 then
			table.insert(buildings, 'g000bb0136')
			table.insert(buildings, 'g000bb0137')
			branchChoices.empireMageBranch = 'g000bb0136'
		else
			table.insert(buildings, 'g000bb0007')
			table.insert(buildings, 'g000bb0008')
			branchChoices.empireMageBranch = 'g000bb0007'
		end
		
	elseif playerRace == Race.Undead then
		-- Undead conditional buildings:
		-- if g000bb0164 then g000bb0089
		-- if g000bb0083 then g000bb0084 or g000bb0191
		-- if g000bb0079 then g000bb0080 and g000bb0163
		-- if g000bb0075 then g000bb0076
		
		-- Choose between g000bb0075 and g000bb0079
		local choice1 = math.random(2)
		if choice1 == 1 then
			table.insert(buildings, 'g000bb0075')
			table.insert(buildings, 'g000bb0076')
			branchChoices.undeadBranch1 = 'g000bb0075'
		else
			table.insert(buildings, 'g000bb0079')
			table.insert(buildings, 'g000bb0080')
			table.insert(buildings, 'g000bb0163')
			branchChoices.undeadBranch1 = 'g000bb0079'
		end
		
		-- Choose between g000bb0083 and g000bb0164
		local choice2 = math.random(2)
		if choice2 == 1 then
			table.insert(buildings, 'g000bb0083')
			branchChoices.undeadBranch2 = 'g000bb0083'
			-- g000bb0083 branch - choose one of 2 options
			local choice2a = math.random(2)
			if choice2a == 1 then
				table.insert(buildings, 'g000bb0084')
			else
				table.insert(buildings, 'g000bb0191')
			end
		else
			table.insert(buildings, 'g000bb0164')
			table.insert(buildings, 'g000bb0089')
			branchChoices.undeadBranch2 = 'g000bb0164'
		end
		
		-- Always add g000bb0092
		table.insert(buildings, 'g000bb0092')
		
	elseif playerRace == Race.Heretic then
		-- Legions conditional buildings:
		-- if g000bb0055 then g000bb0056 or g000bb0059
		-- if g000bb0061 then g000bb0062 and g000bb0063
		-- if g000bb0064 then (g000bb0065 and g000bb0066) or g000bb0068 or g000bb0144
		
		-- Choose between g000bb0055 and g000bb0061
		local choice1 = math.random(2)
		if choice1 == 1 then
			table.insert(buildings, 'g000bb0055')
			branchChoices.legionsBranch = 'g000bb0055'
			-- g000bb0055 branch - choose one of 2 options
			local choice1a = math.random(2)
			if choice1a == 1 then
				table.insert(buildings, 'g000bb0056')
			else
				table.insert(buildings, 'g000bb0059')
			end
		else
			table.insert(buildings, 'g000bb0061')
			table.insert(buildings, 'g000bb0062')
			table.insert(buildings, 'g000bb0063')
			branchChoices.legionsBranch = 'g000bb0061'
		end
		
		-- Always add g000bb0064 and g000bb0065
		table.insert(buildings, 'g000bb0064')
		table.insert(buildings, 'g000bb0065')
		-- g000bb0065 branch - choose one of 3 options
		local choice2 = math.random(3)
		if choice2 == 1 then
			table.insert(buildings, 'g000bb0066')
		elseif choice2 == 2 then
			table.insert(buildings, 'g000bb0068')
		else
			table.insert(buildings, 'g000bb0144')
		end
		
		-- Always add g000bb0186
		table.insert(buildings, 'g000bb0186')
		
	elseif playerRace == Race.Dwarf then
		-- Clans conditional buildings:
		-- if g000bb0034 then g000bb0035 or g000bb0175 or (g000bb0036 and g000bb0142)
		-- if g000bb0041 then g000bb0042 or g000bb0044 or g000bb0149
		-- if g000bb0037 then g000bb0038 or g000bb0040 or g000bb0173
		
		-- Always add g000bb0034
		table.insert(buildings, 'g000bb0034')
		-- g000bb0034 branch - choose one of 3 options
		local choice1 = math.random(3)
		if choice1 == 1 then
			table.insert(buildings, 'g000bb0035')
		elseif choice1 == 2 then
			table.insert(buildings, 'g000bb0175')
		else
			table.insert(buildings, 'g000bb0036')
			table.insert(buildings, 'g000bb0142')
		end
		
		-- Always add g000bb0041
		table.insert(buildings, 'g000bb0041')
		-- g000bb0041 branch - choose one of 3 options
		local choice2 = math.random(3)
		if choice2 == 1 then
			table.insert(buildings, 'g000bb0042')
		elseif choice2 == 2 then
			table.insert(buildings, 'g000bb0044')
		else
			table.insert(buildings, 'g000bb0149')
		end
		
		-- Always add g000bb0037
		table.insert(buildings, 'g000bb0037')
		-- g000bb0037 branch - choose one of 3 options
		local choice3 = math.random(3)
		if choice3 == 1 then
			table.insert(buildings, 'g000bb0038')
		elseif choice3 == 2 then
			table.insert(buildings, 'g000bb0040')
		else
			table.insert(buildings, 'g000bb0173')
		end
		
		-- Always add g000bb0026
		table.insert(buildings, 'g000bb0026')
		
	elseif playerRace == Race.Elf then
		-- Elves conditional buildings:
		-- if g000bb0109 then g000bb0111 or g000bb0110 or (g000bb0151 and g000bb0160)
		-- if g000bb0112 then (g000bb0113 and g000bb0114) or g000bb0124 or g000bb0148
		-- if g000bb0100 then g000bb0101 or g000bb0134
		-- if g000bb0102 then g000bb0180
		-- if g000bb0116 then g000bb0117
		
		-- Always add g000bb0109
		table.insert(buildings, 'g000bb0109')
		-- g000bb0109 branch - choose one of 3 options
		local choice1 = math.random(3)
		if choice1 == 1 then
			table.insert(buildings, 'g000bb0111')
		elseif choice1 == 2 then
			table.insert(buildings, 'g000bb0110')
		else
			table.insert(buildings, 'g000bb0151')
			table.insert(buildings, 'g000bb0160')
		end
		
		-- Always add g000bb0112 and g000bb0113
		table.insert(buildings, 'g000bb0112')
		table.insert(buildings, 'g000bb0113')
		-- g000bb0113 branch - choose one of 3 options
		local choice2 = math.random(3)
		if choice2 == 1 then
			table.insert(buildings, 'g000bb0114')
		elseif choice2 == 2 then
			table.insert(buildings, 'g000bb0124')
		else
			table.insert(buildings, 'g000bb0148')
		end
		
		-- Choose between g000bb0100 and g000bb0102
		local choice3 = math.random(2)
		if choice3 == 1 then
			table.insert(buildings, 'g000bb0100')
			branchChoices.elvesBranch = 'g000bb0100'
			-- g000bb0100 branch - choose one of 2 options
			local choice3a = math.random(2)
			if choice3a == 1 then
				table.insert(buildings, 'g000bb0101')
			else
				table.insert(buildings, 'g000bb0134')
			end
		else
			table.insert(buildings, 'g000bb0102')
			table.insert(buildings, 'g000bb0180')
			branchChoices.elvesBranch = 'g000bb0102'
		end
		
		-- Always add g000bb0116
		table.insert(buildings, 'g000bb0116')
		table.insert(buildings, 'g000bb0117')
	end
	
	return buildings, branchChoices
end

-- Helper function to create guard stack for mercenaries based on race
function getMercenaryGuard(race)
	local guardId
	
	if race == Race.Heretic then
		guardId = 'g000uu5131'  -- Legions
	elseif race == Race.Undead then
		guardId = 'g000uu5131'  -- Undead
	elseif race == Race.Dwarf then
		guardId = 'g000uu5131'  -- Clans
	elseif race == Race.Human then
		guardId = 'g000uu5131'  -- Empire
	elseif race == Race.Elf then
		guardId = 'g000uu5131'  -- Elves
	end
	
	return {
		count = 1,
		owner = race,
		value = { min = 1, max = 1 },
		leaderIds = {guardId},
		leaderModifiers = { 'g201um9209',  'g201um9209',  'g201um9209', 'g000um9032', 'g200um9002', 'g201um9081', 'g200um9002', 'g200um9002','g200um9002','g200um9002','g200um9002', 'g000um9008','g000um9008','g000um9008','g201um9130','g201um9130','g201um9130'}
	}
end

-- Helper function to get capital mercenary stacks based on race and building choices
function getCapitalMercenaries(race, branchChoices)
	local units = {}
	
	if race == Race.Heretic then
		-- Legions: 2 of these OR 1 of these
		local twoOf = {'g000uu0053'} -- Always available
		local oneOf = {'g000uu0058', 'g004uu6101'}
		
		-- Add branch-specific unit based on building choice, exclude the other
		if branchChoices.legionsBranch == 'g000bb0055' then
			table.insert(twoOf, 'g000uu0063') -- Unit for building g000bb0055
			-- g000uu0067 is NOT added (it's for the other branch)
		elseif branchChoices.legionsBranch == 'g000bb0061' then
			table.insert(twoOf, 'g000uu0067') -- Unit for building g000bb0061
			-- g000uu0063 is NOT added (it's for the other branch)
		end
		
		if math.random(2) == 1 then
			-- Return 2 different mercenaries, 2 copies of each (4 total)
			local merc1 = twoOf[math.random(#twoOf)]
			local merc2 = twoOf[math.random(#twoOf)]
			-- Ensure they're different
			while merc2 == merc1 do
				merc2 = twoOf[math.random(#twoOf)]
			end
			units = {
				{id = merc1, level = 2, unique = true}, 
				{id = merc1, level = 2, unique = true},
				{id = merc2, level = 2, unique = true},
				{id = merc2, level = 2, unique = true}
			}
		else
			-- Return 1 mercenary type, 2 copies (2 total)
			local merc = oneOf[math.random(#oneOf)]
			units = {
				{id = merc, level = 2, unique = true},
				{id = merc, level = 2, unique = true}
			}
		end
		
	elseif race == Race.Human then
		-- Empire: 2 different ones, 2 copies of each (4 total)
		-- Always available units (not tied to any branch)
		local options = {'g000uu0009'}
		
		-- Add units based on the second building choice (g000bb0016 vs g000bb0019)
		if branchChoices.empireBranch2 == 'g000bb0016' then
			table.insert(options, 'g000uu0012') -- Unit for building g000bb0016
		elseif branchChoices.empireBranch2 == 'g000bb0019' then
			table.insert(options, 'g000uu0016') -- Unit for building g000bb0019
		end
		
		-- Add ONLY units from the chosen mage tower branch
		if branchChoices.empireMageBranch == 'g000bb0001' then
			table.insert(options, 'g000uu0002')
			table.insert(options, 'g003uu5002')
		elseif branchChoices.empireMageBranch == 'g000bb0136' then
			table.insert(options, 'g000uu2014')
			table.insert(options, 'g000uu8310')
		elseif branchChoices.empireMageBranch == 'g000bb0007' then
			table.insert(options, 'g000uu0004')
			table.insert(options, 'g000uu2029')
		end
		
		local merc1 = options[math.random(#options)]
		local merc2 = options[math.random(#options)]
		-- Ensure they're different
		while merc2 == merc1 do
			merc2 = options[math.random(#options)]
		end
		units = {
			{id = merc1, level = 2, unique = true}, 
			{id = merc1, level = 2, unique = true},
			{id = merc2, level = 2, unique = true},
			{id = merc2, level = 2, unique = true}
		}
		
	elseif race == Race.Undead then
		-- Undead: 2 of these OR 1 of this
		local twoOf = {'g003uu5013'} -- Always available
		local oneOf = {'g000uu0094'}
		
		-- Add ONLY units from the chosen branches, exclude the others
		if branchChoices.undeadBranch1 == 'g000bb0075' then
			table.insert(twoOf, 'g000uu0087')
			-- g000uu0090 is NOT added
		elseif branchChoices.undeadBranch1 == 'g000bb0079' then
			table.insert(twoOf, 'g000uu0090')
			-- g000uu0087 is NOT added
		end
		
		if branchChoices.undeadBranch2 == 'g000bb0083' then
			table.insert(twoOf, 'g000uu0081')
			-- g000uu7542 is NOT added
		elseif branchChoices.undeadBranch2 == 'g000bb0164' then
			table.insert(twoOf, 'g000uu7542')
			-- g000uu0081 is NOT added
		end
		
		if math.random(2) == 1 then
			-- Return 2 different mercenaries, 2 copies of each (4 total)
			local merc1 = twoOf[math.random(#twoOf)]
			local merc2 = twoOf[math.random(#twoOf)]
			-- Ensure they're different
			while merc2 == merc1 do
				merc2 = twoOf[math.random(#twoOf)]
			end
			units = {
				{id = merc1, level = 2, unique = true}, 
				{id = merc1, level = 2, unique = true},
				{id = merc2, level = 2, unique = true},
				{id = merc2, level = 2, unique = true}
			}
		else
			-- Return 1 mercenary type, 2 copies (2 total)
			units = {
				{id = oneOf[1], level = 2, unique = true},
				{id = oneOf[1], level = 2, unique = true}
			}
		end
		
	elseif race == Race.Dwarf then
		-- Clans: 2 of these OR 1 of these (no building branches, so unchanged)
		local twoOf = {'g000uu0037', 'g000uu0027', 'g000uu0034'}
		local oneOf = {'g000uu0030', 'g001uu7571'}
		
		if math.random(2) == 1 then
			-- Return 2 different mercenaries, 2 copies of each (4 total)
			local merc1 = twoOf[math.random(#twoOf)]
			local merc2 = twoOf[math.random(#twoOf)]
			-- Ensure they're different
			while merc2 == merc1 do
				merc2 = twoOf[math.random(#twoOf)]
			end
			units = {
				{id = merc1, level = 2, unique = true}, 
				{id = merc1, level = 2, unique = true},
				{id = merc2, level = 2, unique = true},
				{id = merc2, level = 2, unique = true}
			}
		else
			-- Return 1 mercenary type, 2 copies (2 total)
			local merc = oneOf[math.random(#oneOf)]
			units = {
				{id = merc, level = 2, unique = true},
				{id = merc, level = 2, unique = true}
			}
		end
		
	elseif race == Race.Elf then
		-- Elves: 2 of these OR 1 of these
		-- Always available units (not tied to any branch)
		local twoOf = {'g000uu8026', 'g000uu8032'}
		local oneOf = {'g003uu8038', 'g000uu8030'}
		
		-- Add ONLY the unit from the chosen branch
		if branchChoices.elvesBranch == 'g000bb0102' then
			table.insert(twoOf, 'g000uu8015')
			-- g000uu8016 is NOT added
		elseif branchChoices.elvesBranch == 'g000bb0100' then
			table.insert(twoOf, 'g000uu8016')
			-- g000uu8015 is NOT added
		end
		
		if math.random(2) == 1 then
			-- Return 2 different mercenaries, 2 copies of each (4 total)
			local merc1 = twoOf[math.random(#twoOf)]
			local merc2 = twoOf[math.random(#twoOf)]
			-- Ensure they're different
			while merc2 == merc1 do
				merc2 = twoOf[math.random(#twoOf)]
			end
			units = {
				{id = merc1, level = 2, unique = true}, 
				{id = merc1, level = 2, unique = true},
				{id = merc2, level = 2, unique = true},
				{id = merc2, level = 2, unique = true}
			}
		else
			-- Return 1 mercenary type, 2 copies (2 total)
			local merc = oneOf[math.random(#oneOf)]
			units = {
				{id = merc, level = 2, unique = true},
				{id = merc, level = 2, unique = true}
			}
		end
	end
	
	return {{units = units, guard = getMercenaryGuard(race)}}
end

-- Helper function to randomly select one item from 6 options
function orr6(what1, what2, what3, what4, what5, what6)
	local radn = math.random(1, 6)
	if radn == 1 then
		return what1
	elseif radn == 2 then
		return what2
	elseif radn == 3 then
		return what3
	elseif radn == 4 then
		return what4
	elseif radn == 5 then
		return what5
	elseif radn == 6 then
		return what6
	end
end

-- Helper function to randomly select one item from 5 options
function orr5(what1, what2, what3, what4, what5)
	local radn = math.random(1, 5)
	if radn == 1 then
		return what1
	elseif radn == 2 then
		return what2
	elseif radn == 3 then
		return what3
	elseif radn == 4 then
		return what4
	elseif radn == 5 then
		return what5
	end
end

function getZoneMana(race)
	local mines = {}
	if race == nil then
		mines = {
			gold = 1,
			lifeMana = 1,
			runicMana = 1,
			deathMana = 1,
			infernalMana = 1,
			groveMana = 1,
		}
	else
		if race == Race.Human then
			mines = {
				gold = 0,
				lifeMana = 1,
			}
		elseif race == Race.Dwarf then
			mines = {
				gold = 0,
				runicMana = 1,
			}
		elseif race == Race.Undead then
			mines = {
				gold = 0,
				deathMana = 1,
			}
		elseif race == Race.Heretic then
			mines = {
				gold = 0,
				infernalMana = 1,
			}
		elseif race == Race.Elf then
			mines = {
				gold = 0,
				groveMana = 1,
			}
		end

-- Same as getZoneMana(nil) but with gold disabled
function getZoneManaNoGold()
	return {
		gold = 0,
		lifeMana = 1,
		runicMana = 1,
		deathMana = 1,
		infernalMana = 1,
		groveMana = 1,
	}
end


	end
	return mines
end

-- function to create 1 bag with 1 random item
function createZoneBags()
	return {
		count = 1,
		loot = {
			items = {
				orr5(
					{ id = 'g001ig0526', min = 1, max = 1 },
					{ id = 'g001ig0527', min = 1, max = 1 },
					{ id = 'g001ig0529', min = 1, max = 1 },
					{ id = 'g001ig0528', min = 1, max = 1 },
					{ id = 'g001ig0525', min = 1, max = 1 }
				)
			}
		}
	}
end

-- Helper function to create mage tower with random spells
function createMageTower()
	-- Pool of optional spells (will pick 4 random ones)
	local spellPool = {
		'g000ss0008', 'g000ss0031', 'g000ss0046', 'g000ss0071', 
		'g000ss0108', 'g000ss0124', 'g000ss0123', 'g000ss0121', 'g000ss0174'
	}
	
	-- Shuffle the pool
	for i = #spellPool, 2, -1 do
		local j = math.random(i)
		spellPool[i], spellPool[j] = spellPool[j], spellPool[i]
	end
	
	-- Create spell list with the mandatory spells + 4 random ones
	local spells = {
		'g000ss0210',  -- Mandatory spell (always present)
		'g000ss0204'   -- Mandatory spell (always present)
	}
	
	-- Add first 4 spells from shuffled pool
	for i = 1, 4 do
		table.insert(spells, spellPool[i])
	end
	
	return {
		spells = spells,
		guard = {
			value = { min = 800, max = 1000 }
		}
	}
end

-- Helper function to create central zone merchant with random items
function createCentralMerchant()
	-- Pool of spheres (will pick 5 random)
	local spherePool = {
		'g000ig9025', 'g001ig0136', 'g000ig9043', 'g000ig9020', 'g000ig9032',
		'g001ig0181', 'g000ig9007', 'g000ig9040', 'g000ig9039', 'g000ig9006',
		'g000ig9014', 'g000ig9023', 'g001ig0059'
	}
	
	-- Pool of auras (will pick 3 random)
	local auraPool = {
		'g001ig0563', 'g001ig0025', 'g001ig0024', 'g001ig0021',
		'g001ig0023', 'g001ig0031'
	}
	
	-- Pool of potions (will pick 3 random)
	local potionPool = {
		'g001ig0314', 'g001ig0356', 'g001ig0317', 'g001ig0324',
		'g001ig0308', 'g001ig0325', 'g001ig0318', 'g001ig0534',
		'g001ig0312', 'g001ig0342'
	}
	
	-- Pool of talismans (will pick 1 random)
	local talismanPool = {
		'g000ig9103', 'g001ig0202', 'g000ig9120', 'g001ig0259'
	}
	
	-- Shuffle all pools
	for i = #spherePool, 2, -1 do
		local j = math.random(i)
		spherePool[i], spherePool[j] = spherePool[j], spherePool[i]
	end
	
	for i = #auraPool, 2, -1 do
		local j = math.random(i)
		auraPool[i], auraPool[j] = auraPool[j], auraPool[i]
	end
	
	for i = #potionPool, 2, -1 do
		local j = math.random(i)
		potionPool[i], potionPool[j] = potionPool[j], potionPool[i]
	end
	
	for i = #talismanPool, 2, -1 do
		local j = math.random(i)
		talismanPool[i], talismanPool[j] = talismanPool[j], talismanPool[i]
	end
	
	-- Build the items list
	local items = {}
	
	-- Add 5 random spheres (1 each)
	for i = 1, 5 do
		table.insert(items, { id = spherePool[i], min = 1, max = 1 })
	end
	
	-- Add 3 random auras (1 each)
	for i = 1, 3 do
		table.insert(items, { id = auraPool[i], min = 1, max = 1 })
	end
	
	-- Add 3 random potions (1 each)
	for i = 1, 3 do
		table.insert(items, { id = potionPool[i], min = 1, max = 1 })
	end
	
	-- Add 1 random talisman
	table.insert(items, { id = talismanPool[1], min = 1, max = 1 })
	
	return {
		items = items
	}
end

function rMarketsZone4()
return {
{
	exchangeRates = [[
		function getExchangeRates(visitor)
				local k1 = 3
				local k2 = 1
			return {
				{
					Resource.Gold,
					{
					{ Resource.LifeMana, k1, k2 },
					{ Resource.DeathMana, k1, k2 },
					{ Resource.RunicMana, k1, k2 },
					{ Resource.InfernalMana, k1, k2 },
					{ Resource.GroveMana, k1, k2 }
					}
				},
				{
					Resource.LifeMana,
					{
					{ Resource.Gold, k1, k2 },
					{ Resource.DeathMana, k1, k2 },
					{ Resource.RunicMana, k1, k2 },
					{ Resource.InfernalMana, k1, k2 },
					{ Resource.GroveMana, k1, k2 }
					}
				},
				{
					Resource.DeathMana,
					{
					{ Resource.LifeMana, k1, k2 },
					{ Resource.Gold, k1, k2 },
					{ Resource.RunicMana, k1, k2 },
					{ Resource.InfernalMana, k1, k2 },
					{ Resource.GroveMana, k1, k2 }
					}
				},
				{
					Resource.RunicMana,
					{
					{ Resource.LifeMana, k1, k2 },
					{ Resource.DeathMana, k1, k2 },
					{ Resource.Gold, k1, k2 },
					{ Resource.InfernalMana, k1, k2 },
					{ Resource.GroveMana, k1, k2 }
					}
				},
				{
					Resource.InfernalMana,
					{
					{ Resource.LifeMana, k1, k2 },
					{ Resource.DeathMana, k1, k2 },
					{ Resource.RunicMana, k1, k2 },
					{ Resource.Gold, k1, k2 },
					{ Resource.GroveMana, k1, k2 }
					}
				},
				{
					Resource.GroveMana,
					{
					{ Resource.LifeMana, k1, k2 },
					{ Resource.DeathMana, k1, k2 },
					{ Resource.RunicMana, k1, k2 },
					{ Resource.InfernalMana, k1, k2 },
					{ Resource.Gold, k1, k2 }
					}
				},
			}
		end
]],


    stock = {
		{resource = Resource.Gold, value = { min = 500, max = 500 }},
		{resource = Resource.LifeMana, value = { min = 500, max = 500 }},
		{resource = Resource.DeathMana, value = { min = 500, max = 500 }},
		{resource = Resource.InfernalMana, value = { min = 500, max = 500 }},
        {resource = Resource.RunicMana, value = { min = 500, max = 500 }},
        {resource = Resource.GroveMana, value = { min = 500, max = 500 }}
    },
}
}
end

-- function to create ruins with unique items
function createAllRuins()
	local itemPool = {
		'g000ig3017', 'g001ig0488', 'g000ig3019', 'g001ig0411', 
		'g001ig0415', 'g001ig0156', 'g000ig2006', 'g001ig0422',
		'g001ig0424', 'g001ig0116', 'g001ig0071', 'g001ig0045',
		'g001ig0585', 'g001ig0042', 'g001ig0124', 'g000ig2004',
		'g000ig2003', 'g001ig0158', 'g001ig0360', 'g001ig0291',
		'g001ig0362', 'g001ig0358', 'g000ig8005', 'g001ig0050',
		'g002ig0020', 'g001ig0112', 'g001ig0539', 'g001ig0591',
		'g002ig0013', 'g001ig0506', 'g000ig1017', 'g001ig0367',
		'g001ig0115', 'g001ig0037'
	}
	
	-- Shuffle the pool
	for i = #itemPool, 2, -1 do
		local j = math.random(i)
		itemPool[i], itemPool[j] = itemPool[j], itemPool[i]
	end
	
	local allRuins = {}
	local itemIndex = 1
	
	-- Zones 0,1 (indices 1,2): starting zones - 8 ruins each
	for zoneIdx = 1, 2 do
		allRuins[zoneIdx] = {}
		for i = 1, 8 do
			table.insert(allRuins[zoneIdx], {
				gold = { min = 200, max = 250 },
				guard = { value = { min = 100, max = 150 }},
				loot = { items = {{ id = itemPool[itemIndex], min = 1, max = 1 }}}
			})
			itemIndex = itemIndex + 1
		end
	end
	
	-- Zones 2,3,4,5,7,8,9,10 (indices 3,4,5,6,7,8,9,10): treasure zones - 2 ruins each
	local treasureZoneIndices = {3, 4, 5, 6, 7, 8, 9, 10}
	for _, zoneIdx in ipairs(treasureZoneIndices) do
		allRuins[zoneIdx] = {}
		for i = 1, 2 do
			table.insert(allRuins[zoneIdx], {
				gold = { min = 300, max = 350 },
				guard = { value = { min = 150, max = 200 }},
				loot = { items = {{ id = itemPool[itemIndex], min = 1, max = 1 }}}
			})
			itemIndex = itemIndex + 1
		end
	end
	
	return allRuins
end

function getScenarioVariables()
	local result = {}

	local lords = { 'WARRIOR', 'MAGE', 'GUILDMASTER' }
	local l_vars = {
		{ name = '_GOLD_INCOME', value = {50, -100, -100} },           -- WARRIOR: +50 gold, MAGE: --100, GUILDMASTER: -100
		{ name = '_MANA_INCOME', value = {0, 75, 0} },            -- WARRIOR: 0, MAGE: +75 mana, GUILDMASTER: 0
	}

	for i, lord in pairs(lords) do
		for _, v in pairs(l_vars) do
			table.insert(result, { name = lord..v['name'], value = v['value'][i] })
		end
	end

	local races = { 'EMPIRE', 'LEGIONS', 'CLANS', 'HORDES', 'ELVES' }
	local r_vars = {
		{ name = '_CAPITAL_INCOME', value = 0 },                  -- Capital gives 0 gold per day
		{ name = '_TIER_1_CITY_INCOME', value = 50 },
		{ name = '_TIER_2_CITY_INCOME', value = 100 },
		{ name = '_TIER_3_CITY_INCOME', value = 150 },
		{ name = '_TIER_4_CITY_INCOME', value = 200 },
		{ name = '_TIER_5_CITY_INCOME', value = 300 },
	}

	for _, v in pairs(r_vars) do
		for _, race in pairs(races) do
			table.insert(result, { name = race..v['name'], value = v['value'] })
		end
	end
	
	-- Add MULTIPLE_BUILD_CAPITAL to remove building limit per day (>0 = no limit)
	table.insert(result, { name = 'MULTIPLE_BUILD_CAPITAL', value = 1 })
	
	return result
end

-- Helper function to get merchant goods with ward potions
function getMerchantGoods()
	-- Pool of ward potions
	local wardPotions = {
		'g000ig0022',  -- Water ward
		'g000ig0021',  -- Air ward
		'g000ig0023',  -- Earth ward
		'g000ig0024',  -- Fire ward
		'g001ig0125',  -- Mind ward
		'g001ig0036',  -- Death ward
		'g001ig0128',  -- Weapon ward
	}
	
	-- Shuffle the pool
	for i = #wardPotions, 2, -1 do
		local j = math.random(i)
		wardPotions[i], wardPotions[j] = wardPotions[j], wardPotions[i]
	end
	
	-- Build items list with base items + 2 ward types
	local items = {
		{ id = 'g000ig0001', min = 2, max = 2 },  -- 2x Resurrection potion
		{ id = 'g000ig0006', min = 2, max = 2 },  -- 2x Healing potion 100
		{ id = wardPotions[1], min = 2, max = 2 },  -- 2x first ward type
		{ id = wardPotions[2], min = 2, max = 2 },  -- 2x second ward type
	}
	
	return {
		itemTypes = { Item.PotionBoost, Item.PotionHeal },
		value = { min = 500, max = 750 },
		items = items
	}
end

-- Helper function to create stacks with random healing potions
function createStacksWithLoot(count, valueMin, valueMax, extraScrolls)
	local stacks = {}
	
	-- Create all stacks first with loot initialized
	for i = 1, count do
		stacks[i] = {
			count = 1, 
			value = { min = valueMin, max = valueMax },
			loot = {items = {}}
		}
	end
	
	-- FIRST PASS: Give every stack 2 basic healing potions (guaranteed)
	local basicPotions = {
		'g001ig0378',  -- healing potion 75
		'g001ig0180',  -- healing potion 25
		'g000ig0005',  -- healing potion 50
	}
	
	for i = 1, count do
		local potion1 = basicPotions[math.random(#basicPotions)]
		local potion2 = basicPotions[math.random(#basicPotions)]
		
		table.insert(stacks[i].loot.items, {id = potion1, min = 1, max = 1})
		table.insert(stacks[i].loot.items, {id = potion2, min = 1, max = 1})
	end
	
	-- SECOND PASS: Distribute additional items randomly
	local additionalItems = {
		{id = 'g000ig0001', count = math.max(1, math.floor(count * 0.2))},  -- resurrection potion
		{id = 'g000ig0011', count = math.max(1, math.floor(count * 0.15))}, -- initiative boost
		{id = 'g000ig0008', count = math.max(1, math.floor(count * 0.15))}, -- accuracy boost
		{id = 'g001ig0127', count = math.max(1, math.floor(count * 0.15))}, -- life force elixir
		{id = 'g000ig0014', count = math.max(1, math.floor(count * 0.15))}, -- attack boost
		{id = 'g000ig0002', count = math.max(1, math.floor(count * 0.15))}, -- defense boost
	}
	
	-- Add extra scrolls if provided
	if extraScrolls then
		for _, scroll in ipairs(extraScrolls) do
			table.insert(additionalItems, scroll)
		end
	end
	
	-- Distribute additional items
	for _, item in ipairs(additionalItems) do
		if item.count > 0 then
			-- Create and shuffle indices
			local indices = {}
			for i = 1, count do
				table.insert(indices, i)
			end
			
			for i = #indices, 2, -1 do
				local j = math.random(i)
				indices[i], indices[j] = indices[j], indices[i]
			end
			
			-- Distribute
			local itemsToDistribute = math.min(item.count, count)
			for i = 1, itemsToDistribute do
				local stackIndex = indices[i]
				table.insert(stacks[stackIndex].loot.items, {
					id = item.id,
					min = 1,
					max = 1
				})
			end
		end
	end
	
	return stacks
end

function getTemplateContents(races, scenarioSize)
	local zoneSize = scenarioSize / 7
	
	-- Create all ruins with unique items distributed across zones
	local allRuins = createAllRuins()
	
	-- Generate buildings and branch choices for both players
	local player1Buildings, player1BranchChoices = autobuilt(races[1])
	local player2Buildings, player2BranchChoices = autobuilt(races[2])
	
	return {
		scenarioVariables = getScenarioVariables(),
		zones = {
			-- Player 1 starting zone
			{
				id = 0,
				type = Zone.PlayerStart,
				race = races[1],
				size = zoneSize,
				border = Border.Open,
				mines = getZoneMana(races[1]),
				bags = createZoneBags(),
				mercenaries = getCapitalMercenaries(races[1], player1BranchChoices),
				trainers = {
					{
						guard = {
							value = { min = 200, max = 300 }
						}
					}
				},
				merchants = {
					{
						goods = getMerchantGoods()
					},
					{
						goods = getMerchantGoods()
					}
				},

				capital = {
				    gapMask = 15,
				    garrison = { 
				        subraceTypes = { races[1] },
				        value = { min = 0, max = 0 },
				        loot = {
				            itemTypes = { Item.Orb },
				            value = { min = 400, max = 400 },
				            itemValue = { min = 400, max = 400 },
				            items = {
				                { id = 'g000ig0001', min = 5, max = 5 }, 
				                { id = 'g000ig0006', min = 6, max = 6 }, 
				                { id = 'g001ig0378', min = 7, max = 7 }, 
				                { id = 'g000ig0005', min = 8, max = 8 }, 
				                { id = 'g001ig0180', min = 8, max = 8 }, 
				                { id = 'g000ig0002', min = 1, max = 1 }, 
				                { id = 'g000ig0014', min = 1, max = 1 }, 
				                { id = 'g000ig0011', min = 1, max = 1 },
								{ id = 'g001ig0091', min = 1, max = 1 },
				                { id = 'g000ig0008', min = 1, max = 1 }, 
				                { id = 'G000IG5030', min = 2, max = 2 },  
				                { id = 'g001ig0531', min = 1, max = 1 }  
			            }
			        }
			    },
			    buildings = player1Buildings
			},


			stacks = createStacksWithLoot(19, 100, 150, {
				{id = 'g001ig0091', count = 2},
					{id = 'g001ig0085', count = 2},
					{id = 'g001ig0084', count = 2},
					{id = 'g000ig5095', count = 1},
					{id = 'g001ig0446', count = 1},  -- sphere
					{id = 'g001ig0133', count = 1},  -- sphere
					{id = 'g001ig0450', count = 1},  -- sphere
					{id = 'g000ig9017', count = 1},  -- sphere
				{id = 'g002ig0007', count = 3},  -- magic resistance
				{id = 'g002ig0005', count = 1},  -- observation potion
				{id = 'g002ig0006', count = 2},  -- affliction cure
				{id = 'g001ig0341', count = 2},  -- affliction protection
				{id = 'g000ig5043', count = 2},  -- drain life scroll
				}),
				ruins = allRuins[1]
			},
			-- Player 2 starting zone
			{
				id = 1,
				type = Zone.PlayerStart,
				race = races[2],
				size = zoneSize,
				border = Border.Open,
				mines = getZoneMana(races[2]),
				bags = createZoneBags(),
				mercenaries = getCapitalMercenaries(races[2], player2BranchChoices),
				trainers = {
					{
						guard = {
							value = { min = 200, max = 300 }
						}
					}
				},
				merchants = {
					{
						goods = getMerchantGoods()
					},
					{
						goods = getMerchantGoods()
					}
				},

				capital = {
				    gapMask = 15,
				    garrison = { 
				        subraceTypes = { races[2] },
				        value = { min = 0, max = 0 },
				        loot = {
				            itemTypes = { Item.Orb },
				            value = { min = 400, max = 400 },
				            itemValue = { min = 400, max = 400 },
				            items = {
				                { id = 'g000ig0001', min = 5, max = 5 }, 
				                { id = 'g000ig0006', min = 6, max = 6 }, 
				                { id = 'g001ig0378', min = 7, max = 7 }, 
				                { id = 'g000ig0005', min = 8, max = 8 }, 
				                { id = 'g001ig0180', min = 8, max = 8 },
				                { id = 'g000ig0002', min = 1, max = 1 }, 
				                { id = 'g000ig0014', min = 1, max = 1 }, 
				                { id = 'g000ig0011', min = 1, max = 1 }, 
								{ id = 'g001ig0091', min = 1, max = 1 },
				                { id = 'g000ig0008', min = 1, max = 1 }, 
				                { id = 'G000IG5030', min = 2, max = 2 }, 
				                { id = 'g001ig0531', min = 1, max = 1 }  
			            }
			        }
			    },
			    buildings = player2Buildings
			},


			stacks = createStacksWithLoot(19, 100, 150, {
				{id = 'g001ig0091', count = 2},
					{id = 'g001ig0085', count = 2},
					{id = 'g001ig0084', count = 2},
					{id = 'g000ig5095', count = 1},
					{id = 'g001ig0446', count = 1},  -- sphere
					{id = 'g001ig0133', count = 1},  -- sphere
					{id = 'g001ig0450', count = 1},  -- sphere
					{id = 'g000ig9017', count = 1},  -- sphere
				{id = 'g002ig0007', count = 3},  -- magic resistance
				{id = 'g002ig0005', count = 1},  -- observation potion
				{id = 'g002ig0006', count = 2},  -- affliction cure
				{id = 'g001ig0341', count = 2},  -- affliction protection
				{id = 'g000ig5043', count = 2},  -- drain life scroll
				}),
			ruins = allRuins[2]
		},
			-- Player 1 left OUTER zone (zone 2)
			{
				id = 2,
				type = Zone.Treasure,
				size = zoneSize * 0.35,
				border = Border.SemiOpen,
				mines = getZoneManaNoGold(),
				bags = createZoneBags(),
				towns = {
					{
						tier = 1,
						garrison = {
							value = { min = 300, max = 400 },
							loot = {
								items = {
									orr5(
										{ id = 'g001ig0526', min = 1, max = 1 },
										{ id = 'g001ig0527', min = 1, max = 1 },
										{ id = 'g001ig0529', min = 1, max = 1 },
										{ id = 'g001ig0528', min = 1, max = 1 },
										{ id = 'g001ig0525', min = 1, max = 1 }
									)
								}
							}
						}
					}
				},
				stacks = createStacksWithLoot(13, 150, 200, {
					{id = 'g001ig0091', count = 1},
					{id = 'g001ig0085', count = 1},
					{id = 'g001ig0084', count = 1},
					{id = 'g001ig0446', count = 1},  -- sphere
					{id = 'g001ig0133', count = 1},  -- sphere
				{id = 'g002ig0007', count = 3},  -- magic resistance
				{id = 'g002ig0005', count = 1},  -- observation potion
				{id = 'g002ig0006', count = 2},  -- affliction cure
				{id = 'g001ig0341', count = 2},  -- affliction protection
				{id = 'g000ig5043', count = 2},  -- drain life scroll
				{id = 'g000ig5095', count = 1},  -- scroll
				}),
				ruins = allRuins[3],

				merchants = {
					{
						goods = getMerchantGoods()
					}
				}
			},
			-- Player 1 left INNER zone (zone 7)
			{
				id = 7,
				type = Zone.Treasure,
				size = zoneSize * 0.25,
				border = Border.SemiOpen,
				mines = getZoneManaNoGold(),
				bags = createZoneBags(),
				stacks = createStacksWithLoot(12, 150, 200, {
					{id = 'g001ig0091', count = 1},
					{id = 'g001ig0085', count = 1},
					{id = 'g001ig0084', count = 1},
					{id = 'g001ig0450', count = 1},  -- sphere
					{id = 'g000ig9017', count = 1},  -- sphere
				{id = 'g002ig0007', count = 3},  -- magic resistance
				{id = 'g002ig0005', count = 1},  -- observation potion
				{id = 'g002ig0006', count = 2},  -- affliction cure
				{id = 'g001ig0341', count = 2},  -- affliction protection
				{id = 'g000ig5043', count = 2},  -- drain life scroll
				{id = 'g000ig5095', count = 1},  -- scroll
				}),
				ruins = allRuins[4],

				merchants = {
					{
						goods = getMerchantGoods()
					}
				}
			},
			-- Player 1 right OUTER zone (zone 3)
			{
				id = 3,
				type = Zone.Treasure,
				size = zoneSize * 0.35,
				border = Border.SemiOpen,
				mines = getZoneManaNoGold(),
				bags = createZoneBags(),
				towns = {
					{
						tier = 2,
						garrison = {
							value = { min = 300, max = 400 },
							loot = {
								items = {
									orr5(
										{ id = 'g001ig0526', min = 1, max = 1 },
										{ id = 'g001ig0527', min = 1, max = 1 },
										{ id = 'g001ig0529', min = 1, max = 1 },
										{ id = 'g001ig0528', min = 1, max = 1 },
										{ id = 'g001ig0525', min = 1, max = 1 }
									)
								}
							}
						}
					}
				},
				stacks = createStacksWithLoot(13, 150, 200, {
					{id = 'g001ig0091', count = 1},
					{id = 'g001ig0085', count = 1},
					{id = 'g001ig0084', count = 1},
					{id = 'g001ig0446', count = 1},  -- sphere
					{id = 'g001ig0133', count = 1},  -- sphere
				{id = 'g002ig0007', count = 3},  -- magic resistance
				{id = 'g002ig0005', count = 1},  -- observation potion
				{id = 'g002ig0006', count = 2},  -- affliction cure
				{id = 'g001ig0341', count = 2},  -- affliction protection
				{id = 'g000ig5043', count = 2},  -- drain life scroll
				{id = 'g000ig5095', count = 1},  -- scroll
				}),
				ruins = allRuins[5],

				merchants = {
					{
						goods = getMerchantGoods()
					}
				}
			},
			-- Player 1 right INNER zone (zone 8)
			{
				id = 8,
				type = Zone.Treasure,
				size = zoneSize * 0.25,
				border = Border.SemiOpen,
				mines = getZoneManaNoGold(),
				bags = createZoneBags(),
				stacks = createStacksWithLoot(12, 150, 200, {
					{id = 'g001ig0091', count = 1},
					{id = 'g001ig0085', count = 1},
					{id = 'g001ig0084', count = 1},
					{id = 'g001ig0450', count = 1},  -- sphere
					{id = 'g000ig9017', count = 1},  -- sphere
				{id = 'g002ig0007', count = 3},  -- magic resistance
				{id = 'g002ig0005', count = 1},  -- observation potion
				{id = 'g002ig0006', count = 2},  -- affliction cure
				{id = 'g001ig0341', count = 2},  -- affliction protection
				{id = 'g000ig5043', count = 2},  -- drain life scroll
				{id = 'g000ig5095', count = 1},  -- scroll
				}),
				ruins = allRuins[6],

				merchants = {
					{
						goods = getMerchantGoods()
					}
				}
			},
			-- Player 2 left OUTER zone (zone 4)
			{
				id = 4,
				type = Zone.Treasure,
				size = zoneSize * 0.35,
				border = Border.SemiOpen,
				mines = getZoneManaNoGold(),
				bags = createZoneBags(),
				towns = {
					{
						tier = 2,
						garrison = {
							value = { min = 300, max = 400 },
							loot = {
								items = {
									orr5(
										{ id = 'g001ig0526', min = 1, max = 1 },
										{ id = 'g001ig0527', min = 1, max = 1 },
										{ id = 'g001ig0529', min = 1, max = 1 },
										{ id = 'g001ig0528', min = 1, max = 1 },
										{ id = 'g001ig0525', min = 1, max = 1 }
									)
								}
							}
						}
					}
				},
				stacks = createStacksWithLoot(13, 150, 200, {
					{id = 'g001ig0091', count = 1},
					{id = 'g001ig0085', count = 1},
					{id = 'g001ig0084', count = 1},
					{id = 'g001ig0446', count = 1},  -- sphere
					{id = 'g001ig0133', count = 1},  -- sphere
				{id = 'g002ig0007', count = 3},  -- magic resistance
				{id = 'g002ig0005', count = 1},  -- observation potion
				{id = 'g002ig0006', count = 2},  -- affliction cure
				{id = 'g001ig0341', count = 2},  -- affliction protection
				{id = 'g000ig5043', count = 2},  -- drain life scroll
				{id = 'g000ig5095', count = 1},  -- scroll
				}),
				ruins = allRuins[7],

				merchants = {
					{
						goods = getMerchantGoods()
					}
				}
			},
			-- Player 2 left INNER zone (zone 9)
			{
				id = 9,
				type = Zone.Treasure,
				size = zoneSize * 0.25,
				border = Border.SemiOpen,
				mines = getZoneManaNoGold(),
				bags = createZoneBags(),
				stacks = createStacksWithLoot(12, 150, 200, {
					{id = 'g001ig0091', count = 1},
					{id = 'g001ig0085', count = 1},
					{id = 'g001ig0084', count = 1},
					{id = 'g001ig0450', count = 1},  -- sphere
					{id = 'g000ig9017', count = 1},  -- sphere
				{id = 'g002ig0007', count = 3},  -- magic resistance
				{id = 'g002ig0005', count = 1},  -- observation potion
				{id = 'g002ig0006', count = 2},  -- affliction cure
				{id = 'g001ig0341', count = 2},  -- affliction protection
				{id = 'g000ig5043', count = 2},  -- drain life scroll
				{id = 'g000ig5095', count = 1},  -- scroll
				}),
				ruins = allRuins[8],

				merchants = {
					{
						goods = getMerchantGoods()
					}
				}
			},
			-- Player 2 right OUTER zone (zone 5)
			{
				id = 5,
				type = Zone.Treasure,
				size = zoneSize * 0.35,
				border = Border.SemiOpen,
				mines = getZoneManaNoGold(),
				bags = createZoneBags(),
				towns = {
					{
						tier = 1,
						garrison = {
							value = { min = 300, max = 400 },
							loot = {
								items = {
									orr5(
										{ id = 'g001ig0526', min = 1, max = 1 },
										{ id = 'g001ig0527', min = 1, max = 1 },
										{ id = 'g001ig0529', min = 1, max = 1 },
										{ id = 'g001ig0528', min = 1, max = 1 },
										{ id = 'g001ig0525', min = 1, max = 1 }
									)
								}
							}
						}
					}
				},
				stacks = createStacksWithLoot(13, 150, 200, {
					{id = 'g001ig0091', count = 1},
					{id = 'g001ig0085', count = 1},
					{id = 'g001ig0084', count = 1},
					{id = 'g001ig0446', count = 1},  -- sphere
					{id = 'g001ig0133', count = 1},  -- sphere
				{id = 'g002ig0007', count = 3},  -- magic resistance
				{id = 'g002ig0005', count = 1},  -- observation potion
				{id = 'g002ig0006', count = 2},  -- affliction cure
				{id = 'g001ig0341', count = 2},  -- affliction protection
				{id = 'g000ig5043', count = 2},  -- drain life scroll
				{id = 'g000ig5095', count = 1},  -- scroll
				}),
				ruins = allRuins[9],

				merchants = {
					{
						goods = getMerchantGoods()
					}
				}
			},
			-- Player 2 right INNER zone (zone 10)
			{
				id = 10,
				type = Zone.Treasure,
				size = zoneSize * 0.25,
				border = Border.SemiOpen,
				mines = getZoneManaNoGold(),
				bags = createZoneBags(),
				stacks = createStacksWithLoot(12, 150, 200, {
					{id = 'g001ig0091', count = 1},
					{id = 'g001ig0085', count = 1},
					{id = 'g001ig0084', count = 1},
					{id = 'g001ig0450', count = 1},  -- sphere
					{id = 'g000ig9017', count = 1},  -- sphere
				{id = 'g002ig0007', count = 3},  -- magic resistance
				{id = 'g002ig0005', count = 1},  -- observation potion
				{id = 'g002ig0006', count = 2},  -- affliction cure
				{id = 'g001ig0341', count = 2},  -- affliction protection
				{id = 'g000ig5043', count = 2},  -- drain life scroll
				{id = 'g000ig5095', count = 1},  -- scroll
				}),
				ruins = allRuins[10],

				merchants = {
					{
						goods = getMerchantGoods()
					}
				}
			},
			-- Center zone surrounded by water
			{
				id = 6,
				type = Zone.Treasure,
				size = zoneSize * 0.4,
				border = Border.Water,
				mines = getZoneMana(nil),
				bags = createZoneBags(),
				resourceMarkets = rMarketsZone4(),
				merchants = {
					{
						goods = createCentralMerchant(),
						guard = {
							value = { min = 600, max = 700 }
						}
					}
				},
				mages = {
					createMageTower()
				},
				towns = {
					{
						tier = 5,
						garrison = {
							value = { min = 1100, max = 1300 }
						},
						stack = { value = { min = 900, max = 1100 } }
					}
					
				}
			},
		},
		connections = {
			-- Zone 0 to outer zones
			{from = 0, to = 2},
			{from = 0, to = 3},
			-- Zone 1 to outer zones
			{from = 1, to = 4},
			{from = 1, to = 5},
			-- Outer zones to inner zones (same side)
			{from = 2, to = 7},
			{from = 3, to = 8},
			{from = 4, to = 9},
			{from = 5, to = 10},
			-- Cross-connections between opposite outer zones (forces them to opposite sides)
			{from = 2, to = 4},
			{from = 3, to = 5},
			-- Inner zones to center
			{from = 7, to = 6},
			{from = 8, to = 6},
			{from = 9, to = 6},
			{from = 10, to = 6},
			-- Cross-connections between opposite inner zones (forces square around center)
			{from = 7, to = 9},
			{from = 8, to = 10},
			{from = 0, to = 6, size = 0},
            {from = 1, to = 6, size = 0},
		}
	}
end

template = {
	name = 'rookie_3.0g',
	description = 'Yellow zone in the center with 4 small zones attached to it. \nGet 20% of land or capture the central town and and land around it or kill enemy golovorez. \nDeveloped by Nickush',
	minSize = 72,
	maxSize = 72,
	maxPlayers = 2,
	startingGold = 1350,
	roads = 30,
	forest = 55,
	getContents = getTemplateContents,
}