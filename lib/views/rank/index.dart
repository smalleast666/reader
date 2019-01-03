
import 'package:flutter/material.dart';

import './chapter.dart';
import '../../model/rank.dart';
import '../../utils/const.dart';


class Rank extends StatefulWidget {
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> {

  List<dynamic> rankList;
  List<dynamic> bookList;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("小说排行榜")),
      body: Row(
        children: <Widget>[
          Container(
            width: 100,
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.lightBlue, width: 1))
            ),
            child: ListView.separated(
              itemCount: rankList == null ? 0 : rankList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Text(
                    rankList[index]["title"], 
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15
                    )
                  ),
                  onTap: () {
                    getBookListData(rankList[index]["_id"]).then((value){
                      setState(() {
                        bookList = value;
                      });
                    });
                  }
                );
              },
              //分割器构造器
              separatorBuilder: (BuildContext context, int index) {
                return Divider(color: Colors.green);
              },
            ),
          ),
          Container(
            width: 260,
            padding: EdgeInsets.all(8),
            child: ListView.separated(
              itemCount: bookList == null ? 0 : bookList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Image.network(Statics + bookList[index]["cover"], width: 60),
                        Container(
                          width: 184,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${index+1}.${bookList[index]["title"]}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                bookList[index]["shortIntro"],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey
                                )
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    bookList[index]["author"],
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    )
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(bookList[index]["minorCate"],style: TextStyle(fontSize: 12)),
                                      Text('${bookList[index]["latelyFollower"]}新增',style: TextStyle(fontSize: 12)),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                        
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return Chapter(title: bookList[index]["title"], id:  bookList[index]["_id"]);
                    }));
                  },
                );
              },
              //分割器构造器
              separatorBuilder: (BuildContext context, int index) {
                return Divider(color: Colors.green);
              },
            ),
          ),

        ],
      )
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
        rankList = value;
      });
      getBookListData(value[0]["_id"]).then((valuec){
        setState(() {
          bookList = valuec;
        });
      });
    });
    
  }
}
