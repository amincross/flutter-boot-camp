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
      body: Column(
        children: [
          Image.asset("assets/images/image1.jpg", width: screenSize.width, height: 250, fit: BoxFit.fitWidth),
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
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4), child: Text(categoriesList[index]));
              },
              itemCount: categoriesList.length,
            ),
          )
        ],
      ),
    );
  }
}
