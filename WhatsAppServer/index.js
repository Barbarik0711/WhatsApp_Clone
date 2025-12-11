const express = require("express");
var http = require("http");
const app = express();
const port = process.env.PORT || 5000;
var server = http.createServer(app);
var io = require("socket.io")(server);
var clients = {};

//middleWare
app.use(express.json());
//CORS
const cors = require('cors'); // <--- ADD THIS
app.use(cors());   

io.on("connection", (socket) => {
  console.log("someone connected!");
  console.log(socket.id, "has joined");
  socket.on("signin", (id) => {
    console.log(id);
    clients[id] = socket;
    console.log(clients);
  });
  socket.on("message", (msg) => {
    console.log(msg);
    let targetId=msg.targetId;
    console.log(targetId);
    console.log(clients[targetId]);
    if(clients[targetId]){
    clients[targetId].emit("message",msg);
    }
  });
});

server.listen(port, "0.0.0.0", () => {
  console.log("server started");
});
