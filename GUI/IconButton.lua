_meta = _meta or {}
_meta.IconButton = {}
_meta.IconButton.__class = 'icon_button'
_meta.IconButton.__methods = {}

function IconButton(args) -- constructs the object, but does not initialize it
	local ib = {}
	ib._track = {}
	ib._track._class = 'icon button'

	ib._track._x = args.x
	ib._track._y = args.y
	ib._track._var = args.var
	ib._track._state = args.var.value
	ib._track._icons = args.icons
	ib._track._mouse_event = nil
	ib._track._update_event = nil
	ib._track._pressed = false
	ib._track._suppress = false
	ib._track._update_command = args.command -- string
	return setmetatable(ib, _meta.IconButton)	
end

_meta.IconButton.__methods['draw'] = function(ib) -- Finishes initialization and draws the graphics
	local self = tostring(ib)
	-- draw the button
	windower.prim.create(self)
	windower.prim.set_visibility(self, true)
	windower.prim.set_position(self, ib._track._x, ib._track._y)
	windower.prim.set_texture(self, GUI.complete_filepath('icon_button.png'))
	windower.prim.set_fit_to_texture(self, true)
	-- blue square to darken the button when pressed
	local press = '%s press':format(self)
	windower.prim.create(press)
	windower.prim.set_visibility(press, false)
	windower.prim.set_position(press, ib._track._x + 3, ib._track._y + 3)
	windower.prim.set_color(press, 100, 0, 0, 127)
	windower.prim.set_size(press, 36, 36)
	-- draw the icons
	for ind, icon in ipairs(ib._track._icons) do
		local name = '%s %s':format(self, icon.value)
		windower.prim.create(name)
		windower.prim.set_visibility(name, false)
		windower.prim.set_position(name, ib._track._x + 5, ib._track._y + 5)
		windower.prim.set_texture(name, GUI.complete_filepath(icon.img))
		windower.prim.set_fit_to_texture(name, true)
	end
	-- display the icon that is currently active
	windower.prim.set_visibility('%s %s':format(self, ib._track._var.value), true)
	-- Initialize and draw the IconPalette
	ib._track._iconPalette = IconPalette{
		x		= ib._track._x - 54,
		y		= palette_y_align(ib._track._y, #ib._track._icons),
		var		= ib._track._var,
		icons	= ib._track._icons,
		button	= ib
		}
	ib._track._iconPalette:draw()
	ib._track._mouse_event = GUI.register_mouse_listener(ib)
	ib._track._update_event = GUI.register_update_object(ib)
	
end

_meta.IconButton.__methods['on_mouse'] = function(ib, type, x, y, delta, blocked)
	if type == 1 then
		if ib._track._suppress then
			ib._track._suppress = false
			return true
		end
		if x > ib._track._x and x < ib._track._x + 42 and y > ib._track._y and y < ib._track._y + 42 then
			if ib._track._pressed then
				--ib:unpress()
				return true
			else
				ib:press()
				return true
			end
		end
	elseif type == 2 then
		if x > ib._track._x and x < ib._track._x + 42 and y > ib._track._y and y < ib._track._y + 42 then
			return true
		end
	end
end

--[[_meta.IconButton.__methods['update'] = function(ib)
	if ib._track._var.value ~= ib._track._state then
		self = tostring(ib)
	
	if _G[tb._track._var] ~= tb._track._state then
		
		windower.prim.set_visibility('%s Up':format(self), not (_G[tb._track._var] ~= tb._track._invert))
		windower.prim.set_visibility('%s Down':format(self), _G[tb._track._var] ~= tb._track._invert)
		windower.prim.set_visibility('%s press':format(self), _G[tb._track._var] ~= tb._track._invert)
		tb._track._state = _G[tb._track._var]
	end
end]]

_meta.IconButton.__methods['press'] = function(ib)
	-- visually depress the button
	ib._track._pressed = true
	windower.prim.set_visibility('%s press':format(tostring(ib)), true)
	ib._track._iconPalette:show()
end

_meta.IconButton.__methods['unpress'] = function(ib)
	ib._track._pressed = false
	windower.prim.set_visibility('%s press':format(tostring(ib)), false)
	ib._track._iconPalette:hide()
end

_meta.IconButton.__methods['update'] = function(ib)
	if ib._track._var.value ~= ib._track._state then
		for ind, icon in ipairs(ib._track._icons) do
			if icon.value == ib._track._var.value then
				windower.prim.set_visibility('%s %s':format(tostring(ib),icon.value), true)
			else
				windower.prim.set_visibility('%s %s':format(tostring(ib),icon.value), false)
			end
		end
		if ib._track._update_command then
			windower.send_command(ib._track._update_command)
		end
		ib._track._state = ib._track._var.value
	end
end

function palette_y_align(y, size)
	y_size = 40 * size + 2
	if y - y_size/2 + 21 < GUI.bound.y.lower then
		return GUI.bound.y.lower
	elseif y + y_size/2 > GUI.bound.y.upper then
		return GUI.bound.y.upper - y_size
	else
		return y - y_size/2 + 21
	end
end

_meta.IconButton.__index = function(ib, k)
    if type(k) == 'string' then
        local lk = k:lower()
		
		return _meta.IconButton.__methods[lk]
		
        --[[if lk == 'current' then
            return m[m._track._current]
        elseif lk == 'value' then
            if m._track._type == 'boolean' then
                return m._track._current
            else
                return m[m._track._current]
            end
        elseif lk == 'has_value' then
            return _meta.M.__methods.f_has_value(m)
        elseif lk == 'default' then
            if m._track._type == 'boolean' then
                return m._track._default
            else
                return m[m._track._default]
            end
        elseif lk == 'description' then
            return m._track._description
        elseif lk == 'index' then
            return m._track._current
        elseif m._track[lk] then
            return m._track[lk]
        elseif m._track['_'..lk] then
            return m._track['_'..lk]
        else
            return _meta.M.__methods[lk]
        end]]
    end
end