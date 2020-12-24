const express = require("express")
const bp = require("body-parser")
const server = express()

server.use(bp.raw({
    limit: "5mb",
    type: "*/*"
}))

server.post("/", (req, res) => {
    console.log(Buffer.from(req.body).toString("utf8"))
    res.send("OK")
})

server.listen(80)