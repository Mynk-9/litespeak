import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './pages/loginpage/LoginPage.dart';

void main() {
  bool darkTheme = true;

  if (darkTheme) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: ThemeData.dark().scaffoldBackgroundColor,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light
    ));
  } else {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: ThemeData.light().scaffoldBackgroundColor,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

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
                primarySwatch: Colors.blue,
                buttonColor: Colors.blue,
              ),
        home: LoginPage(),
      ),
    );
  }
}
