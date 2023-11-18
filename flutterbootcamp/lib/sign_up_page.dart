import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          child: Stack(
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                color: Color(0xff24750f),
                width: screenSize.width,
                height: screenSize.height * 0.4,
                child: Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Container(
                color: Colors.white,
                width: screenSize.width,
                height: screenSize.height * 0.6,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already Account?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                      "SIGN UP",
                      style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Card(
              color: Colors.white,
              elevation: 1,
              child: Container(
                width: screenSize.width - 100,
                height: screenSize.height - 250,
                margin: EdgeInsets.symmetric(horizontal: 4),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Column(
                  children: [
                    TextField(decoration: InputDecoration(hintText: "your email here")),
                    TextField(decoration: InputDecoration(hintText: "full name")),
                    TextField(decoration: InputDecoration(hintText: "phone number")),
                    TextField(decoration: InputDecoration(hintText: "password")),
                    Expanded(child: Container()),
                    FloatingActionButton(
                      onPressed: () {},
                      child: Icon(Icons.add),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
