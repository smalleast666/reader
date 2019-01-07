

import 'package:flutter/material.dart';
import './index.dart';

class ChatList extends StatefulWidget {
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Center(
       child: FlatButton(
         child: Icon(Icons.message,size: 60),
         onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) {
             return Message();
           }));
         },
       ),
    );
  }
}