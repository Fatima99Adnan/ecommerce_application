import 'package:dio/dio.dart';
import 'package:ecommerce_application/core/constants/api_route.dart';
import 'package:ecommerce_application/core/models/category.dart' as pCat;
import 'package:ecommerce_application/helpers/http_request.dart';
import 'package:flutter/foundation.dart';

class CategoryVM extends ChangeNotifier {
  HttpRequest request = HttpRequest.instance;

  List<pCat.Category> allCategories = [];

  Future<void> getCategoriesFromServer() async {
    Response<dynamic> res = await request.get(url: ApiRoute.categories);
    List<dynamic> cats = res.data;

    allCategories = cats.map((item) => pCat.Category.fromJson(item)).toList();
    notifyListeners();
  }
}
