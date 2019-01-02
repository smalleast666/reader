

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
  Response<dynamic> response = await dio.get("$Api/mix-atoc/$bookId?view=chapters");
     
  return response.data["mixToc"]["chapters"];
}

// 获取内容
getContentData(String link) async {
  print("$Chap/chapter/$link");
  Response<dynamic> response = await dio.get("$Chap/chapter/$link");
     
  return response.data["chapter"];
}