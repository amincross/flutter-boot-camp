import 'dart:convert';

import 'package:flutterbootcamp/explore_page.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Product>> getAllProducts() async {
    var url = Uri.parse("https://fakestoreapi.com/products");

    var response = await http.get(url);

    //خواندن جیسون محصولات از اینترنت
    List<dynamic> json = jsonDecode(response.body);

    //تبدیل جیسون به مدل محصول در لیست
    List<Product> output = List<Product>.from(json.map<Product>((dynamic i) => Product.fromApiJson(i)));

    return output;
  }

  static Future<List<String>> getAllCategories() async {
    var url = Uri.parse("https://fakestoreapi.com/products/categories");

    var response = await http.get(url);

    List<dynamic> json = jsonDecode(response.body);

    List<String> categoriesList = List<String>.from(json as List);

    return categoriesList;
  }
}
