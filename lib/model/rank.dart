

import 'package:dio/dio.dart';
import '../utils/const.dart';

Dio dio = new Dio();

// 获取分类排行
getRankData() async {
  Response<dynamic> response = await dio.get("$Api/ranking/gender");
     
  return response.data["female"];
}

// 获取排行列表
getBookListData(String id) async {
  Response<dynamic> response = await dio.get("$Api/ranking/$id");
     
  return response.data["ranking"]["books"];
}

// 获取列表详情
getDetailsData(String id) async {
  Response<dynamic> response = await dio.get("$Api/book/$id");
     
  return response.data["ranking"]["books"];
}

// 获取章节
getChapterData(String bookId) async {
  Response<dynamic> responses = await dio.get("$Api/btoc?view=summary&book=$bookId");
  String id = responses.data[0]["_id"] ?? '';
  Response<dynamic> response = await dio.get("$Api/atoc/$id?view=chapters");
  return response.data["chapters"];
}

// 获取内容
getContentData(String link) async {

  Response<dynamic> response = await dio.get("$Chap/chapter/$link");

  return response.data["chapter"];
}