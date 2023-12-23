import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bag_page.dart';
import 'explore_page.dart';

class ShowProductPage extends StatefulWidget {
  Product product;

  ShowProductPage(this.product);

  @override
  State<ShowProductPage> createState() => _ShowProductPageState();
}

class _ShowProductPageState extends State<ShowProductPage> {
  String? selectedColor = null;
  String? selectedSize = null;

  int selectedCount = 1;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    String dolor = "\$";

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Image.network(
              widget.product.imageAddress,
              fit: BoxFit.fitHeight,
              width: screenSize.width,
              height: screenSize.height * 0.8,
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                Icon(Icons.favorite),
                SizedBox(width: 12),
                InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BagPage()));
                    },
                    child: Icon(Icons.shopping_basket)),
                SizedBox(width: 12),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: Container(
                  color: Colors.white,
                  height: screenSize.height * 0.4,
                  width: screenSize.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.product.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(widget.product.description, style: TextStyle(fontSize: 16)),
                      Text(
                        dolor + widget.product.price.toString(),
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star_border_outlined, color: Colors.yellowAccent),
                          Icon(Icons.star_border_outlined, color: Colors.yellowAccent),
                          Icon(Icons.star_border_outlined, color: Colors.yellowAccent),
                          Icon(Icons.star_border_outlined, color: Colors.yellowAccent),
                          Icon(Icons.star_border_outlined, color: Colors.yellowAccent),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                color: Color(0xffad7474),
                                border: Border.all(color: Color(0xffad7474)),
                                borderRadius: BorderRadius.all(Radius.circular(20))),
                            child: DropdownButton<String>(
                              value: selectedColor,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              items: <String>['Red', 'Green', 'Blue', 'Yellow'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              hint: Text("Color", style: TextStyle(color: Colors.white)),
                              onChanged: (value) {
                                setState(() {
                                  selectedColor = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                color: Color(0xffad7474),
                                border: Border.all(color: Color(0xffad7474)),
                                borderRadius: BorderRadius.all(Radius.circular(20))),
                            child: DropdownButton<String>(
                              value: selectedSize,
                              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                              items: <String>['L', 'M', 'XM', 'XL'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              hint: Text("Size", style: TextStyle(color: Colors.white)),
                              onChanged: (value) {
                                setState(() {
                                  selectedSize = value;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      Container(
                          width: 100,
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                              color: Color(0xffad7474),
                              border: Border.all(color: Color(0xffad7474)),
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                child: Icon(Icons.arrow_upward_sharp, color: Colors.white),
                                onTap: () {
                                  setState(() {
                                    selectedCount++;
                                  });
                                },
                              ),
                              Text(selectedCount.toString(), style: TextStyle(color: Colors.white)),
                              InkWell(
                                child: Icon(Icons.arrow_downward, color: Colors.white),
                                onTap: () {
                                  if (selectedCount >= 2) {
                                    setState(() {
                                      selectedCount--;
                                    });
                                  }
                                },
                              ),
                            ],
                          )),
                      InkWell(
                        onTap: () {
                          addToBag();
                        },
                        child: Container(
                          width: 250,
                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          decoration: BoxDecoration(
                              color: Color(0xff545454),
                              border: Border.all(color: Color(0xff545454)),
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_bag_outlined,
                                color: Colors.white,
                              ),
                              Text(
                                "Add To Bag",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void addToBag() async {
    //باز کردن حافظه و ارتباط با حافظه
    final SharedPreferences storage = await SharedPreferences.getInstance();

    //خواندن جیسون محصولات حافظه
    List<dynamic> json = jsonDecode(storage.containsKey("cart") ? storage.getString("cart")! : '[]');

    //تبدیل جیسون به مدل محصول در لیست
    List<Product> itemsList = List<Product>.from(json.map<Product>((dynamic i) => Product.fromJson(i)));

    //افزودن محصول باز شده به لیست قبل
    itemsList.add(widget.product);

    // ذخیره کل لیست
    await storage.setString('cart', jsonEncode(itemsList).toString());

    Fluttertoast.showToast(
        msg: "محصول به سبد اضافه شد",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
