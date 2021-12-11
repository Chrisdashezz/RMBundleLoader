class "BundleLoader"

local m_Logger = Logger("BundleLoader", true)
local m_MapManager = require "__shared/Maps/MapManager"

function BundleLoader:__init()
	m_Logger:Write("BundleLoader init.")
	Hooks:Install('Terrain:Load', 999, self, self.OnTerrainLoad)
	Hooks:Install('VisualTerrain:Load', 999, self, self.OnTerrainLoad)
end

function BundleLoader:OnTerrainLoad(p_Hook, p_TerrainName)
	local s_Map = m_MapManager:GetCurrentMap()
	if s_Map == nil then
		m_Logger:Error("No map loaded yet")
	-- elseif s_Map.terrainAssetName == nil then
	-- 	m_Logger:Warning("No terrain asset name can found for this map. This means every terrain will be loaded.")
	-- 	return
	end

	local s_TerrainDict = {
		["XP1_001"] = "Levels/XP1_001/XPACK1_001_Terrain",
		["XP1_002"] = "Levels/XP1_002/Terrain_2/GulfTerrain_03",
		["XP3_Shield"] = "levels/xp3_legrandval/terrain/legrandval",
		["XP3_Valley"] = "Levels/MP_Canyon/MP_Canyon_Terrain/MP_Canyon_Terrain/MP_Canyon_Terrain",
		["XP4_Parl"] = "Levels/XP4_Parliament/Terrain_Parliament/Terrain_Parliament",
		["XP5_001"] = "levels/XP5_001/terrain/terrainexample",
	}

	if not string.find(p_TerrainName:lower(), s_TerrainDict[s_Map.name]:lower()) then
		m_Logger:Write("Preventing load of terrain: " .. p_TerrainName)
		p_Hook:Return(nil)
	end
end

function BundleLoader:OnLoadBundles(p_Hook, p_Bundles, p_Compartment)

	if #p_Bundles == 1 and p_Bundles[1] == SharedUtils:GetLevelName() then
		m_Logger:Write('Injecting SP bundles.')

		p_Bundles = {
			'Levels/SP_Tank/SP_Tank',
			'Levels/SP_Tank/DesertFort',
			'Levels/Coop_006/Coop_006',
			'Levels/Coop_009/Coop_009',
			'Levels/SP_Bank/SP_Bank',
			'Levels/SP_Bank/Ride_SUB',
			p_Bundles[1],
		}

		p_Hook:Pass(p_Bundles, p_Compartment)
	end
end

function BundleLoader:OnRegisterEntityResources(p_LevelData)
	local s_SpTankDesertFortRegistry = ResourceManager:FindInstanceByGuid(Guid('44234CB8-700B-461D-AF51-4FD9555128A7'), Guid('4C200C23-43D4-27E3-AC17-EBA1030EE457'))
	local s_Coop6Registry = ResourceManager:FindInstanceByGuid(Guid('23535E3D-E72F-11DF-99CA-879440EEBD7A'), Guid('51C54150-0ABF-03BD-EADE-1876AAD3EC8D'))
	local s_Coop9Registry = ResourceManager:FindInstanceByGuid(Guid('F94C5091-E69C-11DF-9B0E-AF9CA6E0236B'), Guid('F05798B2-31EC-210D-CC1D-0F7535BECA30'))
	local s_SpBankRideSubRegistry = ResourceManager:FindInstanceByGuid(Guid('8148A1BB-8F21-4E40-8A8F-2126000ABCD4'), Guid('9F9CABAF-21C2-EF4A-B35D-4358AEBA7565'))

	if s_SpTankDesertFortRegistry == nil or s_Coop6Registry == nil or s_Coop9Registry == nil or s_SpBankRideSubRegistry == nil then -- or XP2_FactoryTdmRegistry
		m_Logger:Write(">>>>>>> Couldn't find registry")
		return
	end

	s_SpTankDesertFortRegistry = RegistryContainer(s_SpTankDesertFortRegistry)
	ResourceManager:AddRegistry(s_SpTankDesertFortRegistry, ResourceCompartment.ResourceCompartment_Game)
	m_Logger:Write(">>>>>>> Added spTankDesertFortRegistry")

	s_Coop6Registry = RegistryContainer(s_Coop6Registry)
	ResourceManager:AddRegistry(s_Coop6Registry, ResourceCompartment.ResourceCompartment_Game)
	m_Logger:Write(">>>>>>> Added coop6Registry")

	s_Coop9Registry = RegistryContainer(s_Coop9Registry)
	ResourceManager:AddRegistry(s_Coop9Registry, ResourceCompartment.ResourceCompartment_Game)
	m_Logger:Write(">>>>>>> Added coop9Registry")

	s_SpBankRideSubRegistry = RegistryContainer(s_SpBankRideSubRegistry)
	ResourceManager:AddRegistry(s_SpBankRideSubRegistry, ResourceCompartment.ResourceCompartment_Game)
	m_Logger:Write(">>>>>>> Added spBankRideSubRegistry")
end

function BundleLoader:OnLoadResources(p_MapName, p_GameModeName, p_DedicatedServer)
	ResourceManager:MountSuperBundle('SpChunks')
	ResourceManager:MountSuperBundle('Xp2Chunks')
	ResourceManager:MountSuperBundle('Levels/SP_Tank/SP_Tank')
	ResourceManager:MountSuperBundle('Levels/Coop_006/Coop_006')
	ResourceManager:MountSuperBundle('Levels/Coop_009/Coop_009')
	ResourceManager:MountSuperBundle('Levels/SP_Bank/SP_Bank')
	m_Logger:Write(">>>>>>> Mounted SP SuperBundle & Chunks")
end

-- Singleton.
if g_BundleLoader == nil then
	g_BundleLoader = BundleLoader()
end

return g_BundleLoader