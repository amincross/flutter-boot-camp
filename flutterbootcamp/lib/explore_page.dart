import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<String> categoriesList = [
    "All",
    "Blazers",
    "Jackets",
    "Dress",
  ];

  List<Product> productList = [
    Product("Product 1", "aeofjwefjwioejfiowefjwiefj", 1023, "assets/images/image1.jpg", true),
    Product("Product 2", "aeofjwefjwioejfiowefjwiefj", 1023, "assets/images/image1.jpg", false),
    Product("Product 3", "aeofjwefjwioejfiowefjwiefj", 1023, "assets/images/image1.jpg", true),
    Product("Product 4", "aeofjwefjwioejfiowefjwiefj", 1023, "assets/images/image1.jpg", false),
    Product("Product 5", "aeofjwefjwioejfiowefjwiefj", 1023, "assets/images/image1.jpg", false),
    Product("Product 6", "aeofjwefjwioejfiowefjwiefj", 1023, "assets/images/image1.jpg", true),
    Product("Product 7", "aeofjwefjwioejfiowefjwiefj", 1023, "assets/images/image1.jpg", false),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("Explore", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/image1.jpg",
              width: screenSize.width,
              height: 250,
              fit: BoxFit.fitWidth,
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
                        "150 Items Found",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  Icon(Icons.grid_view_rounded)
                ],
              ),
            ),
            Container(
              width: screenSize.width,
              height: 30,
              child: ListView.builder(
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
            Container(
              width: screenSize.width,
              height: 200,
              color: Colors.green,
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      width: screenSize.width - 50,
                      height: 80,
                      child: Row(
                        children: [
                          Image.asset(
                            productList[index].imageAddress,
                            width: 50,
                            height: 80,
                            fit: BoxFit.fitWidth,
                          ),
                          Column(
                            children: [
                              Text(productList[index].name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              Text(productList[index].description, style: TextStyle(fontSize: 16)),
                              Text(productList[index].price.toString(), style: TextStyle(fontSize: 16)),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: productList.length),
            )
          ],
        ),
      ),
    );
  }
}

class Product {
  String name;
  String description;
  int price;
  String imageAddress;
  bool isFavorite;

  Product(this.name, this.description, this.price, this.imageAddress, this.isFavorite);
}
