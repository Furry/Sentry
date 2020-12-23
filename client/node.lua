print("Beginning setup sequence...")
if peripheral.isPresent("right") == false then
    error("No sensor found on right side.")
end

print("Startup Successful!")