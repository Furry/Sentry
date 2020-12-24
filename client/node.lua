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

local x, y, z;

-- Validation for static storage --
if fs.exists("storage") == false then -- We know this is a fresh startup

    print("Welcome to the Sentry Installer Script!")
    print("Please enter the X, Y, and Z coordnates of this computer.")
    print("X: "); x = tonumber(read())
    print("Y: "); y = tonumber(read())
    print("Z: "); z = tonumber(read())

    xf = fs.open("x", "wa")
    yf = fs.open("y", "wa")
    zf = fs.open("z", "wa")

    xf.write(x)
    yf.write(y)
    zf.write(z)
else
    x = tonumber(fs.open("x", "r").readAll())
    y = tonumber(fs.open("y", "r").readAll())
    z = tonumber(fs.open("z", "r").readAll())

end

-- local sensor = peripheral.find("openperipheral_sensor")
-- if sensor == nil then
--     error("No sensor found!")
--     exit()
-- else
--     print("Sensor Found!")
-- end

-- while true do
--     players = sensor.getPlayers()
--     if getTableLength(players) == 0 then
--         os.sleep(5)
--     else
--         for k, v in pairs(players) do
--             data = sensor.getPlayerByName(v["name"]).all()
--             print(data)
--             print(getKeys(data))
--             json.encode(data)
--         end
--     end
-- end