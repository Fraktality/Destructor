# Destructor

Bulk object destructor for simplifying cleanup tasks. Supports functions, instances, and connections.

## API

#### `Destructor.new()`

Creates a new object.

#### `Destructor:add(item)`

Adds an item to be finalized on the next call to `destroy`.
Throws an error if the object's type is unsupported.

#### `Destructor:destroy()`

Finalizes items that have been added and removes all items from the Destructor.
The finalizers are defined for various types as follows:
- `Function`: Calls the function.
- `Instance`: Calls :Destroy() on the object.
- `RBXScriptConnection`: Calls :Disconnect() on the object.

## Example

```lua
-- Creation:
local dtor = Destructor.new()


-- Functions:
dtor:add(function()
    print("Foo")
end)
dtor:destroy() -- > Foo


-- Instances:
local newPart = Instance.new("Part", workspace)
dtor:add(newPart)
wait(1)
dtor:destroy() -- newPart is :Destroy()ed


-- Connections:
dtor:add(RunService.Stepped:Connect(function()
    print("Bar") -- Starts printing "Bar" every frame
end))
wait(1)
dtor:destroy() -- Stops printing "Bar" every frame
```
