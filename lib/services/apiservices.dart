import 'dart:convert';

import 'package:dio/dio.dart';

import '../model/Itemmodel.dart';

class ApiServices {
  static Dio dio = Dio();

  static Future<List<ResaurantItemModel>> getdata() async {
    try {
      Response res = await dio
          .get("https://run.mocky.io/v3/4d116e3e-808c-43ab-93ed-6c70540d4e18");

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
