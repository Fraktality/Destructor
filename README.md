# Destructor

Bulk object destructor for simplifying cleanup tasks.

## API

#### `Destructor.new()`

Creates a new object.

#### `Destructor:add(item)`

Adds an item to be destructed on the next call to `destroy`.
An error is thrown if the object type is not supported. See below for supported object types.

#### `Destructor:destroy()`

Destroys objects that have been added and clears the buffer.
The actual finalizers are defined for different types as follows:
- `Function`: Calls the function.
- `Instance`: Calls :Destroy() on the instance.
- `RBXScriptConnection`: Calls :Disconnect() on the connection.

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
