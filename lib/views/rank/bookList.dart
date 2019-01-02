
import 'package:flutter/material.dart';
import '../../model/rank.dart';
import './chapter.dart';

class BookList extends StatefulWidget {

  final id;
  final title;
  BookList({Key key, this.title, this.id}):super(key: key);

  @override
  _BookListState createState() => _BookListState(id: id,title:title);
}

class _BookListState extends State<BookList> {
  final id;
  final title;
  _BookListState({Key key, this.title, this.id});

  List<dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return FlatButton(
            child: Text(data[index]["title"]),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return Chapter(title: data[index]["title"], id:  data[index]["_id"]);
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
    getBookListData(id).then((value){
      setState(() {
        data = value;
      });
    });
  }

}