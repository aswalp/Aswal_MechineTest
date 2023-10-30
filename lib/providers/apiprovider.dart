import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/services/apiservices.dart';

import '../model/Itemmodel.dart';

final apidataProvider =
    FutureProvider.autoDispose<List<ResaurantItemModel>>((ref) async {
  return ApiServices.getdata();
});
