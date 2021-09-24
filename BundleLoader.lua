class "BundleLoader"

local m_Logger = Logger("BundleLoader", false)

local m_BundleConfig = { }

function BundleLoader:__init()
	m_Logger:Write("BundleLoader init.")
	Hooks:Install('Terrain:Load', 999, self, self.OnTerrainLoad)
	Hooks:Install('VisualTerrain:Load', 999, self, self.OnTerrainLoad)
end

function BundleLoader:OnTerrainLoad(p_Hook, p_TerrainName)
	if not m_BundleConfig then
		return
	end

	if m_BundleConfig.terrainAssetName == nil then
		m_Logger:Write("Warning: No terrain asset name can found for this map. This means every terrain will be loaded.")
		return
	end

	if not string.find(p_TerrainName:lower(), m_BundleConfig.terrainAssetName:lower()) then
		m_Logger:Write("Preventing load of terrain: " .. p_TerrainName)
		p_Hook:Return(nil)
	end
end

function BundleLoader:OnLoadBundles(p_Hook, p_Bundles, p_Compartment)
	if not m_BundleConfig then
		return
	end

	if #p_Bundles == 1 and p_Bundles[1] == SharedUtils:GetLevelName() then

		local s_BundlesToLoad = m_BundleConfig.bundles or { }

		-- we hook the first bundle to load other bundles, but we also have to pass the first bundle to the hook
		table.insert(s_BundlesToLoad, 1, p_Bundles[1])

		m_Logger:Write("Bundles:")
		for _, v in pairs(s_BundlesToLoad) do
			m_Logger:Write(v)
		end

		p_Hook:Pass(s_BundlesToLoad, p_Compartment)
	end
end

function BundleLoader:OnRegisterEntityResources(p_LevelData)
	local s_RegistriesToLoad = { 
		-- 'SP_Tank_DesertFort_Registry'
		DC(Guid('44234CB8-700B-461D-AF51-4FD9555128A7'), Guid('4C200C23-43D4-27E3-AC17-EBA1030EE457')),
		-- 'Coop_006_Registry'
		DC(Guid('23535E3D-E72F-11DF-99CA-879440EEBD7A'), Guid('51C54150-0ABF-03BD-EADE-1876AAD3EC8D')),
		-- 'Coop_009_Registry'
		DC(Guid('F94C5091-E69C-11DF-9B0E-AF9CA6E0236B'), Guid('F05798B2-31EC-210D-CC1D-0F7535BECA30')),
		-- 'SP_Bank_Ride_SUB_Registry'
		DC(Guid('8148A1BB-8F21-4E40-8A8F-2126000ABCD4'), Guid('9F9CABAF-21C2-EF4A-B35D-4358AEBA7565'))
	}
	
	for l_Index, l_RegistryDataContainer in pairs(s_RegistriesToLoad) do
		m_Logger:Write(l_Index)
		local s_LoadedRegistry = l_RegistryDataContainer:GetInstance()

		if s_LoadedRegistry == nil then
			m_Logger:Error("s_LoadedRegistry nil")
		end

		ResourceManager:AddRegistry(s_LoadedRegistry, ResourceCompartment.ResourceCompartment_Game)
	end
end

 -- Returns "mp_001" from "levels/mp_001/mp_001"
 local function GetLevelName()
	local s_LevelName = SharedUtils:GetLevelName()

	if s_LevelName == nil then
		return nil
	end

	return s_LevelName:gsub(".*/", "")
end


function BundleLoader:GetBundleConfig(p_LevelName, p_GameModeName)
	local s_Path = '__shared/BundleLoader/LevelBundleConfigs/' .. p_LevelName .. '_' .. p_GameModeName .. '.BundleConfig'

	local s_Ok, s_BundleConfig = pcall(require, s_Path)
	s_BundleConfig = s_Ok and s_BundleConfig or nil

	m_Logger:Write("bundleconfig found: " .. s_Path:split('/')[4])

	return s_BundleConfig
end

function BundleLoader:OnLoadResources(p_LevelName, p_GameModeName, p_DedicatedServer)
	m_BundleConfig = self:GetBundleConfig(GetLevelName(), SharedUtils:GetCurrentGameMode())

	if m_BundleConfig then
		local s_SuperBundlesToLoad = m_BundleConfig.superBundles or { }

		for l_Index, l_SuperBundle in pairs(s_SuperBundlesToLoad) do
			ResourceManager:MountSuperBundle(l_SuperBundle)
			m_Logger:Write("Superbundle - " .. l_Index .. ": " .. l_SuperBundle)
		end
	end
end

-- Singleton.
if g_BundleLoader == nil then
	g_BundleLoader = BundleLoader()
end

return g_BundleLoader
