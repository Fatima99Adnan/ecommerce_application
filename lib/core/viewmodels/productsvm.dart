import 'package:dio/dio.dart';
import 'package:ecommerce_application/core/constants/api_route.dart';
import 'package:ecommerce_application/core/models/products.dart';
import 'package:ecommerce_application/helpers/http_request.dart';
import 'package:flutter/foundation.dart';

class ProductsVM extends ChangeNotifier {
  HttpRequest request = HttpRequest.instance;

  List<Products> allProducts = [];
  int total = 0;
  void getProductsFromServer() async {
    Response res = await request.get(url: ApiRoute.products);
    List<dynamic> allProducts = res.data['products'];

    this.allProducts = allProducts.map((i) => Products.fromJson(i)).toList();
    notifyListeners();
  }

  addOne() {
    total++;
    notifyListeners();
  }
}
