import 'package:flutter/material.dart';
import '../../model/rank.dart';

class Content extends StatefulWidget {
  final link;
  Content({Key key, this.link}):super(key: key);
  
  @override
  _ContentState createState() => _ContentState(link:link);
}

class _ContentState extends State<Content> {
  final link;
  _ContentState({Key key, this.link});

  Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(data != null ? data["title"] : '加载中')),
      body: data != null ? SingleChildScrollView(
        child: Text(data["cpContent"]),
        padding: EdgeInsets.all(8),
      ) : Center(child: Text('加载中'))
    );
  }


   @override
  void initState() {
      // TODO: implement initState
      super.initState();
      _getData();
  }

  Future _getData() async {
    getContentData(link).then((value){
      setState(() {
        data = value;
      });
    });
  }
}
