import 'package:flutter/material.dart';
import '../../model/rank.dart';
import './content.dart';

class Chapter extends StatefulWidget {
  final title;
  final id;
  Chapter({Key key, this.title, this.id}):super(key: key);
  
  @override
  _ChapterState createState() => _ChapterState(id: id,title:title);
}

class _ChapterState extends State<Chapter> {
  final title;
  final id;
  _ChapterState({Key key, this.title, this.id});

  List<dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Text(data[index]["title"], style: TextStyle(fontSize: 16),),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return Content(link: data[index]["link"]);
              }));
            },
          );
        },
        //分割器构造器
        separatorBuilder: (BuildContext context, int index) {
          return Divider(color: Colors.green);
        },
      ),
    );
  }


   @override
  void initState() {
      // TODO: implement initState
      super.initState();
      _getData();
  }

  Future _getData() async {
    getChapterData(id).then((value){
      setState(() {
        data = value;
      });
    });
  }
}