local Destructor = {}
Destructor.__index = Destructor

local finalizers = setmetatable({
	["function"] = function(item)
		return item()
	end,
	["Instance"] = game.Destroy,
	["RBXScriptConnection"] = Instance.new("BindableEvent").Event:Connect(function() end).Disconnect,
}, {
	__index = function(self, className)
		error(("Cannot destruct item of type '%s' (no finalizer is defined)"):format(className), 3)
	end
})

function Destructor.new()
	return setmetatable({}, Destructor)
end

function Destructor:add(item)
	self[item] = finalizers[typeof(item)]
	return item
end

function Destructor:remove(item)
	self[item] = nil
	return item
end

function Destructor:destroy()
	for item, finalizer in pairs(self) do
		finalizer(item)
	end
	table.clear(self)
end

return Destructor
