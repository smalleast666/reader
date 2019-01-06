import 'package:flutter/material.dart';
//程序入口
void main() {
  runApp(new FriendlychatApp());
}

const String _name = "CYC";    //聊天帐号昵称

class FriendlychatApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
    return new MaterialApp(        //创建一个MaterialApp控件对象，其下可塞入支持Material设计语言特性的控件
      title: "Friendlychat",
      home: new ChatScreen(),    //主页面为用户自定义ChatScreen控件
    );
  }
}

//单条聊天信息控件
class ChatMessage extends StatelessWidget {
  ChatMessage({this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(                                   //聊天记录的头像和文本信息横向排列
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(child: new Text(_name[0])),      //显示头像圆圈
          ),
          new Column(                                    //单条消息记录，昵称和消息内容垂直排列
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(_name, style: Theme.of(context).textTheme.subhead),    //昵称
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(text),                    //消息文字
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//聊天主页面ChatScreen控件定义为一个有状态控件
class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatScreenState();   //ChatScreenState作为控制ChatScreen控件状态的子类
}

//ChatScreenState状态中实现聊天内容的动态更新
class ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = <ChatMessage>[];    //存放聊天记录的数组，数组类型为无状态控件ChatMessage
  final TextEditingController _textController = new TextEditingController();    //聊天窗口的文本输入控件

  //定义发送文本事件的处理函数
  void _handleSubmitted(String text) {
    _textController.clear();        //清空输入框
    ChatMessage message = new ChatMessage(    //定义新的消息记录控件对象
      text: text,
    );
    //状态变更，向聊天记录中插入新记录
    setState(() {
      _messages.insert(0, message);      //插入新的消息记录
    });
  }

  //定义文本输入框控件
  Widget _buildTextComposer() {
   return new Container(
       margin: const EdgeInsets.symmetric(horizontal: 8.0),  
       child: new Row(                    //文本输入和发送按钮都在同一行，使用Row控件包裹实现
          children: <Widget>[
            new Flexible(                    
              child: new TextField( 
                controller: _textController,              //载入文本输入控件
                onSubmitted: _handleSubmitted, 
                decoration: new InputDecoration.collapsed(hintText: "Send a message"),      //输入框中默认提示文字
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(            //发送按钮
                icon: new Icon(Icons.send),    //发送按钮图标
                onPressed: () => _handleSubmitted(_textController.text)),      //触发发送消息事件执行的函数_handleSubmitted
           ),
         ]
       )
    );
  }
  //定义整个聊天窗口的页面元素布局
  Widget build(BuildContext context) {
    return new Scaffold(              //页面脚手架
      appBar: new AppBar(title: new Text("Friendlychat")),      //页面标题
      body: new Column(             //Column使消息记录和消息输入框垂直排列
        children: <Widget>[
        new Flexible(                     //子控件可柔性填充，如果下方弹出输入框，使消息记录列表可适当缩小高度
          child: new ListView.builder(        //可滚动显示的消息列表
            padding: new EdgeInsets.all(8.0),
            reverse: true,                  //反转排序，列表信息从下至上排列
            itemBuilder: (_, int index) => _messages[index],    //插入聊天信息控件
            itemCount: _messages.length,
          )
        ),
        new Divider(height: 1.0),      //聊天记录和输入框之间的分隔
        new Container(
          decoration: new BoxDecoration(
            color: Theme.of(context).cardColor),
          child: _buildTextComposer(),        //页面下方的文本输入控件
        ),
       ]
     ),
   );
  }
}
