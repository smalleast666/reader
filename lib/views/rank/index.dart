
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
      body: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: rankLeft(rankList: rankList, setBookList: (val) => setBookList(val)),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: rankRight(bookList: bookList),
            ),
          )
        ],
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
        rankList = value;
      });
      getBookListData(value[0]["_id"]).then((valuec){
        setState(() {
          bookList = valuec;
        });
      });
    });
  }
  setBookList(value) {
    setState(() {
      bookList = value;
    });
  }
}

class rankLeft extends StatelessWidget {

  rankLeft({Key key, this.rankList, this.setBookList}):super(key: key);
  final setBookList;
  List<dynamic> rankList;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
                setBookList(value);
              });
            }
          );
        },
        //分割器构造器
        separatorBuilder: (BuildContext context, int index) {
          return Divider(color: Colors.green);
        },
      ),
    );
  }
}


class rankRight extends StatelessWidget {
  List<dynamic> bookList;
  rankRight({Key key, this.bookList}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: bookList == null ? 0 : bookList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Image.network(Statics + bookList[index]["cover"], width: 60),
              ),

              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${index+1}.${bookList[index]["title"]}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2, bottom: 5),
                        child: Text(
                          bookList[index]["shortIntro"],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            
                          )
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 60,
                            child: Text(
                              bookList[index]["author"],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              )
                            ),
                          ),
                          
                          Row(
                            children: <Widget>[
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
                                  child: Text(
                                    bookList[index]["minorCate"],
                                    style: TextStyle(
                                      fontSize: 10
                                    )
                                  )
                                )
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 6),
                                child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.red[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
                                  child: Text(
                                    '${bookList[index]["latelyFollower"]}',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red
                                    )
                                  ),
                                ),
                              ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              
              
              
            ],
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
      
    );
  }
}
