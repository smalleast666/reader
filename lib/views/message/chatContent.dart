
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

import '../../utils/const.dart';


class ChatContent extends StatefulWidget {
  @override
  _ChatContentState createState() => new _ChatContentState();
}

class _ChatContentState extends State<ChatContent> {
  TextEditingController _controller = new TextEditingController();
  IOWebSocketChannel channel;
  Map<String, dynamic> sendTemp = {"cmd": 6, "username": "client", "email": "963732141@qq.com", "message": ""};
  List<Map> messageList = [];
  FocusNode sendFocusNode = new FocusNode();
  int currentHashCode;

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
              child: GestureDetector(
                onTap: () => sendFocusNode.unfocus(),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: StreamBuilder(
                    stream: channel.stream,
                    builder: (context, snapshot) {
                      //网络不通会走到这
                      if (snapshot.hasError) {
                        return Text("socket连接失败");
                      } else if (snapshot.hasData) {
                        // messageList.add(jsonDecode(snapshot.data));
                        // currentHashCode = snapshot.hashCode;
                        messageList.insert(0, jsonDecode(snapshot.data));
                      }
                      return ListView.builder(
                        reverse: true, // 反序
                        itemCount: messageList != null ? messageList.length : 0,
                        itemBuilder: (BuildContext context, int index) {
                          if (messageList != null) {
                            return messageList[index]["username"] == "client" ? 
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width * .8,
                                    child: Text(messageList[index]["message"], textAlign: TextAlign.end,),
                                  ),
                                  Text("：" + messageList[index]["username"]),
                                ],
                              ) : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(messageList[index]["username"] + "："),
                                  Container(
                                    width: MediaQuery.of(context).size.width * .8,
                                    child: Text(messageList[index]["message"], overflow: TextOverflow.ellipsis,maxLines: 10,),
                                  )
                                ],
                              );
                          } else {
                            return Text("暂无消息");
                          }
                        },
                      );
                      
                    },
                  ),
                ),
              ),
            ),
            Divider(height: 1),
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Container(
                  width: 40,
                  child: IconButton(
                    // onPressed: _sendMessage,
                    icon: Icon(Icons.photo),
                    color: Colors.lightBlue,
                  ),
                ),
                Expanded(
                  child: Form(
                    child: TextFormField(
                      focusNode: sendFocusNode,
                      controller: _controller,
                      decoration: InputDecoration(border: InputBorder.none),
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
      sendTemp["message"] = _controller.text;
      channel.sink.add(jsonEncode(sendTemp));
      _controller.text = "";
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}