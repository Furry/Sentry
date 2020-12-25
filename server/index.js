const express = require("express")
const ngrok = require("ngrok")
const bp = require("body-parser")
const dJSON = require("dirty-json")
const server = express()
const Discord = require("discord.js")
const e = require("express")

server.use(bp.raw({
    limit: "5mb",
    type: "*/*"
}))

server.use(express.static("../client"))

const client = new Discord.Client()

const allowed = [
    "Meisen", "TotallyNotHusky",
    "DrakOn3", "Rhinorion",
    "WiselyWheat", "Smaugie",
    "ProbablyNotHusky"
]

server.post("/", (req, res) => {
    const bodyData = Buffer.from(req.body).toString("utf8")

    const body = dJSON.parse(bodyData)

    if (!allowed.includes(body.basic.name)) {
        const embed = new Discord.MessageEmbed()
        embed.setColor("RANDOM")
        embed.setTitle("Player Spotted!")
        embed.addField("Name:", body.basic.name, true)
        embed.addField("Location:", `${Math.floor(parseInt(body.pos.player.x))}, ${Math.floor(parseInt(body.pos.player.y))}, ${Math.floor(parseInt(body.pos.player.z))}`, true)
        embed.addField("Tracker:", body.pos.name, true)
        embed.setTimestamp(Date.now())
        if (!body.pos.name.includes("private")) {
            client.guilds.cache.get("791876148262469662").channels.cache.get("791876180332511273").send("@everyone", embed)
        } else {
            client.guilds.cache.get("791876148262469662").channels.cache.get("791895022089928735").send("@everyone", embed)
        }
    }
    res.send("OK")
})

client.login("NzkxODg5NzcyNzA4NDk1MzYx.X-Vu0g.1EwUQ24EjsZG5EUihuQcZxQ_81Q")
.then(() => {
    server.listen(80, async () => {
        const url = await ngrok.connect({
            proto: "http",
            addr: 80,
            subdomain: "haxyshideout",
            authtoken: "1QQSM5qvktTh0IlLUWX9XmKSe6p_5A971BaK53WAFjWzDNt9P"
        })
        console.log(`loadstring(http.get("${url}/install.lua").readAll())()`)
    })
})