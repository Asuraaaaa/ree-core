Queue = { HandleFns = {} }

AddEventHandler("ree:registerQueueHandler", function(pluginName, cb)
    if pluginName ~= nil and type(cb) == "func" then
        REE.Log("Registered queue handler for " .. pluginName)
        Queue.HandleFns[pluginName] = cb
    end
end)