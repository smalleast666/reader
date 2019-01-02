import 'package:flutter/material.dart';
import '../../model/rank.dart';

class Details extends StatefulWidget {
  final title;
  final id;
  Details({Key key, this.title, this.id}):super(key: key);
  
  @override
  _DetailsState createState() => _DetailsState(id: id,title:title);
}

class _DetailsState extends State<Details> {
  final title;
  final id;
  _DetailsState({Key key, this.title, this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Container(
        child: Text('asdas'),
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
      print(value);
      setState(() {
        data = value;
      });
    });
  }
}