-- habilita la depuración utilizando la extensión para Visual Studio Code llamada local lua debugger
function enable_local_lua_debugger()
    if os.getenv "LOCAL_LUA_DEBUGGER_VSCODE" == "1" then
        local lldebugger = require "lldebugger"
        lldebugger.start()
        local run = love.run
        function love.run(...)
            local f = lldebugger.call(run, false, ...)
            return function(...) return lldebugger.call(f, false, ...) end
        end
    end
end

-- redondea el número 'num' con 'n' dígitos decimales
function round(num, n)
    local mult = 10 ^ (n or 0)
    return math.floor(num * mult + 0.5) / mult
end

-- devuelve una copia de la tabla que se pasa como primer argumento
function copy_table(obj, seen) -- el segundo parámetro se ignora, es para detectar recursión
    if type(obj) ~= "table" then
        return obj
    end
    if seen and seen[obj] then
        return seen[obj]
    end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do
        res[copyTable(k, s)] = copyTable(v, s)
    end
    return res
end
