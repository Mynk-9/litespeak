//import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

// import './../../components/LiteSpeakTitle.dart';
import './../../components/NavBar.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  _MainPageState();

  GlobalKey _bottomNavigationKey = GlobalKey();
  int _page = 0;

  // List<Widget> pages = [
  //   CollegeFeed(),
  //   ExploreFeed(),
  //   FamFeed(),
  //   CollegeFeed(),
  //   CollegeFeed()
  // ];

  // static const double heading_size = 20;
  static List<String> headings = [
    "College Feed",
    "Explore Feed",
    "Fam Feed",
    "User"
  ];
  // NavBar nav = NavBar(headings[0]);
  List<Widget> pages = [
    Text("A"),
    Text("B"),
    Text("C"),
    Text("D"),
  ];

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(
    //SystemUiOverlayStyle(statusBarColor: CustomSwatch.statusBarColor));
    return Scaffold(
      // backgroundColor: AppThemes.lightTheme.scaffoldBackgroundColor,
      appBar: NavBar("heading"),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.blueGrey),
          Icon(Icons.search, size: 30, color: Colors.blue),
          Icon(Icons.favorite, size: 30, color: Colors.pink),
          Icon(Icons.person, size: 30, color: Colors.green),
        ],
        // color: AppThemes.lightTheme.bottomAppBarColor,
        // backgroundColor: Theme.of(context).bottomAppBarTheme.color,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: WillPopScope(
        onWillPop: () async {
          return Future.value(false); // prevents use of back button to go back
        },
        child: pages[_page], // body
      ),
    );
  }
}
