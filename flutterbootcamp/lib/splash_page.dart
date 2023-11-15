import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Row(
          children: [
            Text("Menu 1"),
            Text("Menu 2"),
            Text("Menu 3"),
            Text("Menu 4"),
            Container(
              width: 15,
              height: 10,
            ),
            Text("Menu 5"),
          ],
        ));
  }
}
