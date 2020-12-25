local script, err = http.get("https://haxyshideout.ngrok.io/node.lua").readAll()
if err ~= nil then
    print("Couldn't fetch the node script!")
    exit()
end
local handle = fs.open("startup", "w")
handle.write(script)
handle.close()
loadstring(script)()