import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:litespeak/components/ImagePostCard.dart';
import 'package:litespeak/components/TextPostCard.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FlatButton(
          child: Text("Exit"),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pop(context);
          },
        ),
        leading: Container(),
      ),
      body: WillPopScope(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ImagePostCard("1"),
              TextPostCard("2"),
              ImagePostCard("3"),
            ],
          ),
        ),
        onWillPop: () async {
          return Future.value(false);
        },
      ),
    );
  }
}
