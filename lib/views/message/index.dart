import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

import '../../utils/const.dart';


class Message extends StatefulWidget {
  @override
  _MessageState createState() => new _MessageState();
}

class _MessageState extends State<Message> {
  TextEditingController _controller = new TextEditingController();
  IOWebSocketChannel channel;
  Map<String, dynamic> sendTemp = {"cmd": 6, "username": "client", "email": "963732141@qq.com", "message": ""};
  String _text = "";
  List<Map> messageList = [];

  @override
  void initState() {
    //创建websocket连接
    channel = new IOWebSocketChannel.connect(SocketUrl);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("WebSocket(内容回显)"),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  //网络不通会走到这
                  if (snapshot.hasError) {
                    _text = "网络不通...";
                  } else if (snapshot.hasData) {
                    messageList.add(jsonDecode(snapshot.data));
                  }
                  return ListView.builder(
                      // shrinkWrap: true,
                      // reverse: true,
                      itemCount: messageList != null ? messageList.length : 0,
                      itemBuilder: (BuildContext context, int index) {
                        return messageList != null ? 
                          messageList[index]["username"] == "client" ? 
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(messageList[index]["username"] + "："),
                                Container(
                                  width: MediaQuery.of(context).size.width * .8,
                                  child: Text(messageList[index]["message"], overflow: TextOverflow.ellipsis,maxLines: 10,),
                                )
                              ],
                            )
                            
                            : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(messageList[index]["message"]),
                                Text("：" + messageList[index]["username"]),
                              ],
                            )
                          : Text("暂无消息");
                      },
                    );
                  
                },
              ),
            ),
            Divider(height: 1),
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Container(
                  width: 40,
                  child: IconButton(
                    onPressed: _sendMessage,
                    icon: Icon(Icons.send),
                    color: Colors.lightBlue,
                  ),
                ),
                Expanded(
                  child: Form(
                    child: new TextFormField(
                      controller: _controller,
                      decoration: new InputDecoration(),
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  child: IconButton(
                    onPressed: _sendMessage,
                    icon: Icon(Icons.send),
                    color: Colors.lightBlue,
                  ),
                ),
              ],
            ),
          ],
        ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      // print(_controller.text);
      sendTemp["message"] = _controller.text;
      channel.sink.add(jsonEncode(sendTemp));
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}