local sensor = peripheral.find("openperipheral_sensor")
if sensor == nil then
    error("No sensor found!")
    exit()
else
    print("Sensor Found!")
end

for k, v in pairs(sensor.getPlayers()) do

end