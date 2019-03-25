GUI = {}
GUI.mouse_listeners = {}
GUI.update_objects = {}
GUI.mouse_index = 1
GUI.update_index = 1
GUI.bound = {}
GUI.bound.x = nil
GUI.bound.y = {}
GUI.bound.y.lower = 80
GUI.bound.y.upper = 502
GUI.nexttime = os.clock()
GUI.delay = 1

require('coroutine')

require('GUI/IconPalette')
require('GUI/IconButton')
require('GUI/ToggleButton')
require('GUI/PassiveText')
require('GUI/TextCycle')

function GUI.on_mouse_event(type, x, y, delta, blocked) -- sends incoming mouse events to any elements currently listening
	block = false
	--for i, listener in ipairs(GUI.mouse_listeners) do
	for i, listener in pairs({table.unpack(GUI.mouse_listeners)}) do
		block = listener:on_mouse(type, x, y, delta, blocked) or block
	end
	blocked = block
	return block
end

function GUI.register_mouse_listener(obj) -- will technically overflow eventually.  I'm not really worried about that.
	GUI.mouse_listeners[GUI.mouse_index] = obj
	GUI.mouse_index = GUI.mouse_index + 1
	return GUI.mouse_index - 1
end

function GUI.unregister_mouse_listener(index)
	GUI.mouse_listeners[index] = nil
end

function GUI.on_prerender()
	local curtime = os.clock()
	if GUI.nexttime + GUI.delay <= curtime then
		GUI.nexttime = curtime
		GUI.delay = 1
		for i, object in pairs({table.unpack(GUI.update_objects)}) do
			object:update()
		end
	end
end

function GUI.register_update_object(obj)
	GUI.update_objects[GUI.update_index] = obj
	GUI.update_index = GUI.update_index + 1
	return GUI.update_index - 1
end

function GUI.unregister_update_object(index)
	GUI.update_objects[index] = nil
end

function GUI.complete_filepath(short)
	-- CHECK
	-- windower.addon_path..short
	-- windower.addon_path..'graphics/'..short
	-- windower.addon_path..'data/graphics/..short
	-- windower.windower_path..'addons/libs/GUI/..short
	for i, path in ipairs{
		windower.addon_path..short,
		windower.addon_path..'graphics/'..short,
		windower.addon_path..'data/graphics/'..short,
		windower.windower_path..'addons/libs/GUI/'..short,
		windower.windower_path..'addons/libs/GUI/graphics/'..short
		} do
		local f=io.open(path,"r")
		if f~=nil then
			io.close(f)
			return path
		end
	end
	print('%s not found':format(short))
end
if windower.raw_register_event then
	windower.raw_register_event('mouse', GUI.on_mouse_event)
	windower.raw_register_event('prerender', GUI.on_prerender)
else
	windower.register_event('mouse', GUI.on_mouse_event)
	windower.register_event('prerender', GUI.on_prerender)
end