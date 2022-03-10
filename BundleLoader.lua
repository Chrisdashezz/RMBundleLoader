---@class BundleLoader
BundleLoader = class "BundleLoader"

---@type Logger
local m_Logger = Logger("BundleLoader", false)

---@class BundleConfigTable
---@field terrainAssetName string|nil
---@field superBundles string[]|nil
---@field bundles string[]|nil
---@field blueprintGuidsToBlock table<string, boolean>|nil
---@field registries DC[]|nil

---@type BundleConfigTable
local m_BundleConfig = {}

---@type BundleConfigTable
local m_CommonBundleConfig = require "__shared/BundleLoader/LevelBundleConfigs/Common.BundleConfig"

function BundleLoader:__init()
	m_Logger:Write("BundleLoader init.")
	Hooks:Install('Terrain:Load', 999, self, self.OnTerrainLoad)
	Hooks:Install('VisualTerrain:Load', 999, self, self.OnTerrainLoad)
end

---VEXT Shared EntityFactory:CreateFromBlueprint Hook
---@param p_HookCtx HookContext
---@param p_Blueprint DataContainer
---@param p_Transform LinearTransform
---@param p_Variation integer
---@param p_ParentRepresentative DataContainer | nil
function BundleLoader:OnEntityCreateFromBlueprint(p_HookCtx, p_Blueprint, p_Transform, p_Variation, p_ParentRepresentative)
	if m_BundleConfig.blueprintGuidsToBlock and m_BundleConfig.blueprintGuidsToBlock[tostring(p_Blueprint.instanceGuid)] then
		m_Logger:Warning("Blocking blueprint: " .. tostring(p_Blueprint.instanceGuid))
		p_HookCtx:Return()
	end
end

---VEXT Shared VisualTerrain:Load Hook
---VEXT Shared Terrain:Load Hook
---@param p_HookCtx HookContext
---@param p_TerrainName string
function BundleLoader:OnTerrainLoad(p_HookCtx, p_TerrainName)
	if not m_BundleConfig then
		return
	end

	if m_BundleConfig.terrainAssetName == nil then
		m_Logger:Write("Warning: No terrain asset name can found for this map. This means every terrain will be loaded.")
		return
	end

	if not string.find(p_TerrainName:lower(), m_BundleConfig.terrainAssetName:lower()) then
		m_Logger:Write("Preventing load of terrain: " .. p_TerrainName)
		p_HookCtx:Return(nil)
	end
end

---VEXT Shared ResourceManager:LoadBundles Hook
---@param p_HookCtx HookContext
---@param p_Bundles string[]
---@param p_Compartment ResourceCompartment|integer
function BundleLoader:OnLoadBundles(p_HookCtx, p_Bundles, p_Compartment)
	if p_Compartment ~= ResourceCompartment.ResourceCompartment_Game then
		return
	end

	if not m_BundleConfig then
		return
	end

	local s_LevelName = SharedUtils:GetLevelName()

	if #p_Bundles == 1 and p_Bundles[1] == s_LevelName then
		---@type string[]
		local s_BundlesToLoad = {}

		local s_MainLevelFound = false

		m_Logger:Write("Bundles:")

		---@param p_BundlesToLoad string[]
		local function _AddBundles(p_BundlesToLoad)
			for _, l_Bundle in ipairs(p_BundlesToLoad) do
				if s_LevelName == l_Bundle then
					s_MainLevelFound = true
				end

				m_Logger:Write(l_Bundle)
				table.insert(s_BundlesToLoad, l_Bundle)
			end
		end

		if m_CommonBundleConfig and m_CommonBundleConfig.bundles then
			_AddBundles(m_CommonBundleConfig.bundles)
		end

		if m_BundleConfig.bundles then
			_AddBundles(m_BundleConfig.bundles)
		end

		if not s_MainLevelFound then
			-- we hook the first bundle to load other bundles, but we also have to pass the first bundle to the hook
			m_Logger:Write(p_Bundles[1])
			table.insert(s_BundlesToLoad, p_Bundles[1])
		end

		p_HookCtx:Pass(s_BundlesToLoad, p_Compartment)
	end
end

---@param p_Registries DC[]
local function _AddRegistries(p_Registries)
	for _, l_RegistryDataContainer in ipairs(p_Registries) do
		local s_LoadedRegistry = l_RegistryDataContainer:GetInstance()

		if s_LoadedRegistry == nil then
			m_Logger:Write("Couldn\'t find RegistryContainer Guid('" .. tostring(l_RegistryDataContainer.m_InstanceGuid) .. "')")
		else
			m_Logger:Write("Adding RegistryContainer from " .. s_LoadedRegistry.partition.name)
			ResourceManager:AddRegistry(s_LoadedRegistry, ResourceCompartment.ResourceCompartment_Game)
		end
	end
end

---VEXT Shared Level:RegisterEntityResources Event
---@param p_LevelData DataContainer
function BundleLoader:OnRegisterEntityResources(p_LevelData)
	if not m_BundleConfig then
		return
	end

	if m_CommonBundleConfig and m_CommonBundleConfig.registries then
		_AddRegistries(m_CommonBundleConfig.registries)
	end

	if m_BundleConfig.registries then
		_AddRegistries(m_BundleConfig.registries)
	end
end

 -- Returns "mp_001" from "levels/mp_001/mp_001"
 ---@return string
 local function _GetLevelName()
	local s_LevelName = SharedUtils:GetLevelName()

	if s_LevelName == nil then
		return nil
	end

	return s_LevelName:gsub(".*/", "")
end

---@param p_LevelName string
---@param p_GameModeName string
---@return BundleConfigTable
function BundleLoader:GetBundleConfig(p_LevelName, p_GameModeName)
	---@type string
	local s_Path = '__shared/BundleLoader/LevelBundleConfigs/' .. p_LevelName .. '_' .. p_GameModeName .. '.BundleConfig'

	local s_Ok, s_BundleConfig = pcall(require, s_Path)
	s_BundleConfig = s_Ok and s_BundleConfig or nil

	m_Logger:Write("BundleConfig found: " .. s_Path:gsub(".*/", ""))

	return s_BundleConfig
end

---@param p_SuperBundles string[]
local function _MountSuperBundles(p_SuperBundles)
	for l_Index, l_SuperBundle in ipairs(p_SuperBundles) do
		ResourceManager:MountSuperBundle(l_SuperBundle)
		m_Logger:Write("Superbundle - " .. l_Index .. ": " .. l_SuperBundle)
	end
end

---VEXT Shared Level:LoadResources Event
---@param p_LevelName string
---@param p_GameModeName string
---@param p_IsDedicatedServer boolean
function BundleLoader:OnLoadResources(p_LevelName, p_GameModeName, p_IsDedicatedServer)
	m_BundleConfig = self:GetBundleConfig(_GetLevelName(), SharedUtils:GetCurrentGameMode())

	if not m_BundleConfig then
		return
	end

	if m_CommonBundleConfig and m_CommonBundleConfig.superBundles then
		_MountSuperBundles(m_CommonBundleConfig.superBundles)
	end

	if m_BundleConfig.superBundles then
		_MountSuperBundles(m_BundleConfig.superBundles)
	end
end

return BundleLoader()
