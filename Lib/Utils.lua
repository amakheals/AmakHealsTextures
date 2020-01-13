local AddonName, AmakHealsTextures = ...
if AmakHealsTextures.BuildFail(80200) then return end

-- attempt to laod addon as evn var
_G[AddonName] = AmakHealsTextures

--WoW API / Variables
local IsAddOnLoaded = IsAddOnLoaded

-- check for optional dependency WeakAuras
if not select(1, IsAddOnLoaded("WeakAuras")) then
	loaded, reason = LoadAddOn("WeakAuras")
	if not loaded then
		AmakHealsTextures.print("Can't Load Optional Dependencies: " .. "WeakAuras")
	end
end
local WeakAuras = WeakAuras
if select(1, IsAddOnLoaded("WeakAuras")) then
	if not WeakAuras then
		AmakHealsTextures.print("Can't Find Optional Dependencys")
	else
		AmakHealsTextures.print("Found Optional Dependency: " .. "WeakAuras")
		WeakAuras.RegisterAddon(AddonName, AmakHealsTextures.PlainAddonTitle, "Data sourced from " .. AmakHealsTextures.PlainAddonTitle, "Interface\\Addons\\" .. AmakHealsTextures.name .. "\\MiscTexturePack\\Logo.blp")
	end
-- local spellsTextureMap = {}
else
	AmakHealsTextures.print("Optional Dependency Not Loaded: " .. "WeakAuras")
end

-- DEBUG Code

-- set aura throttle types
AmakHealsTextures.throttleKeys = (AmakHealsTextures.throttleKeys or {})

AmakHealsTextures.throttleKeys.Add("default")

--set aura throttle states --
AmakHealsTextures.throttleStates = (AmakHealsTextures.throttleStates or {})

-- initialize a key for throttling
function AmakHealsTextures.initThrottleTick(key) do
	if not AmakHealsTextures.throttleKeys[key] then
		AmakHealsTextures.throttleKeys[key] = 0
		AmakHealsTextures.throttleStates[key] = false
	end
end

function AmakHealsTextures.resetThrottleTick(resetkey, throttleRate) do
	-- need to call AmakHealsTextures.initThrottleTick(key) first
	if not AmakHealsTextures.throttleKeys[resetkey] then return end
	local theTime = GetTime()
	if (not AmakHealsTextures.lastTick) or (AmakHealsTextures.lastTick < (theTime - throttleRate)) then
		AmakHealsTextures.lastTick = theTime
	end
	if (not AmakHealsTextures.throttleKeys[resetKey]) or (AmakHealsTextures.throttleKeys[resetKey] < (AmakHealsTextures.lastTick - 1)) then
		AmakHealsTextures.throttleKeys[resetKey] = theTime
		-- deactivate throttle
		AmakHealsTextures.throttleStates[resetKey] = false
	end
	return
end

function AmakHealsTextures.shouldThrottle(throttlekey, throttleRate) do
	-- need to call AmakHealsTextures.initThrottleTick(throttlekey) first
	if not AmakHealsTextures.throttleKeys[throttlekey] then return end
	-- if throttling active
	if AmakHealsTextures.throttleKeys[throttlekey] then
		if AmakHealsTextures.throttleStates[throttlekey] then
			-- check and reset throttle if needed
			AmakHealsTextures.resetThrottleTick(throttlekey, throttleRate)
			-- throttle if needed
			return AmakHealsTextures.throttleStates[throttlekey]
		else
			-- snooze next time
			AmakHealsTextures.throttleStates[throttlekey] = true
			-- and don't throttle yet
			return false
		end
	end
	-- no throttling
	return false
end
