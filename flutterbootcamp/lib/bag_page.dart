import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'explore_page.dart';

class BagPage extends StatefulWidget {
  const BagPage({Key? key}) : super(key: key);

  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  List<Product> itemsList = [];

  @override
  void initState() {
    readFromStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  void readFromStorage() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();

    //خواندن جیسون محصولات حافظه
    List<dynamic> json = jsonDecode(storage.containsKey("cart") ? storage.getString("cart")! : '[]');

    //تبدیل جیسون به مدل محصول در لیست
    itemsList = List<Product>.from(json.map<Product>((dynamic i) => Product.fromJson(i)));

    print(itemsList.length);

    setState(() {});
  }
}
