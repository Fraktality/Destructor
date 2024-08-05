local Destructor = {}
Destructor.__index = Destructor

local finalizers = {
	["thread"] = task.cancel,
	["function"] = task.spawn,
	["Instance"] = game.Destroy,
	["RBXScriptConnection"] = Instance.new("BindableEvent").Event:Connect(function() end).Disconnect,
}

function Destructor.new()
	return setmetatable({}, Destructor)
end

function Destructor:add(item)
	local typeName = typeof(item)
	local finalizer = finalizers[typeName]
	if not finalizer and typeName == "table" then
		finalizer = item.Destroy or item.destroy or item.Disconnect or item.DisconnectAll
	end
	if not finalizer then
		error(`cannot destruct item of type '{typeName}'`, 2)
	end
	self[item] = finalizers[typeof(item)]
	return item
end

function Destructor:remove(item)
	self[item] = nil
	return item
end

function Destructor:destroy()
	for item, finalizer in self do
		finalizer(item)
	end
	table.clear(self)
end

return Destructor
