function getTableLength(table)
    local count = 0
    for _ in pairs(table) do count = count + 1 end
    return count
end

function getKeys(table)
    for k, v in pairs(table) do
        print(tostring(k) .. ": " .. tostring(v))
    end
end

function quoteWrap(input)
    return "\"" .. tostring(input) .. "\""
end

function createTablePair(name, tbl)
    return "\"" .. name .. "\": " .. toJSON(tbl)
end

function createStrPair(name, value)
    return "\"" .. name .. "\": " .. value
end

function toJSON(table)
    local data = "{"
    local index = 0
    local size = getTableLength(table)
    for k1, v1 in pairs(table) do
        index = index + 1
        if type(v1) == "table" then
            data = data .. quoteWrap(tostring(k1)) .. ":" .. toJSON(v1)
            if index ~= size then
                data = data .. ","
            end
        elseif type(v1) ~= "function" then
            data = data .. tostring(quoteWrap(k1)) .. ":" .. tostring(quoteWrap(v1))
            if index ~= size then
                data = data .. ","
            end
        elseif k1 == "all" then
            data = data .. quoteWrap(tostring(k1)) .. ":" .. toJSON(v1())
            if index ~= size then
                data = data .. ","
            end
        end
    end
    data = data .. "}"
    return data
end

local x, y, z, location;

-- Validation for static storage --
if fs.exists("x") == false then -- We know this is a fresh startup
    print("Welcome to the Sentry Installer Script!!")
    print("Please enter the location name, X, Y, and Z coordnates of this computer.")
    print("LOCATION: "); location = read()
    print("X: "); x = tonumber(read())
    print("Y: "); y = tonumber(read())
    print("Z: "); z = tonumber(read())

    xf = fs.open("x", "w")
    yf = fs.open("y", "w")
    zf = fs.open("z", "w")
    locationf = fs.open("location", "w")

    xf.write(x)
    yf.write(y)
    zf.write(z)
    locationf.write(location)

    xf.close()
    yf.close()
    zf.close()
    locationf.close()
else
    x = tonumber(fs.open("x", "r").readAll())
    y = tonumber(fs.open("y", "r").readAll())
    z = tonumber(fs.open("z", "r").readAll())
    location = fs.open("location", "r").readAll()
end

local sensor = peripheral.find("openperipheral_sensor")
if sensor == nil then
    error("No sensor found!")
    exit()
else
    print("Sensor Found!")
end


while true do
    local players = sensor.getPlayers()
    if getTableLength(players) == 0 then
        os.sleep(5)
    else
        for k, v in pairs(players) do
            local data = sensor.getPlayerByName(v["name"])
            local deep = data.all()
            local basic = data.basic()
            local payload = {
                deep = deep,
                basic = basic,
                pos = {
                    name = location,
                    computer = {
                        x=x,
                        y=y,
                        z=z,
                    },
                    player = {
                        x = x + deep.position["x"],
                        y = y + deep.position["y"],
                        z = z + deep.position["z"]
                    }
                }
            }
            local jsonBody = toJSON(payload)
            http.post("https://haxyshideout.ngrok.io/", jsonBody)
        end
    end
    sleep(10)
end