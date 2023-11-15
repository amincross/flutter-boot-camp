import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          margin: EdgeInsets.all(12),
          child: Column(
            children: [
              Text("Register Form!"),
              TextField(),
              TextField(),
              TextField(),
              TextField(),
              ElevatedButton(onPressed: () {}, child: Text("Submit"))
            ],
          ),
        ));
  }
}
