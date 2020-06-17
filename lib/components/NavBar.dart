import 'package:flutter/material.dart';
import './LiteSpeakTitle.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  NavBar(this.heading, {this.headingSize = 20});

  final double headingSize;
  final String heading;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  // kToolBarHeight is the AppBar height constant

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Container(),
      title: LiteSpeakTitle(headingSize, data: heading),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            // TODO: Auth Management
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
