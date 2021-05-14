import 'package:flutter/material.dart';
import 'ClassList.dart';
import 'package:dio/dio.dart';

Dio dio = new Dio();

class Services{
  static Future<ResponseDataClass> responseHandler(
      {@required apiName, body}) async {
    String url = 'https://hoblist.com/movieList';
    var response;
    try {
      if (body == null) {
        response = await dio.post(url);
      } else {
        response = await dio.post(url, data: body);
      }
      print(body);
      print(apiName);
      if (response.statusCode == 200) {
        ResponseDataClass responseData = new ResponseDataClass(
            message: "No Data", code: 0, result: [],queryParam:{});
        var data = response.data;
        print(response.data);
        responseData.message = data["message"];
        responseData.code = data["code"];
        responseData.result = data["result"];
        responseData.queryParam = data["queryParam"];
        return responseData;
      } else {
        print("error ->" + response.data.toString());
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Catch error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}