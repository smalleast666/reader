import 'package:flutter/material.dart';

import './views/my/index.dart';
import './views/rank/index.dart';
import './views/collection/index.dart';
import './views/message/index.dart';

bool debugPaintSizeEnabled = true;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNav(),
      // routes: <String, WidgetBuilder> {
        // '/rank/list': (BuildContext context) => 
      // },
    );
  }
}

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _tabIndex = 0;
  List<dynamic> body = [
    Message(),
    Collection(),
    Rank(),
    My(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[_tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text("社区"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text("收藏"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            title: Text("排行版"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text("个人中心"),
          ),

        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;         
          });
        },
      ),
    );
  }


}

