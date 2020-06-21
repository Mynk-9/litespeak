import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './pages/loginpage/LoginPage.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    statusBarColor: Colors.transparent,
  ));

  bool darkTheme = true;

  runApp(MyApp(darkTheme));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: 'LiteSpeak',
        // theme: isDark ? ThemeData.dark() : ThemeData.light(),
        theme: isDark
            ? ThemeData(
                brightness: Brightness.dark,
                primarySwatch: Colors.teal,
              )
            : ThemeData(
                brightness: Brightness.light,
                primarySwatch: Colors.cyan,
              ),
        home: LoginPage(),
      ),
    );
  }
}
