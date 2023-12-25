import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("My Bag", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Icon(
            Icons.list,
            color: Colors.black,
          ),
          SizedBox(width: 12)
        ],
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: Column(
          children: [
            Container(
              width: screenSize.width,
              height: screenSize.height * 0.6,
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    Product currentProduct = itemsList[index];

                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          width: screenSize.width - 50,
                          height: 120,
                          child: Row(
                            children: [
                              Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    currentProduct.imageAddress,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 8),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 250,
                                    child: Text(
                                      currentProduct.name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    width: 250,
                                    child: Text(currentProduct.description,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                  ),
                                  Text(
                                    "\$ " + currentProduct.price.toString(),
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width: 70,
                                        height: 30,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(Icons.arrow_upward_sharp, color: Colors.white),
                                            Text(
                                              "1",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            Icon(Icons.arrow_downward_outlined, color: Colors.white),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            color: Color(0xffad7474), borderRadius: BorderRadius.all(Radius.circular(20))),
                                      ),
                                      InkWell(
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.grey,
                                        ),
                                        onTap: () {
                                          _showDeleteDialog(index);

                                          //deleteProductFromStorage(index);
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: screenSize.width - 100,
                          height: 1,
                          color: Colors.grey.withOpacity(0.5),
                        )
                      ],
                    );
                  },
                  itemCount: itemsList.length),
            ),
            SizedBox(height: 20),
            Divider(height: 0.3, color: Colors.grey),
            Container(
              margin: EdgeInsets.all(20),
              width: screenSize.width,
              height: 40,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Promo Code: ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  Text("PROMO1234", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: screenSize.width,
              height: 40,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Total Amount: ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  Text("\$ " + measureTotalAmount(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: screenSize.width / 2,
              height: 30,
              alignment: Alignment.center,
              child: Text(
                "Buy It Now",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                border: Border.all(color: Colors.black.withOpacity(0.8)),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            )
          ],
        ),
      ),
    );
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

  String measureTotalAmount() {
    int output = 0;

    itemsList.forEach((element) {
      //output=output+element.price;
      output += element.price;
    });

    return output.toString();
  }

  void deleteProductFromStorage(int index) async {
    final SharedPreferences storage = await SharedPreferences.getInstance();

    //خواندن جیسون محصولات حافظه
    List<dynamic> json = jsonDecode(storage.containsKey("cart") ? storage.getString("cart")! : '[]');

    //تبدیل جیسون به مدل محصول در لیست
    List<Product> temp = List<Product>.from(json.map<Product>((dynamic i) => Product.fromJson(i)));

    temp.removeAt(index);

    // ذخیره کل لیست
    await storage.setString('cart', jsonEncode(temp).toString());

    Fluttertoast.showToast(
        msg: "محصول از سبد حذف شد",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.black,
        fontSize: 16.0);

    readFromStorage();
  }

  Future<void> _showDeleteDialog(int index) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('آیا مطمئن هستید؟'),
          content: SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ListBody(
                children: <Widget>[
                  Text('برای حذف محصول تایید کنید'),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('بازگشت'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('حذف'),
              onPressed: () {
                Navigator.of(context).pop();
                deleteProductFromStorage(index);
              },
            ),
          ],
        );
      },
    );
  }
}
