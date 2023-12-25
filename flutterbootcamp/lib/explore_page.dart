import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterbootcamp/show_product_page.dart';

import 'api_service.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<String> categoriesList = [];

  List<Product> productList = [];

  int selectedIndex = 0;

  bool isList = true; //grid

  String dolor = "\$";

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text("Explore", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenSize.width,
              height: 250,
              child: makeMySlider(),
            ),
            Container(
              margin: EdgeInsets.all(12),
              width: screenSize.width,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product Name",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        productList.length.toString() + " Items Found",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    child: Icon((isList == true) ? Icons.list : Icons.grid_view_rounded),
                    onTap: () {
                      if (isList == true) {
                        isList = false;
                      } else {
                        isList = true;
                      }

                      setState(() {});
                    },
                  )
                ],
              ),
            ),
            Container(
              width: screenSize.width,
              height: 30,
              child: (categoriesList.isEmpty)
                  ? SizedBox(width: 50, height: 50, child: CircularProgressIndicator())
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        Color backColor = Colors.white;
                        Color borderColor = Color(0xff000000);
                        Color textColor = Color(0xff000000);

                        if (index == selectedIndex) {
                          backColor = Color(0xffb24040);
                          borderColor = Color(0xffb24040);
                          textColor = Colors.white;
                        } else {
                          backColor = Colors.white;
                          borderColor = Color(0xff000000);
                          textColor = Color(0xff000000);
                        }

                        return InkWell(
                          onTap: () {
                            selectedIndex = index;

                            setState(() {});
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: screenSize.width * 0.20,
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                                color: backColor,
                                border: Border.all(
                                  color: borderColor,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20))),
                            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Text(
                              categoriesList[index],
                              style: TextStyle(color: textColor),
                            ),
                          ),
                        );
                      },
                      itemCount: categoriesList.length,
                    ),
            ),
            makeMyListView(),
          ],
        ),
      ),
    );
  }

  List<String> sliderUrls = [
    "https://fastly.picsum.photos/id/999/536/354.jpg?hmac=xYKikWHOVjOpBeVAsIlSzDv9J0UYTj_tNODJCKJsDo4",
    "https://fastly.picsum.photos/id/237/536/354.jpg?hmac=i0yVXW1ORpyCZpQ-CknuyV-jbtU7_x9EBQVhvT5aRr0",
    "https://fastly.picsum.photos/id/866/536/354.jpg?hmac=tGofDTV7tl2rprappPzKFiZ9vDh5MKj39oa2D--gqhA",
    "https://fastly.picsum.photos/id/1060/536/354.jpg?blur=2&hmac=0zJLs1ar00sBbW5Ahd_4zA6pgZqCVavwuHToO6VtcYY"
  ];

  final PageController controller = PageController(initialPage: 0);

  Widget makeMySlider() {
    var screenSize = MediaQuery.of(context).size;

    return PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: controller,
        itemBuilder: (context, index) {
          return Image.network(
            sliderUrls[index],
            width: screenSize.width,
            fit: BoxFit.fitWidth,
          );
        },
        itemCount: sliderUrls.length);
  }

  @override
  void initState() {
    getAllProducts();
    getAllCategories();

    startTimer();
    super.initState();
  }

  void startTimer() {
    Duration duration = Duration(seconds: 3);

    Timer.periodic(duration, (timer) {
      int sliderPageIndex = controller.page!.toInt() ?? 0;

      if (sliderPageIndex < (sliderUrls.length - 1)) {
        sliderPageIndex++;
      } else {
        sliderPageIndex = 0;
      }

      controller.jumpToPage(sliderPageIndex);
    });
  }

  makeMyListView() {
    Size screenSize = MediaQuery.of(context).size;

    if (isList == true) {
      return SizedBox(
        height: productList.length * 150,
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowProductPage(productList[index])));
                },
                child: Column(
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
                                productList[index].imageAddress,
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
                                child: Text(productList[index].name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              Container(
                                  width: 250,
                                  height: 50,
                                  child: Text(productList[index].description,
                                      overflow: TextOverflow.fade, style: TextStyle(fontSize: 16))),
                              Text(
                                dolor + productList[index].price.toString(),
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
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
                ),
              );
            },
            itemCount: productList.length),
      );
    } else {
      return Container(
          height: 500,
          margin: EdgeInsets.only(left: 12, top: 12, right: 12),
          child: GridView.count(
            crossAxisCount: 2,
            children: List<Widget>.generate(productList.length, (index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShowProductPage(productList[index])),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              productList[index].imageAddress,
                              //width: 120,
                              height: 150,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          margin: EdgeInsets.symmetric(vertical: 4),
                        ),
                        Positioned(
                          right: -30,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (productList[index].isFavorite == true) {
                                  productList[index].isFavorite = false;
                                } else {
                                  productList[index].isFavorite = true;
                                }
                              });
                            },
                            child: Container(
                                margin: EdgeInsets.only(top: 8, right: 36),
                                padding: EdgeInsets.all(4),
                                decoration:
                                    BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(50))),
                                child: Icon(
                                  Icons.favorite,
                                  color: (productList[index].isFavorite == true) ? Colors.red : Colors.grey,
                                )),
                          ),
                        )
                      ],
                    ),
                    Text(productList[index].name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(productList[index].description, style: TextStyle(fontSize: 16)),
                    SizedBox(height: 4),
                    Text(
                      dolor + productList[index].price.toString(),
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }),
          ));
    }
  }

  void getAllProducts() async {
    productList = await ApiService.getAllProducts();
    setState(() {});
  }

  void getAllCategories() async {
    categoriesList = await ApiService.getAllCategories();
    setState(() {});
  }
}

class Product {
  String name;
  String description;
  int price;
  String imageAddress;
  bool isFavorite;

  Product(this.name, this.description, this.price, this.imageAddress, this.isFavorite);

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        json["name"],
        json["description"],
        json["price"],
        json["imageAddress"],
        json["isFavorite"],
      );

  factory Product.fromApiJson(Map<String, dynamic> json) => Product(
        json["title"],
        json["description"],
        json["price"].round(),
        json["image"],
        false,
      );

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "description": this.description,
      "price": this.price,
      "imageAddress": this.imageAddress,
      "isFavorite": this.isFavorite
    };
  }
}
