local sensor = peripheral.find("openperipheral_sensor")
if sensor == nil then
    error("No sensor found!")
    exit()
else
    print("Sensor Found!")
end

for k, v in pairs(sensor.getPlayers()) do
    --print(k, v[0])
    for k1, v1 in pairs(v) do
        print("-", k, "=", v)
    end
end