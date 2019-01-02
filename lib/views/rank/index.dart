
import 'package:flutter/material.dart';
import './bookList.dart';


import '../../model/rank.dart';
class Rank extends StatefulWidget {
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> {

  List<dynamic> data;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("排行榜")),
      body: ListView.separated(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return FlatButton(
            // padding: EdgeInsets.all(10),
            // color: Colors.lightBlue,
            child: Text(data[index]["title"]),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return BookList(title: data[index]["title"], id:  data[index]["_id"]);
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
    getRankData().then((value){
      setState(() {
        data = value;
      });
    });
  }
}
