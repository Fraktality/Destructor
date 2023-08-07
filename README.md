# Destructor

A simple and elegant pattern for cleaning up objects and tasks, in under 40 lines of code.

## API

#### `Destructor.new()`

Creates a new destructor.

#### `Destructor:add(item)`

Adds an item to be finalized on the next call to `destroy`.
Throws an error if the object's type is unsupported.
Returns the item.

#### `Destructor:destroy()`

Finalizes items that have been added and removes all items from the Destructor.
The finalizers are defined for various types as follows:
- `Function`: Calls the function.
- `Thread`: Cancels the thread via task.cancel.
- `Instance`: Calls :Destroy() on the object.
- `RBXScriptConnection`: Calls :Disconnect() on the object.

## Example

```lua
local dtor = Destructor.new()

-- Functions
dtor:add(function()
    print("destroying")
end)

-- Instances
local part = dtor:add(Instance.new("Part", workspace))

-- Connections
dtor:add(RunService.Stepped:Connect(function()
    print("foo")
end))

-- Threads
dtor:add(task.spawn(function()
    while true do
        print("bar")
        task.wait()
    end
end))
```
