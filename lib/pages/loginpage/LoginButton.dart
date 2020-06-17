import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  LoginButton(this.clickResultFunction, {this.loginText = "Login"});

  final void Function() clickResultFunction;
  final String loginText;

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: clickResultFunction,
      child: Text(
        loginText,
        style: TextStyle(),
      ),
      borderSide: BorderSide(
        width: 1.5,
      ),
      highlightedBorderColor: Colors.tealAccent,
      splashColor: Colors.teal,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    );
  }
}
