import 'package:flutter/material.dart';
import '../../model/rank.dart';

class Content extends StatefulWidget {
  final chapterList;
  final index;
  Content({Key key, this.chapterList, this.index}):super(key: key);
  
  @override
  _ContentState createState() => _ContentState(chapterList: chapterList, index: index);
}

class _ContentState extends State<Content> {
  final chapterList;
  int index;
  _ContentState({Key key, this.chapterList, this.index});

  Map<String, dynamic> data;

  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(data != null ? data["title"] : '加载中')),
      body: data != null ? SingleChildScrollView(
        controller: _controller,
        padding: EdgeInsets.all(8),
        child: Text(
          data["cpContent"],
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      // ) : Center(child: Text('加载中'))
      ) : Center(child: Text('加载中'))
    );
  }


  @override
  void initState() {
      // TODO: implement initState
      super.initState();
      _getData(chapterList[index]["link"]);

      _controller.addListener(() {
        if (_controller.offset >= _controller.position.maxScrollExtent) {
          _getData(chapterList[index+1]["link"]);
          _controller.animateTo(0,
            duration: Duration(milliseconds: 0),
            curve: Curves.ease
          );
          setState(() {
            index ++;
          });
        }
      });
  }

  @override
  void dispose() { 
    _controller.dispose();
    super.dispose();
  }



  Future _getData(link) async {
    getContentData(link).then((value){
      setState(() {
        data = value;
      });
    });
  }
}
