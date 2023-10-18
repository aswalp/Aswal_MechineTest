import 'dart:convert';

import 'package:dio/dio.dart';

import '../model/Itemmodel.dart';

class ApiServices {
  static Dio dio = Dio();

  static Future<List<ResaurantItemModel>> getdata() async {
    try {
      Response res =
          await dio.get("https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad");

      if (res.statusCode == 200) {
        String json = jsonEncode(res.data);
        return resaurantItemModelFromJson(json);
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
    throw Exception();
  }
}
